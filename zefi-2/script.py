import re
import os
import sys

# p = re.compile(".*[a-zA-Z]{4}[0-9]{5}$")
p = re.compile(".*(ARCH|COLL)[0-9]{5}[^/]*$")

f_match = open(sys.argv[1] + ".match", 'w')
f_no_match = open(sys.argv[1] + ".nomatch", 'w')

for base, dirs, files in os.walk(os.path.abspath(sys.argv[1]), topdown=True):
    if p.match(base):
        # print(base)
        f_match.write(base)
        f_match.write('\n')
        dirs[:] = []
        files[:] = []
    else:
        f_no_match.write(base)
        f_no_match.write('\n')

f_match.close()
f_no_match.close()