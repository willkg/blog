@_default:
    just --list

# Build a development environment
devenv:
    uv sync --refresh --upgrade

# List status
status:
    uv run python --version
    uv pip list

# Wipe devenv and build artifacts
clean: 
    rm -rf .venv uv.lock
    rm -rf output cache
    find -name __pycache__ | xargs rm -rf
    find -name '*.pyc' | xargs rm -rf

# Compile blog
compile: devenv
    mkdir output || true
    uv run nikola build -a -n 5

# Update compile blog
update: devenv
    mkdir output || true
    uv run nikola build

# Create a new post: -t TITLE path/to/post.rst
new-post *args: devenv
    uv run nikola new_post {{args}}

# View blog
view: devenv
    xdg-open output/index.html

# Compile and update whenever the rst file changes
draft: devenv
    uv run nikola auto -b
