# $Id$

INSTALL = /opt

# Install directories

I_INC = $(INSTALL)/include/ephemeris
I_LIB = $(INSTALL)/lib/ephemeris
I_GPR = $(INSTALL)/lib/gnat
I_TPL = $(INSTALL)/share/examples/ephemeris
I_DOC = $(INSTALL)/share/doc/ephemeris
I_PLG = $(INSTALL)/share/gps/plug-ins

.PHONY: all
all: library

library:
	$(MKDIR) obj
	$(MKDIR) lib
	gnatmake -Pephemeris

util: library
	gnatmake -Pephemeris_utilities

clean:
	-gnatclean -Pephemeris
	-gnatclean -Pephemeris_tests
	-gnatclean -Pephemeris_utilities
	-$(RMDIR) obj
	-$(RMDIR) lib
	-$(MAKE) -C docs clean

install_clean:
	$(RM) -fr $(I_INC)
	$(RM) -fr $(I_LIB)
	$(RM) -fr $(INSTALL)/share/examples/ephemeris
	$(RM) -fr $(I_DOC)
	$(RM) -f $(I_GPR)/ephemeris.gpr

install_dirs: install_clean
	$(MKDIR) $(I_INC)
	$(MKDIR) $(I_LIB)
	$(MKDIR) $(I_DOC)
	$(MKDIR) $(I_GPR)
	$(MKDIR) $(I_TPL)
	$(MKDIR) $(I_PLG)

install: install_dirs
	$(CP) src/*.ad*  $(I_INC)
	$(CP) lib/* $(I_LIB)
	$(CP) template/*.ad* template/*.gpr $(I_TPL)
	$(CP) docs/*.html docs/*.info docs/*.pdf docs/*.txt $(I_DOC)
	$(CP) support/ephemeris.gpr $(I_GPR)
	$(CP) support/ephemeris.xml $(I_PLG)

doc:
	${MAKE} -C docs

force:

test: force
	gnatmake -Pephemeris_test
	test/test_ephemeris

RMDIR	= rmdir
MKDIR	= mkdir -p
RM	= rm
CP	= cp -p
