VERSION=20200719
FILENAME=cedict_1_0_ts_utf-8_mdbg.txt

all: build

build: cedict.index cedict.dict.dz

build_simp: cedicts.index cedicts.dict.dz

download: $(FILENAME).gz

$(FILENAME).gz:
	curl -LO https://www.mdbg.net/chinese/export/cedict/$(FILENAME).gz

cedict.tmp: $(FILENAME).gz
	gzip -d $(FILENAME).gz && mv $(FILENAME) cedict.tmp

cedict.txt: cedict.tmp
	python ./cedict.py ./cedict.tmp cedict.txt

cedicts.txt: cedict.tmp
	python ./cedicts.py ./cedict.tmp cedicts.txt

cedict.index cedict.dict.dz: cedict.txt
	dictfmt --utf8 --allchars -s CEDICT -u https://cc-cedict.org -j cedict < ./cedict.txt
	dictzip cedict.dict

cedicts.index cedicts.dict.dz: cedicts.txt
	dictfmt --utf8 --allchars -s CEDICTS -u https://cc-cedict.org -j cedicts < ./cedicts.txt
	dictzip cedicts.dict

install: cedict.index cedict.dict.dz
	install -Dm644 cedict.index -t $(DESTDIR)/usr/share/dict/
	install -Dm644 cedict.dict.dz -t $(DESTDIR)/usr/share/dict/

install_simp: cedicts.index cedicts.dict.dz
	install -Dm644 cedicts.index -t $(DESTDIR)/usr/share/dict/
	install -Dm644 cedicts.dict.dz -t $(DESTDIR)/usr/share/dict/

clean:
	rm -f cedict{,s}.{index,dict.dz,txt,tmp}
