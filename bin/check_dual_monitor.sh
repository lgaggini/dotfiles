#!/bin/bash

xrandr -q | grep DP3 | grep -q " connected" && xrandr -q | grep VGA1 | grep -q " connected"
echo $?
