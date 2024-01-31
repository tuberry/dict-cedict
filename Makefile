pkg := cedict
txt := cedict_1_0_ts_utf-8_mdbg.txt
aim := $(pkg).index $(pkg).dict.dz

# as brief as possible or not
MINI ?= true

.PHONY: all clean _clean

all: $(aim)

$(txt):
	curl -LO https://www.mdbg.net/chinese/export/cedict/$(txt).gz && gzip -d $(txt).gz

$(pkg).txt: $(txt)
ifeq ($(MINI),true)
	python ./$(pkg).py -i ./$(txt) -o $(pkg).txt
else
	python ./$(pkg).py -i ./$(txt) -o $(pkg).txt --no-mini
endif

$(aim) &: $(pkg).txt
	dictfmt --utf8 --allchars -s CEDICT -u https://cc-cedict.org -j $(pkg) < ./$(pkg).txt && dictzip $(pkg).dict

install: $(aim)
	install -Dm644 $(pkg).index -t $(DESTDIR)/usr/share/dictd/
	install -Dm644 $(pkg).dict.dz -t $(DESTDIR)/usr/share/dictd/

_clean:
	rm -f $(pkg).{index,dict.dz,txt}

clean: _clean
	rm -f $(txt)

# vim: ts=2
