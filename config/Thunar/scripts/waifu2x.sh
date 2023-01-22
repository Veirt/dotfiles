#!/bin/bash

for image in "$@"; do
    output="${image%.*}_waifu2x.png"
    waifu2x-ncnn-vulkan -n 3 -s 2 -i "$image" -o "$output"
done
