# $Id$

.SILENT:

MAKEINFO	= $(shell which makeinfo 2> /dev/null)
PDFTEX		= $(shell which pdftex 2> /dev/null)

ephemeris_docs: version ephemeris.pdf ephemeris.html
	echo ""
	echo Documentation built with success.

version:
	sed 's/^/@set /g;s/=/ /g' ../version_information  > version.texi

%.pdf: %.texi
ifneq (${PDFTEX},)
	echo Building $@
	${PDFTEX} $<; 	${PDFTEX} $<
else
	@echo "-----------------------------------------------"
	@echo "pdftex not found, cannot build PDF documentation"
	@echo "-----------------------------------------------"
endif

%.html: %.texi
ifneq (${MAKEINFO},)
	echo Building $@
	-${MAKEINFO} --html --no-split --css-include=ephemeris.css --ifinfo $<
#	-${MAKEINFO} --html  --css-include=ephemeris.css --ifinfo $<
else
	@echo "---------------------------------------------------"
	@echo "makeinfo not found, cannot build HTML documentation"
	@echo "---------------------------------------------------"
endif

clean:
	-$(RM) *.aux *.log *.vr *.tp *.toc *.pg *.ky *.fn *.cp  *~ 

veryclean: clean
	-$(RM) ephemeris.pdf ephemeris.html version.texi

