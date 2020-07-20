# vim:fdm=syntax
# by tuberry@github
import sys
import textwrap as tp

toneTable = dict(a = ['a','ā','á','ǎ','à'],\
                 o = ['o','ō','ó','ǒ','ò'],\
                 e = ['e','ē','é','ě','è'],\
                 i = ['i','ī','í','ǐ','ì'],\
                 u = ['u','ū','ú','ǔ','ù'],\
                 ü = ['ü','ǖ','ǘ','ǚ','ǜ'])

def index(pin):
    for h in list(toneTable.keys()):
        for j,k in enumerate(pin):
            if(h == k):
                if h == 'i' and pin[j+1] == 'u':
                    return j+1
                else:
                    return j
    return -1

def tone(pin):
    pinl = list(pin.replace('u:', 'ü'))
    if not pinl[-1].isdigit():
        return ''.join(pinl)
    idx = index(''.join(pinl))
    if(idx == -1):
        return ''.join(pinl)
    pinl[idx] = toneTable[pinl[idx]][int(pinl[-1])%5]
    return ''.join(pinl[:-1])

if __name__ == '__main__':
    with open(sys.argv[1]) as f:
        with open(sys.argv[2], 'w') as g:
            for l in f:
                if l[0] == '#':
                    continue
                ws = l.split(' ', 2)
                g.write(':'+ws[1]+':\n')
                tmp = ws[2].replace('] /', ']⋄/').split('⋄')
                g.write('[P] ' + ' '.join(map(tone, tmp[0][1:-1].split(' '))) + '\n')
                a = tmp[1][1:-2].split('/')
                for i in range(len(a)):
                    if len(a) == 1:
                        b = '\n    '.join(list(tp.wrap(a[i], 64)))
                    else:
                        b = '\n      '.join(list(tp.wrap(a[i], 64)))
                    if i == 0:
                        if len(a) == 1:
                            b = '[E] ' + b
                        else:
                            b = '[E] - ' + b
                    else:
                        b = '    - ' + b
                    g.write(b+'\n')
                g.write('[T] ' + ws[0] + '\n')
