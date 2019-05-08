#!/bin/bash

set -o errexit

inkscape --export-area-page --export-background white -z -e reddit.png -w 256 -h 256 vector.svg
optipng -o7 reddit.png
