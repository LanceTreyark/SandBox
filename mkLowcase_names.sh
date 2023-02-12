#!/bin/bash

# Convert current directory name to lowercase
dir=${PWD##*/} 
mv -T "$PWD" "$(dirname "$PWD")/$(echo "$dir" | tr '[:upper:]' '[:lower:]')"

# Convert all uppercase filenames and directory names to lowercase
find . -depth -name "*[A-Z]*" | while read f ; do mv -T "$f" "$(dirname "$f")/$(basename "$f" | tr '[:upper:]' '[:lower:]')" ; done