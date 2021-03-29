.POSIX:

SHELL = /bin/sh

.SUFFIXES:
.SUFFIXES: .pdf .tex

SRC = thesis.tex
PDF = $(SRC:tex=pdf)

LATEX = pdflatex
BIBTEX = biber
LATEX_OPTS = -halt-on-error
GLOSSARY = makeglossaries

APP = Preview

all: $(PDF)

.tex.pdf:
	$(LATEX) $(LATEX_OPTS) $*
	$(GLOSSARY) $(GLOSSARY_OPTS) $*
	$(BIBTEX) $(BIBTEX_OPTS) $*
	$(LATEX) $(LATEX_OPTS) $*
	$(LATEX) $(LATEX_OPTS) $*

thesis.pdf: thesis.tex setup.tex meta.tex macros.tex glossary.tex sources.bib
thesis.pdf: abstract.tex
thesis.pdf: intro.tex
thesis.pdf: categories.tex
thesis.pdf: examples.tex
thesis.pdf: discussion.tex
thesis.pdf: conclusion.tex

defense.pdf: defense.tex
	$(LATEX) $(LATEX_OPTS) $*
	$(BIBTEX) $(BIBTEX_OPTS) $*
	$(LATEX) $(LATEX_OPTS) $*
	$(LATEX) $(LATEX_OPTS) $*

interactive:
	@while read -r -p 'compile>'; do $(MAKE) preview; done

preview: $(PDF)
	open -a $(APP) $(PDF)

clean:
	git clean -fdx -e '*.sw*' -e '*.vim'
