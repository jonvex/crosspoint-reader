#!/bin/bash

set -e

cd "$(dirname "$0")"

READER_FONT_STYLES=("Regular" "Italic" "Bold" "BoldItalic")
BOOKERLY_SIZE_NAMES=("s" "m" "l" "xl")
BOOKERLY_FONT_SIZES=(16 18 20 22)

for i in "${!BOOKERLY_FONT_SIZES[@]}"; do
  size=${BOOKERLY_FONT_SIZES[$i]}
  size_name=${BOOKERLY_SIZE_NAMES[$i]}
  for style in ${READER_FONT_STYLES[@]}; do
    font_name="bookerly_${size_name}_$(echo $style | tr '[:upper:]' '[:lower:]')"
    font_path="../builtinFonts/source/Bookerly/Bookerly-${style}.ttf"
    output_path="../builtinFonts/${font_name}.h"
    python3 fontconvert.py $font_name $size $font_path --2bit --compress --pnum > $output_path
    echo "Generated $output_path"
  done
done

UI_FONT_SIZES=(10 12)
UI_FONT_STYLES=("Regular" "Bold")

for size in ${UI_FONT_SIZES[@]}; do
  for style in ${UI_FONT_STYLES[@]}; do
    font_name="ubuntu_${size}_$(echo $style | tr '[:upper:]' '[:lower:]')"
    font_path="../builtinFonts/source/Ubuntu/Ubuntu-${style}.ttf"
    output_path="../builtinFonts/${font_name}.h"
    python3 fontconvert.py $font_name $size $font_path > $output_path
    echo "Generated $output_path"
  done
done

python3 fontconvert.py notosans_8_regular 8 ../builtinFonts/source/NotoSans/NotoSans-Regular.ttf > ../builtinFonts/notosans_8_regular.h

echo ""
echo "Running compression verification..."
python3 verify_compression.py ../builtinFonts/
