#!/bin/bash

set -o errexit

inkscape --export-area-page --export-background white -o twitter.png -w 400 -h 400 vector.svg
optipng -o7 twitter.png
