#!/bin/bash

set -o errexit

inkscape --export-area-page --export-background white -z -e opengraph.png -w 512 -h 512 vector.svg
optipng -o7 opengraph.png
