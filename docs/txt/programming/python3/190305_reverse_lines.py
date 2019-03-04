import os
import sys

def reverse_file(path):
    assert os.path.exists(path)
    assert os.path.isfile(path)
    abspath = os.path.abspath(path)
    print(abspath)
    with open(abspath) as f:
        s_old = f.read()
    s_new = reverse_lines(s_old)
    with open(abspath, "w") as f:
        f.write(s_new)

def reverse_lines(s):
    liness = s.split("\n\n");
    def f(s):
        lines = s.split("\n")
        r = reversed(lines)
        return "\n".join(r)
    liness = [f(x) for x in liness]
    s_new = "\n\n".join(liness)
    return s_new

if __name__ == "__main__":
    assert len(sys.argv) == 2
    reverse_file(sys.argv[1])
