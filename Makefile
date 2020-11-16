VERSION=20200719
FILENAME=cedict_1_0_ts_utf-8_mdbg.txt
PKGNAME=cedict

all: build

build: $(PKGNAME).index $(PKGNAME).dict.dz

download: $(FILENAME).gz

$(FILENAME).gz:
	curl -LO https://www.mdbg.net/chinese/export/cedict/$(FILENAME).gz

$(PKGNAME).tmp: $(FILENAME).gz
	gzip -d $(FILENAME).gz && mv $(FILENAME) $(PKGNAME).tmp

$(PKGNAME).txt: $(PKGNAME).tmp
ifdef FULL
	python ./$(PKGNAME).py ./$(PKGNAME).tmp $(PKGNAME).txt
else
	python ./$(PKGNAME)s.py ./$(PKGNAME).tmp $(PKGNAME).txt
endif

$(PKGNAME).index $(PKGNAME).dict.dz: $(PKGNAME).txt
	dictfmt --utf8 --allchars -s CEDICT -u https://cc-cedict.org -j $(PKGNAME) < ./$(PKGNAME).txt
	dictzip $(PKGNAME).dict

install: $(PKGNAME).index $(PKGNAME).dict.dz
	install -Dm644 $(PKGNAME).index -t $(DESTDIR)/usr/share/dict/
	install -Dm644 $(PKGNAME).dict.dz -t $(DESTDIR)/usr/share/dict/

clean:
	-rm -f $(PKGNAME).{index,dict.dz,txt,tmp}
