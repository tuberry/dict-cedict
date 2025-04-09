# create minified entries:
MINI ?= true
# index by simplified characters, or traditional:
SIMP ?= true

ifeq ($(SIMP),true)
	pkg := cedict-simp
	simp_flag := simplified
else
	pkg := cedict-trad
	simp_flag := no-simplified
endif

ifeq ($(MINI),true)
	mini_flag := mini
else
	mini_flag := no-mini
endif

txt := cedict_1_0_ts_utf-8_mdbg.txt
aim := $(pkg).index $(pkg).dict.dz

.PHONY: all clean _clean

all: $(aim)

$(txt):
	curl -LO https://www.mdbg.net/chinese/export/cedict/$(txt).gz && gzip -d $(txt).gz

$(pkg).txt: $(txt)
	python ./cedict.py -i ./$(txt) -o $(pkg).txt --$(mini_flag) --$(simp_flag)

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
