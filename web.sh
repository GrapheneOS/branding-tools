#!/bin/bash

set -o errexit

inkscape --export-area-page -o web.png -w 512 -h 512 vector.svg
optipng -o7 web.png
