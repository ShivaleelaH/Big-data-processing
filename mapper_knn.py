#! /usr/bin/env python3

import sys
import math
import numpy as np

for line in sys.stdin:
	line = line.strip()
	line = line.split(",")
	if(len(line) == 49):
		print("%s\t%s" % ("train",line))
	else:
		print("%s\t%s" % ("test",line))
