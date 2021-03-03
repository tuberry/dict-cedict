FILENAME=cedict_1_0_ts_utf-8_mdbg.txt
PKGNAME=cedict

all: $(PKGNAME).index $(PKGNAME).dict.dz

$(FILENAME):
	curl -LO https://www.mdbg.net/chinese/export/cedict/$(FILENAME).gz && gzip -d $(FILENAME).gz

$(PKGNAME).txt: $(FILENAME)
ifdef FULL
	python ./$(PKGNAME).py ./$(FILENAME) $(PKGNAME).txt
else
	python ./$(PKGNAME)s.py ./$(FILENAME) $(PKGNAME).txt
endif

$(PKGNAME).index $(PKGNAME).dict.dz: $(PKGNAME).txt
	dictfmt --utf8 --allchars -s CEDICT -u https://cc-cedict.org -j $(PKGNAME) < ./$(PKGNAME).txt
	dictzip $(PKGNAME).dict

install: $(PKGNAME).index $(PKGNAME).dict.dz
	install -Dm644 $(PKGNAME).index -t $(DESTDIR)/usr/share/dictd/
	install -Dm644 $(PKGNAME).dict.dz -t $(DESTDIR)/usr/share/dictd/

clean_:
	-rm -f $(PKGNAME).{index,dict.dz,txt}

clean: clean_
	-rm -f $(FILENAME)
