# dict-cedict
> A port of [CC-CEDICT] database for Dictd<br>
[![license]](/LICENSE)

![image](https://user-images.githubusercontent.com/17917040/87877730-94a0a700-ca12-11ea-9a89-38e7d9e04141.png)

## Installation

### Requirements
1. curl
2. python3
3. dictd
4. make

### Build && Install
```Makefile
make # FULL=true
sudo make install
```
Also it's avaliable in [AUR](https://aur.archlinux.org/packages/dict-cedict-git/):
```
yay -S dict-cedict-git
```

### Configuration
Add these lines below in `/etc/dict/dictd.conf`:
```dictdconf
database cedict {
data /usr/share/dict/cedict.dict.dz
index /usr/share/dict/cedict.index
}
```
Then restart `dictd.service`:
```shell
systemctl restart dictd
```

## Acknowledgements
1. [CC-CEDICT](https://www.mdbg.net/chinese/dictionary?page=about): Licensed under [Creative Commons 4.0](https://creativecommons.org/licenses/by-sa/4.0). All rights reserved by the authors.
2. [dictd](https://en.wikipedia.org/wiki/DICT): Dict file format.

[CC-CEDICT]:https://www.mdbg.net/chinese/dictionary?page=about
[license]: https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg
