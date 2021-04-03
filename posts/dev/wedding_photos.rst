.. title: Using exiftool and Python to fix photos (edit: to order them)
.. slug: wedding_photos
.. date: 2007-06-20 10:50:45
.. tags: dev, software, python, photos

S and I decided to get a wedding photographer [1]_in addition to allowing
our guests to take as many photos as they wanted of all aspects of our
wedding (except when we were getting dressed [and ...  undressed]).
There were a few reasons for this one of which being the several horror
stories we've heard about people's digital media dying causing them to
lose all pictures of their wedding.  Ick.

The problem is that there are a fajillion pictures and it's really 
hard to order them into a single consistent timeline.  The wedding 
photographer we had<sup>1</sup> had four cameras and took some 800 
pictures.  My dad took another 100 or so.  Other people took a bunch, 
too.  Right now I'm working with 1200+ pictures all of which are pretty 
big (between 5 MB and 10 MB each).  It's not feasible to tweak them all 
by hand to order them.  I didn't want to leave them unordered--my soul 
shudders at that thought.  I needed a way to do batch processing to 
reorder pictures from a bunch of cameras into a nice timeline.

.. TEASER_END


First thing I did was put all the pictures that had no EXIF information to
the side.  There weren't many of them and I don't see any way to batch
process them.

We're now left with 1000+ pictures all of which have EXIF information that
we can work with.  Interesting properties of the problem:

* all of the pictures have DateTimeOriginal and SerialNumber headers
  in the EXIF data
* pictures from a single camera have a consistent timeline in the sense
  that if picture 2 from camera A comes before picture 3 from camera A by 
  14 seconds, then that's what happened
* the time from all the pictures from camera A are a constant offset
  from all the pictures from camera B

This is all pretty obvious and there's nothing exciting here, but it does
reduce the problem to picking a camera as a baseline and then figuring out
how far off in seconds and minutes the other cameras are from the baseline.
That's pretty easy.

First thing I do is get 
`exiftool <http://www.sno.phy.queensu.ca/~phil/exiftool/>`_
run it like this to rename all the files according to their timestamp
and serialnumber:

.. code-block:: shell

   exiftool '-FileName<${DateTimeOriginal}_${SerialNumber}.jpg' \
            -d "%Y%m%d_%H%M%S" .


Then I copied all the files into a <code>thumbs</code> directory and
in the thumbs directory I used mogrify which comes with 
`ImageMagick <http://www.imagemagick.org/script/index.php>`_
to create thumbnails:
>
.. code-block:: shell

   for i in `ls *.jpg`; do mogrify -quality 65 -geometry 150; done


Then I did this to figure out all the serial numbers of the cameras
that took these photos:

.. code-block:: shell

   exiftool -SerialNumber *.jpg | sort -u


Then I wrote a Python script (any language will do) to build an index
of the images using timeline offsets:

.. code-block:: python

   import os, time, datetime

   # serial number -&gt; (offset(minute, second), color)
   OFFSETS = { "1020415017": ((0, 37), "#ff5555"), # red
               "1420918126": ((1, 11), "#ff55ff"), # purple
               "1621009923": ((1, 9), "#55ff55"),  # green
               "620306618": ((0, 0), "#5555ff") }  # blue (baseline)

   def getinfo(fn):
      t = fn.split("-", 1)[1]
      t = t.split("_", 1)

      cam = t[1]
      cam = cam.split(".")[0]

      t = t[0]

      print fn, t

      t = time.strptime(t, "%H%M%S")

      # hardcoded year, month, and day
      t = datetime.datetime(2007, 05, 26, t[3], t[4], t[5])

      offset = OFFSETS[cam][0]

      t = t - datetime.timedelta(0, offset[1], 0, 0, offset[0])
      return (t, cam, fn)

   def build():
      files = os.listdir(os.getcwd())
      files = [f for f in files if f.endswith(".jpg")]

      pics = [ getinfo(fn) for fn in files ]

      pics.sort()

      out = open("index.html", "w")
      out.write("&lt;html&gt;&lt;body&gt;&lt;table border=\"1\"&gt;\n")

      for t, cam, fn in pics:
         out.write("""
   <tr><td>
     <table>
       <tr><td bgcolor="#aaaaaa">name</td><td>%s</td></tr>
       <tr><td bgcolor="#aaaaaa">camera</td><td bgcolor="%s">%s</td></tr>
       <tr><td bgcolor="#aaaaaa">datestamp</td><td>%s</td></tr>
     </table>
   </td><td><img src="%s"></td></tr>""" % (fn, offsets[cam][1], cam, repr(t), fn))

      out.write("&lt;/table&gt;&lt;/body&gt;&lt;/html&gt;")
      out.close()

   if __name__ == "__main__":
      build()


Note that I color-code the cameras.  I find this makes it really easy
to eyeball the timeline without trying to distinguish between 
similar-looking serial numbers.

I run that in my thumbs directory and it builds an ``index.html``
page that I can look at with a web-browser.  The ``index.html`` has
the offsets factored in.  I look through the pictures and tweak the 
offsets until all the cameras are consistent with one timeline.  Once I 
have a final set of offsets, I go through the pictures for each camera 
and (very carefully) do this:

.. code-block:: shell

   exiftool "-AllDates-=0:0:0 0:M:S" *SN.jpg
                                ^ ^   ^^


replacing:

* M with the minute offset,
* S with the second offset, and
* SN with the camera serial number

Then you do another pass at renaming files and the files should then
be in the same consistent timeline and in alphabetical order by filename.

After I worked out the process it took a couple of hours.  We had the
advantage of having a couple of points during the wedding where a lot
of photographs were taken and it was obvious as to what order they needed
to be in.

.. [1] `<http://www.jillgoldman.com/>`_ Jill is awesome.

**Updates:**

06/21/2007 - Changed the title to something more appropriate.  I was thinking
"fix" because I was modifying the EXIF metadata for each photo to put them
in the correct order, but `Konquest makes a good point
<https://www.reddit.com/r/programming/comments/202vq/using_exiftool_and_python_to_fix_photos/c204pk/?context=3>`_.
I also fixed one of the command lines.

06/22/2007 - bockris said in the reddit.com comments:

   This is a good idea. I've had to fix the EXIF data my photos before 
   because I changed the batteries and didn't reset the date but I've never 
   tried to sync up multiple cameras after the fact.

   If I'm ever in a similar situation as the OP, I think I have everyone 
   take a picture of a clock with a second hand at some period during the 
   event. That would let you easily get the time difference among all 
   cameras.

That's a good idea.
