#!/bin/bash 
## Dependencies: tesseract-ocr imagemagick gnome-screenshot xclip

exec 2>> /var/log/forcegrab.log
## Save stderr & append to log for troubleshooting

TIME_CREATED="$(date +"%d%H%M%S")"
## Use date format for image & text name: help [$ man date]


PATH_TO_FILE="${BASH_SOURCE/*}/tmp"
## BASH_SOURCE is an internal bash variable
## "http://mywiki.wooledge.org/BashFAQ/028"


CURRENT_IMAGE="$PATH_TO_FILE/$TIME_CREATED-image"
CURRENT_TEXT="$PATH_TO_FILE/$TIME_CREATED-text"

################## SETUP #####################


gnome-screenshot -a -f $CURRENT_IMAGE.tiff 
## take screen shot and save to file

convert $CURRENT_IMAGE.tiff -resize 125% -density 300 $CURRENT_IMAGE.tiff
## Increase dpi of image

tesseract $CURRENT_IMAGE.tiff $CURRENT_TEXT
## OCR processing

cat $CURRENT_TEXT.txt | xclip -selection clipboard
## Add tesseract results to clipboard


exit
