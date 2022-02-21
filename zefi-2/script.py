import re
import os

p = re.compile(".*[a-zA-Z]{4}[0-9]{5}$")

for base, dirs, files in os.walk("/Users/gkarlos/Documents", topdown=True):
    if p.match(base):
        print(base)
        del dirs