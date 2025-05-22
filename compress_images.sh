#!/bin/bash

# Create optimized directory
mkdir -p images/optimized

# Function to compress an image
compress_image() {
    local input="$1"
    local output="images/optimized/$(basename "$input")"
    
    echo "Compressing $input..."
    
    # For PNG files
    if [[ "$input" == *.png ]]; then
        convert "$input" -strip -quality 75 -resize "1200x1200>" -define png:compression-level=9 -define png:compression-strategy=0 "$output"
    # For JPG/JPEG files
    elif [[ "$input" == *.jpg ]] || [[ "$input" == *.jpeg ]]; then
        convert "$input" -strip -quality 75 -resize "1200x1200>" "$output"
    fi
    
    # Check if compression was successful
    if [ $? -eq 0 ]; then
        echo "Successfully compressed $input"
    else
        echo "Failed to compress $input"
        return 1
    fi
}

# Process all images in the images directory and its subdirectories
find images -type f \( -iname "*.png" -o -iname "*.jpg" -o -iname "*.jpeg" \) | while read -r img; do
    compress_image "$img"
done

echo "Image compression complete!" 