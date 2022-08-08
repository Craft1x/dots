#!/usr/bin/env python3
import colorsys
import sys
import matplotlib

rgb=matplotlib.colors.to_rgb(sys.argv[1])
hsv=colorsys.rgb_to_hsv(rgb[0],rgb[1],rgb[2])
rgb=colorsys.hsv_to_rgb(hsv[0],0.4,1)

print(matplotlib.colors.to_hex(rgb))
