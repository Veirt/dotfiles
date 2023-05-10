#!/bin/bash

# $@: all arguments
for FILE in "$@"; do
    OUTPUT="$(basename "$FILE" .wav).flac"

    ffmpeg -loglevel warning -i "$FILE" -c:v copy "$OUTPUT"
done
