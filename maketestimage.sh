#!/bin/sh -e

export ZOPFLIPNG=/usr/local/bin

convert -size 200x200 \
        -gravity center \
        -font Helvetica \
        -pointsize 20 \
        label:"1991-02-18 Monday"\
        out.png

if [ -f "out.png" ]; then
    touch -t 199102180000.00 out.png
else
    echo "Can't create test png file."
    echo "Please check the imagemagick has installed."
    exit 1
fi

./kai_zopflipng.sh out.png

if [ -f "OK/out.png" ]; then
    DATE=$(ls -l "OK/out.png" | awk '{print $6.$7.$8}')
    if [ "${DATE}" = "Feb181991" ]; then
        echo "OK"
        exit 0
    else
        echo "The date is not correctly applied."
        exit 3
    fi
    echo "No OK/out.png exist. The kai_zopflipng.sh may not correctly implemented."
    exit 2
fi
