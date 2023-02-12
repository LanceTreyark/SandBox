#!/bin/bash

# Replace underscores with dashes in all filenames and directory names
find . -depth -name "*_*" | while read f ; do mv -T "$f" "$(dirname "$f")/$(basename "$f" | tr '_' '-')" ; done