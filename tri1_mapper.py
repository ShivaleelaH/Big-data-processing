#!/usr/bin/env python3

import sys

for line in sys.stdin:
    if line is not None:
        line = line.strip()
        print(line)
