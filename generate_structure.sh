#!/usr/bin/env bash
set -euo pipefail

# Create directories safely without overwriting existing files
mkdir -p \
  01_Basics \
  02_Functions_Files \
  03_OOP_Project \
  04_Statistics_Basics \
  99_Tools/scripts \
  99_Tools/lint \
  99_Tools/ci \
  tests

# Create Day1-Day7 notebook templates inside 01_Basics
for day in {1..7}; do
  notebook="01_Basics/Day${day}.ipynb"
  if [ -e "$notebook" ]; then
    echo "Skip existing file: $notebook"
  else
    cat <<NB > "$notebook"
{
 "cells": [
  {
   "cell_type": "markdown",
   "metadata": {},
   "source": [
    "# Day ${day}\\n",
    "\\n",
    "This is a template notebook."
   ]
  }
 ],
 "metadata": {
  "kernelspec": {
   "display_name": "Python 3",
   "language": "python",
   "name": "python3"
  },
  "language_info": {
   "name": "python",
   "pygments_lexer": "ipython3"
  }
 },
 "nbformat": 4,
 "nbformat_minor": 5
}
NB
    echo "Created file: $notebook"
  fi
done

# Helper function to safely create files with content
create_file() {
  local file="$1"
  if [ -e "$file" ]; then
    echo "Skip existing file: $file"
  else
    cat > "$file"
    echo "Created file: $file"
  fi
}

create_file ".gitignore" <<'EOF_GIT'
# Python
__pycache__/
*.py[cod]
*.pyo
*.pyd
*.so

# Virtual environments
venv/
.env/
.venv/

# Jupyter checkpoints
.ipynb_checkpoints/
EOF_GIT

create_file "requirements.txt" <<'EOF_REQ'
pandas
numpy
matplotlib
scipy
scikit-learn
jupyter
ipykernel
pytest
black
flake8
EOF_REQ

create_file "pyproject.toml" <<'EOF_PY'
[tool.black]
line-length = 88
target-version = ["py39"]
include = "\\.pyi?$"
exclude = """
/(\n    \\.(git|hg|svn)\n  | \\_build\n  | buck-out\n  | build\n  | dist\n)/
"""

[tool.flake8]
max-line-length = 88
extend-ignore = ["E203", "W503"]
exclude = [
  ".git",
  "__pycache__",
  "build",
  "dist",
  "venv",
  ".venv"
]
EOF_PY

year=$(date +%Y)
create_file "LICENSE" <<EOF_LICENSE
MIT License

Copyright (c) ${year}

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
EOF_LICENSE

cat <<'EOF_INFO'

Setup complete.
To use this script:
1. Save it as generate_structure.sh
2. Make it executable: chmod +x generate_structure.sh
3. Run: ./generate_structure.sh

EOF_INFO
