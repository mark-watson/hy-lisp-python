# Code for my book "A Lisp Programmer Living in Python-Land: The Hy Programming Language"


You can purchase the book at [leanpub](https://leanpub.com/hy-lisp-python) or read the book online for free on my website [https://markwatson.com](https://markwatson.com). I offer free updates to new editions to all of my books purchased on leanpub.

## Warning: master branch of this repo requires Python 3.8 and hy-0.19.0

    pip uninstall hy
    conda create -n hy python=3.8
    conda activate hy
    wget https://github.com/hylang/hy/releases/download/0.19.0/hy-0.19.0-py2.py3-none-any.whl
    pip install hy-0.19.0-py2.py3-none-any.whl
    pip install PyInquirer

Note: these directions were tested 2022/11/27 on the master branch. I have a work in progress dev branch where I am updating the code to Python 3.11 and the latest Hy version. The dev branch's 'kgn' exasmple is currently breaking and the code on dev branch is not well tested.

## Book Content

This book covers many programming topics using the Lisp language Hy that compiles to Python AST and is compatible with code, libraries, and frameworks written in Python. The main topics we will cover and write example applications for are:

- Relational and graph databases
- Web app development
- Web scraping
- Accessing semantic web and linked data sources like Wikipedia, DBpedia, and Wikidata
- Automatically constructing Knowledge Graphs from text documents, semantic web and linked
data
- Deep Learning
- Natural Language Processing (NLP) using Deep Learning

Please note that this repo also contains examples that are a work in progress for the next edition (these directories conatin a file named **NOT_YET_IN_BOOK.md**).

## Examples converted to Python

December 19, 2020: I added a shell script to convert the Hy language examples to Python and store them in examples_translated_to_python/.

Note: this is the only use of the let macro in this book, as of January 2021.

I like to use the let macro except for one issue: auto-converting Hy to Python produces
unattractive Python code if the let macro is used.


