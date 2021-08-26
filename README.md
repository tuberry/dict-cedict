# dict-cedict

A port of [CC-CEDICT] database for Dictd.
>。<br>
[![license]](/LICENSE)

![image](https://user-images.githubusercontent.com/17917040/87877730-94a0a700-ca12-11ea-9a89-38e7d9e04141.png)

## Dependencies

* curl (makedpends)
* python3 (makedepends)
* make (makedepends)
* dictd (depends/makedepends)

## Build && Installation

```bash
make # MINI=false
sudo make install
```

## [AUR](https://aur.archlinux.org/packages/dict-cedict-git/)

```bash
yay -S dict-cedict-git # for Arch-based distros
```

## Configuration

Add these lines below to `/etc/dict/dictd.conf`:

```conf
database cedict {
data /usr/share/dict/cedict.dict.dz
index /usr/share/dict/cedict.index
}
```

Then restart `dictd.service`:

```bash
systemctl restart dictd
```

## Acknowledgements

* [dictd]: DICT file format
* [CC-CEDICT]: licensed under [Creative Commons 4.0](https://creativecommons.org/licenses/by-sa/4.0), all rights reserved by the authors

[CC-CEDICT]:https://www.mdbg.net/chinese/dictionary?page=about
[license]:https://img.shields.io/badge/License-CC%20BY--SA%204.0-lightgrey.svg
[dictd]:https://en.wikipedia.org/wiki/DICT