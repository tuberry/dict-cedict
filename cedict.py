#!/usr/bin/env python
# -*- coding: UTF-8 -*-

import argparse
import textwrap as tp

tones = dict(a = ['a','ā','á','ǎ','à'],\
             o = ['o','ō','ó','ǒ','ò'],\
             e = ['e','ē','é','ě','è'],\
             i = ['i','ī','í','ǐ','ì'],\
             u = ['u','ū','ú','ǔ','ù'],\
             ü = ['ü','ǖ','ǘ','ǚ','ǜ'])

def main():
    args = parser()
    if args.mini:
        cedicts(args.input, args.output)
    else:
        cedict(args.input, args.output)

def parser():
    agp = argparse.ArgumentParser()
    agp.add_argument('-i', '--input', help='specify the input file')
    agp.add_argument('-o', '--output', help='specify the output file')
    agp.add_argument('-m', '--mini', default=True, action=argparse.BooleanOptionalAction,
                     help='keep words and their definitions only')
    return agp.parse_args()

def index(pin):
    for h in list(tones.keys()):
        for j, k in enumerate(pin):
            if(h != k): continue
            return (j + 1) if h == 'i' and pin[j+1] == 'u' else j
    return -1

def tone(pin):
    pins = list(pin.replace('u:', 'ü'))
    if not pins[-1].isdigit(): return ''.join(pins)
    idx = index(''.join(pins))
    if(idx == -1): return ''.join(pins)
    pins[idx] = tones[pins[idx]][int(pins[-1]) % 5]
    return ''.join(pins[:-1])

def cedicts(ifile, ofile):
    with open(ifile) as f:
        with open(ofile, 'w') as g:
            for l in f:
                if l[0] == '#': continue
                ws = l.split(' ', 2)
                g.write(':' + ws[1] + ':\n')
                a = (ws[2].replace('] /', ']⋄/').split('⋄'))[1][1:-2].split('/')
                for i in range(len(a)):
                    g.write('\n'.join(list(tp.wrap(a[i], 64))) + '\n')

def cedict(ifile, ofile):
    with open(ifile) as f:
        with open(ofile, 'w') as g:
            for l in f:
                if l[0] == '#': continue
                ws = l.split(' ', 2)
                g.write(':' + ws[1] + ':\n')
                t = ws[2].replace('] /', ']⋄/').split('⋄')
                g.write('[P] ' + ' '.join(map(tone, t[0][1:-1].split(' '))) + '\n')
                a = t[1][1:-2].split('/')
                for i in range(len(a)):
                    b = ('\n    ' if len(a) == 1 else '\n      ').join(list(tp.wrap(a[i], 64)))
                    g.write((('[E] ' if len(a) == 1 else '[E] - ') if i == 0 else '    - ') + b + '\n')
                g.write('[T] ' + ws[0] + '\n')

if __name__ == '__main__':
    main()
