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
