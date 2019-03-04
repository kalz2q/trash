import os
import sys

def reverse_file(path):
    assert os.path.exists(path)
    assert os.path.isfile(path)
    abspath = os.path.abspath(path)
    print(abspath)
    with open(abspath) as f:
        ss_old = f.readlines()
    ss_new = reverse_lines(ss_old)
    with open(abspath, "w") as f:
        f.writelines(ss_new)

def reverse_lines(ss):
    return reversed(ss)

if __name__ == "__main__":
    assert len(sys.argv) == 2
    reverse_file(sys.argv[1])
