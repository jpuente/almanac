# $Id$

.SILENT:

MKEINFO		= $(shell which makeinfo 2> /dev/null)
PDFTEX		= $(shell which pdftex 2> /dev/null)

ephemeris_docs: version ephemeris.pdf ephemeris.html
	echo ""
	echo Documentation built with success.

version:
	sed 's/^/@set /g;s/=/ /g' ../version_information  > version.texi

%.pdf: %.tex
ifneq (${PDFTEX},)
	echo Building $@
	${PDFTEX} $<
else
	@echo "-----------------------------------------------"
	@echo "pdftex not found, cannot build PDF documentation"
	@echo "-----------------------------------------------"
endif

%.info: %.tex
ifneq (${MAKEINFO},)
	echo Building $@
	-${MAKEINFO} $<
else
	@echo "---------------------------------------------------"
	@echo "makeinfo not found, cannot build INFO documentation"
	@echo "---------------------------------------------------"
endif

%.html: %.tex
ifneq (${MAKEINFO},)
	echo Building $@
	-${MAKEINFO} --html --no-split --css-include=ephemeris.css --ifinfo $<
#	-${MAKEINFO} --html  --css-include=ephemeris.css --ifinfo $<
else
	@echo "---------------------------------------------------"
	@echo "makeinfo not found, cannot build HTML documentation"
	@echo "---------------------------------------------------"
endif

%.txt: %.texi
ifneq (${MAKEINFO},)
	echo Building $@
	-${MAKEINFO} --plaintext --no-headers $< --output $@
else
	@echo "---------------------------------------------------"
	@echo "makeinfo not found, cannot build TEXT documentation"
	@echo "---------------------------------------------------"
endif

clean:
	-$(RM)  *.aux *.log *.vr *.tp *.toc *.pg *.ky *.fn *.cp  *~ 

veryclean: clean
	-$(RM)  version.texi
	-$(RM) ephemeris.pdf ephemeris.html



