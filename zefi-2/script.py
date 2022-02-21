import re
import os
import sys

p = re.compile(".*[a-zA-Z]{4}[0-9]{5}$")

for base, dirs, files in os.walk(os.path.abspath(sys.argv[1]), topdown=True):
    if p.match(base):
        print(base)
        del dirs