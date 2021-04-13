.POSIX:

SHELL = /bin/sh

.SUFFIXES:
.SUFFIXES: .pdf .tex

all:
	latexmk -pdf

.tex.pdf:
	latexmk -pdf $*

loop:
	latexmk -pdf -pvc

preview:
	latexmk -pdf -pv

clean:
	latexmk -c
	-$(RM) *.v_tex

distclean:
	latexmk -C
	-$(RM) *.v_tex

maintainer-clean: distclean
	git clean -fdx -e '*.sw*' -e '*.vim'
