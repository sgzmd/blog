---
title: "LaTeX on Onyx Boox"
date: 2025-10-04T16:13:45+01:00
draft: false
tags: 
  - Reading
  - E-Readers
---

I have a very specific use case for my Onyx Boox Note Air 3: whenever I need to dive into a big topic, I ask ChatGPT or Gemini’s Deep Research to produce a report-style article. Depending on the subject, it can run anywhere from 10 to 50+ densely packed A4 pages of text. Reading that on my computer is, frankly, painful — so I learned to put my e-reader to work instead.  

One recurring issue, though, is format. Whatever the LLMs output, it’s rarely easy to convert to EPUB — and Markdown, the go-to choice for the Big Four, isn’t great for longer documents.  

My solution? Convince the LLM to output in LaTeX. Most of them can produce surprisingly solid, compilable code that works with modern compilers like `pdflatex` or, more recently, `xelatex`. From there, the final step is converting LaTeX into just the right type of PDF — one that’s comfortable to read on a 10.3" screen. If you run into same problems, hopefully this post can help you.

The key here is the document _preamble_ to use - i.e. whatever goes before LaTeX content. By the method of trial and error, I crafted this, which works really well for me:

```latex
\documentclass[12pt,oneside]{extreport} 

% Use actual Boox Note Air 3 screen size
\usepackage[papersize={157mm,210mm},\\
    top=12mm,bottom=12mm,left=12mm,\\
    right=12mm]{geometry}

% You don't really need page numbers there, 
% they are just waste of space on ereader
\usepackage{nopageno} 

% Better line spacing for readability
\usepackage{setspace}
\setstretch{1.3} % ~1.5 line spacing

% Modern fonts
\usepackage{inconsolata} % monospace
\renewcommand{\ttdefault}{inconsolata}

\usepackage{fontspec}
% Adjust to your taste
\setmainfont{Optima}[Weight=1.5] 

% Code listings, tuned for grayscale
\usepackage{listings}
\usepackage{xcolor}

\definecolor{codebg}{gray}{0.95}
\definecolor{codeframe}{gray}{0.7}
\definecolor{codekeyword}{gray}{0.1}
\definecolor{codecomment}{gray}{0.4}
\definecolor{codestring}{gray}{0.2}

\lstset{
  backgroundcolor=\color{codebg},
  basicstyle=\ttfamily\footnotesize,
  keywordstyle=\color{codekeyword}\bfseries,
  commentstyle=\color{codecomment}\itshape,
  stringstyle=\color{codestring},
  numberstyle=\tiny\color{codecomment},
  numbers=left,
  stepnumber=1,
  numbersep=8pt,
  breaklines=true,
  showstringspaces=false,
  frame=single,
  framerule=0.3pt,
  rulecolor=\color{codeframe},
  tabsize=2,
  columns=flexible,
  keepspaces=true,
  morekeywords={let,const,async,await},
  language=Java
}

% Metadata
\title{My Super Mega Report About Important Stuff}
\author{Roman Kirillov}
\date{\today}

% Added encoding package to support \textquotedbl
\usepackage[utf8]{inputenc}
\usepackage[T1]{fontenc}
```

That's it - just replace the document preamble LLM has produced, and go read that article! Here's what you get:

![Latex-Produced PDF on Onyx Boox Note Air 3](/static/reading/onyx-latex.png)

Bonus: here's the `Makefile` to compile stuff to all formats straight away:

```Makefile
# Makefile for compiling the book in PDF, 
# Markdown, and EPUB formats

# Directories
OUT_DIR := out
TMP_DIR := tmp

# Tools
PDFLATEX := xelatex
PANDOC := pandoc

# Files
TEX_FILES := $(wildcard *.tex)
MAIN_TEX := book.tex 

# Outputs
PDF_OUTPUT := $(OUT_DIR)/book.pdf
MARKDOWN_OUTPUT := $(OUT_DIR)/book.md
EPUB_OUTPUT := $(OUT_DIR)/book.epub

# Ensure output and temp directories exist
$(OUT_DIR):
	mkdir -p $(OUT_DIR)

$(TMP_DIR):
	mkdir -p $(TMP_DIR)

# PDF target
$(PDF_OUTPUT): $(MAIN_TEX) $(TEX_FILES) | $(OUT_DIR) $(TMP_DIR)
	$(PDFLATEX) -output-directory=$(TMP_DIR) $(MAIN_TEX)
	mv $(TMP_DIR)/$(basename $(MAIN_TEX)).pdf $(PDF_OUTPUT)

# Markdown target
$(MARKDOWN_OUTPUT): $(MAIN_TEX) $(TEX_FILES) | $(OUT_DIR)
	$(PANDOC) $(MAIN_TEX) -o $(MARKDOWN_OUTPUT)

# EPUB target
$(EPUB_OUTPUT): $(MAIN_TEX) $(TEX_FILES) | $(OUT_DIR)
	$(PANDOC) $(MAIN_TEX) -o $(EPUB_OUTPUT)

# All target
all: $(PDF_OUTPUT) $(MARKDOWN_OUTPUT) $(EPUB_OUTPUT)

# Clean target
clean:
	rm -rf $(OUT_DIR) $(TMP_DIR)

.PHONY: all clean
```