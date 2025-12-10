TEXFILE = Report/report
BIBFILE = Report/report
TEXNAME = report
PREPFILE = Prep/prep-slides
PREPNAME = prep-slides

.PHONY: all clean distclean

all: $(TEXFILE).pdf $(PREPFILE).pdf

report: $(TEXFILE).pdf

prep: $(PREPFILE).pdf

$(TEXFILE).pdf: $(TEXFILE).tex $(BIBFILE).bib
	rm -f $(TEXFILE).aux $(TEXFILE).out $(TEXFILE).log $(TEXFILE).toc $(TEXFILE).bbl $(TEXFILE).blg $(TEXFILE).fls $(TEXFILE).fdb_latexmk build/$(TEXNAME).aux build/$(TEXNAME).out build/$(TEXNAME).log build/$(TEXNAME).toc build/$(TEXNAME).bbl build/$(TEXNAME).blg build/$(TEXNAME).fls build/$(TEXNAME).fdb_latexmk $(TEXNAME).bib
	mkdir -p build
	xelatex --halt-on-error -output-directory=build $(TEXFILE).tex
	cp $(BIBFILE).bib build/$(TEXNAME).bib
	bibtex build/$(TEXNAME).aux
	xelatex --halt-on-error -output-directory=build $(TEXFILE).tex
	xelatex --halt-on-error -output-directory=build $(TEXFILE).tex
	cp build/$(TEXNAME).pdf $(TEXFILE).pdf

$(PREPFILE).pdf: $(PREPFILE).tex $(PREPFILE).bib
	rm -f $(PREPFILE).aux $(PREPFILE).out $(PREPFILE).log $(PREPFILE).toc $(PREPFILE).bbl $(PREPFILE).blg $(PREPFILE).fls $(PREPFILE).fdb_latexmk
	mkdir -p build
	xelatex --halt-on-error -output-directory=build $(PREPFILE).tex
	bibtex build/$(PREPNAME).aux
	xelatex --halt-on-error -output-directory=build $(PREPFILE).tex
	xelatex --halt-on-error -output-directory=build $(PREPFILE).tex
	cp build/$(PREPNAME).pdf $(PREPFILE).pdf


$(PREPFILE).bib: $(TEXFILE).bib
	cp $(TEXFILE).bib $(PREPFILE).bib
clean:
	rm -f build/*
	rm -f $(TEXFILE).pdf
