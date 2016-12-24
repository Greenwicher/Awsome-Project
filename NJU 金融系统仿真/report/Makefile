DOC=main

.PHONY:all temp clean distclean

all:
	xelatex $(DOC).tex
#	bibtex  $(DOC).aux
	xelatex $(DOC).tex
#	xelatex $(DOC).tex

bibtex:
	xelatex $(DOC).tex
	bibtex  $(DOC).aux
	xelatex $(DOC).tex
	xelatex $(DOC).tex

temp:
	xelatex $(DOC).tex

clean: 
	-@rm -f \
		*.aux \
		*.bak \
		*.bbl \
		*.blg \
		*.dvi \
		*.glo \
		*.gls \
		*.idx \
		*.ilg \
		*.ind \
		*.ist \
		*.log \
		*.out \
		*.ps  \
		*.thm \
		*.toc \
		*.lof \
		*.lot \
		*.loe \
		*.fot \
		data/*.aux \
		data/*.log \
		data/*.pdf

distclean: clean
	-@rm -f *.pdf *.tar.gz
