#!/bin/bash

set -o errexit

inkscape --export-area-page --export-background white -o play_store_developer_header_center.png -w 2000 -h 2000 vector.svg
convert play_store_developer_header_center.png -gravity center -extent 4096x2304 play_store_developer_header.png
optipng -o7 play_store_developer_header.png
