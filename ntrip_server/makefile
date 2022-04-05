#!/usr/bin/make
# $Id: makefile,v 1.9 2009/02/10 12:20:09 stoecker Exp $

ifdef windir
CC   = gcc
OPTS = -Wall -W -DWINDOWSVERSION
LIBS = -lwsock32
else
OPTS = -Wall -W
endif

ntrip_server: src/ntripserver.c
	$(CC) $(OPTS) $? -O3 -DNDEBUG -o $@ $(LIBS)

debug: src/ntripserver.c
	$(CC) $(OPTS) $? -g -o ntrip_server $(LIBS)

clean:
	$(RM) -f ntrip_server core

archive:
	zip -9 ntrip_server.zip makefile src/ntripserver.c ../README start_ntrip_server.sh

tgzarchive:
	tar -cvzf ntrip_server.tgz makefile src/ntripserver.c ../README start_ntrip_server.sh
