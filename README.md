# dict-cedict

A port of [CC-CEDICT] database for Dictd.
>。<br>
[![license]](/LICENSE.md)

![image](https://user-images.githubusercontent.com/17917040/87877730-94a0a700-ca12-11ea-9a89-38e7d9e04141.png)

## Dependencies

* curl (make)
* make (make)
* gzip (make)
* python (make)
* dictd (depend/make)

## Installation

```bash
make && sudo make install
```

### Options

To make full dictionary entries:

```bash
MINI=false make && sudo make install
```

To make dictionary entries indexed by their traditional variant:

```bash
SIMP=false make && sudo SIMP=false make install
```

To install both full dictionaries at once:

```bash
MINI=false make && sudo make install && MINI=false SIMP=false make && sudo SIMP=false make install
```

## [AUR](https://aur.archlinux.org/packages/dict-cedict-git/)

```bash
yay -S dict-cedict-git # for Arch-based distros
```

## Configuration

Add these lines below to `/etc/dict/dictd.conf`:

```conf
database cedict-simp {
data /usr/share/dict/cedict-simp.dict.dz
index /usr/share/dict/cedict-simp.index
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
