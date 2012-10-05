# $Id: Makefile 109 2012-10-05 14:40:57Z jpuente 

all: library tools

library: 
	gprbuild -Pephemeris_library

tools:
	gprbuild -Pephemeris_tools

clean: force
	gprclean -Pephemeris_library
	gprclean -Pephemeris_tools

force:

.PHONY: all clean library tools
