#!/bin/bash

set -o errexit

inkscape --export-area-page --export-background white -o play_store_developer.png -w 512 -h 512 vector.svg
optipng -o7 play_store_developer.png
