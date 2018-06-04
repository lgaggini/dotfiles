#!/bin/bash

xrandr -q | grep DP3 | grep -q " connected"
echo $?
