FILENAME=cedict_1_0_ts_utf-8_mdbg.txt
PKGNAME=cedict

ifndef MINI
	MINI=true
endif

all: $(PKGNAME).index $(PKGNAME).dict.dz

$(FILENAME):
	curl -LO https://www.mdbg.net/chinese/export/cedict/$(FILENAME).gz && gzip -d $(FILENAME).gz

$(PKGNAME).txt: $(FILENAME)
ifeq ($(MINI),true)
	python ./$(PKGNAME).py -i ./$(FILENAME) -o $(PKGNAME).txt
else
	python ./$(PKGNAME).py -i ./$(FILENAME) -o $(PKGNAME).txt --no-mini
endif

$(PKGNAME).index $(PKGNAME).dict.dz: $(PKGNAME).txt
	dictfmt --utf8 --allchars -s CEDICT -u https://cc-cedict.org -j $(PKGNAME) < ./$(PKGNAME).txt
	dictzip $(PKGNAME).dict

install: $(PKGNAME).index $(PKGNAME).dict.dz
	install -Dm644 $(PKGNAME).index -t $(DESTDIR)/usr/share/dictd/
	install -Dm644 $(PKGNAME).dict.dz -t $(DESTDIR)/usr/share/dictd/

_clean:
	rm -f $(FILENAME)

clean: _clean
	rm -f $(PKGNAME).{index,dict.dz,txt}
