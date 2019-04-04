import sys

with open(sys.argv[1], "r") as f:
    lines = f.readlines()
with open(sys.argv[1], "w") as f:
    f.writelines(reversed(lines))
