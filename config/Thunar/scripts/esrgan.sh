#!/bin/bash

for image in "$@"; do
    output="${image%.*}_waifu2x.png"
    realesrgan-ncnn-vulkan -i "$image" -o "$output"
done
