#!/bin/bash

Xvfb :1 -screen 0 1024x768x16 -extension RANDR &> xvfb.log  &
DISPLAY=:1.0
export DISPLAY

pybot --variable BROWSER:firefox /tmp/webtest.robot
