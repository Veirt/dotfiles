#!/bin/bash

for image in "$@"; do
    output="${image%.*}_esrgan.png"
    realesrgan-ncnn-vulkan -i "$image" -o "$output"
done
