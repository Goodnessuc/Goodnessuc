# Makefile for working with Markdown files

# Variables
MARKDOWN = $(wildcard *.md)
HTML = $(MARKDOWN:.md=.html)
PDF = $(MARKDOWN:.md=.pdf)
PANDOC = pandoc
TIDY = tidy
PDF_ENGINE = xelatex

# Default task
all: html pdf

# Convert Markdown to HTML
%.html: %.md
	@echo "Converting $< to HTML..."
	@$(PANDOC) -s $< -o $@
	@$(TIDY) -m -q $@

# Convert Markdown to PDF
%.pdf: %.md
	@echo "Converting $< to PDF..."
	@$(PANDOC) $< --pdf-engine=$(PDF_ENGINE) -o $@

# Clean generated files
clean:
	@echo "Cleaning up generated files..."
	@rm -f $(HTML) $(PDF)

push:
	@echo "Pushing to GitHub..."
	git add .
	@read -p "Enter commit message: " commit_msg; \
	git commit -m "$$commit_msg"; \
	git push


.PHONY: all html pdf clean


