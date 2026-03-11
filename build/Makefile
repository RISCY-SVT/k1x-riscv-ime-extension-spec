# Makefile for RISC-V ISA Manuals
#
# This work is licensed under the Creative Commons Attribution-ShareAlike 4.0
# International License. To view a copy of this license, visit
# http://creativecommons.org/licenses/by-sa/4.0/ or send a letter to
# Creative Commons, PO Box 1866, Mountain View, CA 94042, USA.
#
# SPDX-License-Identifier: CC-BY-SA-4.0
#
# Description:
# 
# This Makefile is designed to automate the process of building and packaging
# the documentation for RISC-V ISA Manuals. It supports multiple build targets
# for generating documentation in various formats (PDF, HTML, Markdown).

# Build Targets
TARGETS := ime-pdf ime-html ime-md

# Declare phony targets
.PHONY: all $(TARGETS) clean docker

# Default target builds all
all: $(TARGETS)

# Build with the upstream docs container.
DOCKER_IMAGE ?= ghcr.io/riscv/riscv-docs-base-container-image:latest

docker:
	cd .. && docker run --rm -it -e LANG=C.utf8 -v "$$(pwd)":/build $(DOCKER_IMAGE) /bin/sh -lc 'cd /build/build && make'

# Source directory
SRCDIR := ../src
MAIN_DOC := $(SRCDIR)/header.adoc
DOC_SOURCES := $(wildcard $(SRCDIR)/*.adoc) \
               $(wildcard $(SRCDIR)/images/wavedrom/*.adoc) \
               $(wildcard $(SRCDIR)/images/*)

# Output files
PDF_OUT := spacemit-ime-asciidoc.pdf
HTML_OUT := spacemit-ime-asciidoc.html
MD_OUT := spacemit-ime-asciidoc.md
PANDOC_FILTER := ./asciidoctor-to-markdown.lua

# Temporary files to clean up for LaTeX build
JUNK := *.pdf *.aux *.log *.bbl *.blg *.toc *.out *.fdb_latexmk *.fls *.synctex.gz

# Asciidoctor options
ASCIIDOCTOR_BASE_OPTS := -a compress \
                         --attribute=mathematical-format=svg \
                         --failure-level=ERROR \
                         --require=asciidoctor-bibtex \
                         --require=asciidoctor-diagram \
                         --trace

ASCIIDOCTOR_PDF_OPTS := $(ASCIIDOCTOR_BASE_OPTS) \
                        --require=asciidoctor-mathematical

ASCIIDOCTOR_HTML_OPTS := $(ASCIIDOCTOR_BASE_OPTS)

ASCIIDOCTOR_MD_OPTS := $(ASCIIDOCTOR_HTML_OPTS) \
                       -a data-uri!

PANDOC_MD_OPTS := --from=html \
                  --to=gfm+raw_html \
                  --wrap=none \
                  --lua-filter=$(PANDOC_FILTER)

# Privileged ISA build
ime-pdf: $(PDF_OUT)

$(PDF_OUT): $(DOC_SOURCES)
	@echo "Building Privileged ISA"
	rm -f $@.tmp
	asciidoctor-pdf $(ASCIIDOCTOR_PDF_OPTS) --out-file=$@.tmp $(MAIN_DOC)
	mv $@.tmp $@

# Privileged ISA HTML build
ime-html: $(HTML_OUT)

$(HTML_OUT): $(DOC_SOURCES)
	@echo "Building Privileged ISA HTML"
	rm -f $@.tmp
	asciidoctor $(ASCIIDOCTOR_HTML_OPTS) --out-file=$@.tmp $(MAIN_DOC)
	mv $@.tmp $@

# Privileged ISA Markdown build
ime-md: $(MD_OUT)

$(MD_OUT): $(DOC_SOURCES) $(PANDOC_FILTER)
	@echo "Building Privileged ISA Markdown"
	rm -f $@.html.tmp $@.tmp
	asciidoctor $(ASCIIDOCTOR_MD_OPTS) --out-file=$@.html.tmp $(MAIN_DOC)
	pandoc $(PANDOC_MD_OPTS) --output=$@.tmp $@.html.tmp
	mv $@.tmp $@
	rm -f $@.html.tmp

clean:
	rm -f $(PDF_OUT) $(HTML_OUT) $(MD_OUT) $(HTML_OUT).tmp $(MD_OUT).tmp $(MD_OUT).html.tmp
	rm -f images/diag-wavedrom-*.svg
	rm -rf .asciidoctor
	rmdir --ignore-fail-on-non-empty images 2>/dev/null || true
