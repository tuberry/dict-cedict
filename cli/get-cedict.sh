#!/bin/bash
# by tuberry

curl -LO $URL/$TXT.gz && gzip -d $TXT.gz
