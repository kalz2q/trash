import html
import os
import re
import sys
import time

header = """<!DOCTYPE html>
<html lang="ja">
  <head>
    <meta charset="utf-8">
    <style>
body {
    font-family: monospace;
}
.pre {
    white-space: pre-wrap;
}
    </style>
    <script>
up = false;
prev = false;
next = false;
window.document.onkeydown = function(e) {
    if (e.key == 'Backspace')
        history.back();
    if (e.key == 'i')
        if (up)
            window.location.href = up;
    if (e.key == 'ArrowLeft')
        if (prev)
            window.location.href = prev;
    if (e.key == 'ArrowRight')
        if (next)
            window.location.href = next;
};
    </script>
  </head>
  <body>
"""

footer = """  </body>
</html>
"""

def encode(s):
    """Returns a string which is html encoded from the string s."""
    s = html.escape(s)
    # s = re.sub(r"\n", "<br>\n", s)
    # s = re.sub(r" ", "&nbsp;", s)
    return s

def get_lens(root_src):
    """Returns a dictionary from a file path to the number of characters in the file."""
    lens = {}
    for dirpath, dirnames, filenames in os.walk(root_src, topdown=False):
        total = 0
        for filename in filenames:
            file_src = os.path.join(dirpath, filename)
            with open(file_src, "r") as f:
                l = len(f.read())
            lens[file_src] = l
            total += l
        for dirname in dirnames:
            dir_src = os.path.join(dirpath, dirname)
            total += lens[dir_src]
        lens[dirpath] = total
    return lens

def main():
    n_args = len(sys.argv) - 1
    if n_args != 2:
        # print("Number of arguments should be 2. Using default.")
        root_src = "."
        root_dst = "../htmltxt"
    else:
        root_src = html.escape(os.path.abspath(sys.argv[1]))
        root_dst = html.escape(os.path.abspath(sys.argv[2]))

    if not os.path.exists(root_src):
        print("Path", root_src, "does not exist. Terminating.")
        return
    if not os.path.isdir(root_src):
        print("Source is not directory. Terminating.")
        return
    print("Number of files:",
          sum([len(xs) for _, _, xs in os.walk(root_src)]))

    if os.path.exists(root_dst):  # Creates a backup.
        s_time = str(int(time.time()))
        os.rename(root_dst, root_dst + "_bak" + s_time)
    os.mkdir(root_dst)

    for dirpath, dirnames, filenames in os.walk(root_src):  # For each directory in the tree.
        dirnames = list(map(html.escape, dirnames))
        filenames = list(map(html.escape, filenames))
        dirnames.sort()
        filenames.sort()
        heading = dirpath + "/"
        heading = re.sub("^" + root_src, "", heading)

        for dirname in dirnames:  # Makes directories.
            dir_src = os.path.join(dirpath, dirname)
            dir_dst = dir_src
            dir_dst = re.sub(r"^" + root_src, root_dst, dir_dst)
            os.mkdir(dir_dst)

        for i in range(len(filenames)):  # Creates each articles.
            prev, next = False, False
            filename = filenames[i]
            if i >= 1:
                prev = filenames[i - 1]
            if i < len(filenames) - 1:
                next = filenames[i + 1]
            file_src = os.path.join(dirpath, filename)
            file_dst = file_src
            file_dst = re.sub(r"^" + root_src, root_dst, file_dst)
            file_dst += ".html"

            s_links = "    <ul>\n"
            s_links += '      <li><a href="index.html">' + heading + '</a> (' + filename + ')</li>\n'
            s_links += "      <script>up='index.html'</script>\n"
            if prev:
                s_links += '      <li><a href="' + prev + '.html">prev: ' + prev + '</a></li>\n'
                s_links += "      <script>prev='" + prev + ".html'</script>\n"
            else:
                s_links += '      <li>(no prev)</li>\n'
            if next:
                s_links += '      <li><a href="' + next + '.html">next: ' + next + '</a></li>\n'
                s_links += "      <script>next='" + next + ".html'</script>\n"
            else:
                s_links += '      <li>(no next)</li>\n'
            s_links += "    </ul>\n"
            with open(file_src, "r") as f:
                s = f.read()
            s = header + s_links + '    <div class="pre">' + encode(s) + '</div>\n' + footer
            with open(file_dst, "a") as f:
                f.write(s)

        lens = get_lens(root_src)
        path_index = os.path.join(re.sub(r"^" + root_src, root_dst, dirpath),
                                  "index.html")
        s = "    <h1>" + heading + "</h1>\n"
        s += "    <ul>\n"
        if dirpath != root_src:
            s += '      <li><a href="../index.html">..</a></li>\n'
        for dirname in dirnames:
            s_len = "{:,}".format(lens[os.path.join(dirpath, dirname)])
            path_relative = os.path.join(dirname, "index.html")
            s += '      <li><a href="' + path_relative + '">' + dirname + '/&nbsp;&nbsp;(' + s_len +  ')</a></li>\n'
        for filename in filenames:
            path_relative = filename + ".html"
            s_len = "{:,}".format(lens[os.path.join(dirpath, filename)])
            s += '      <li><a href="' + path_relative + '">' + filename + '&nbsp;&nbsp;(' + s_len + ')</a></li>\n'
        s += "    </ul>\n"
        s = header + s + footer
        with open(path_index, "a") as f:
            f.write(s)
    print("Done.")

if __name__ == "__main__":
    main()
