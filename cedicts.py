# vim:fdm=syntax
# by tuberry@github
import subprocess
import textwrap as tp

if __name__ == '__main__':
    with open('./cedict.tmp') as f:
        with open('cedicts.txt', 'w') as g:
            for l in f:
                if l[0] == '#':
                    continue
                ws = l.split(' ', 2)
                g.write(':'+ws[1]+':\n')
                tmp = ws[2].replace('] /', ']⋄/').split('⋄')
                a = tmp[1][1:-2].split('/')
                for i in range(len(a)):
                    b = '\n'.join(list(tp.wrap(a[i], 64)))
                    g.write(b+'\n')
    subprocess.call('dictfmt --utf8 --allchars -s CEDICTS -u https://cc-cedict.org -j cedicts < ./cedicts.txt', shell=True)
    subprocess.call('dictzip cedicts.dict', shell=True)
