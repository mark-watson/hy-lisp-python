#!/bin/sh

hy2py3 bing_search/bing.hy > examples_translated_to_python/bing_search/bing.py
cp bing_search/README.md examples_translated_to_python/bing_search

hy2py3 datastores/postgres_lib.hy > examples_translated_to_python/datastores/postgres_lib.py
hy2py3 datastores/sqlite_lib.hy > examples_translated_to_python/datastores/sqlite_lib.py
hy2py3 datastores/postgres_example.hy > examples_translated_to_python/datastores/postgres_example.py
hy2py3 datastores/sqlite_example.hy > examples_translated_to_python/datastores/sqlite_example.py

hy2py3 deeplearning/lstm.hy > examples_translated_to_python/deeplearning/lstm.py

hy2py3 kgcreator/kgcreator_uri.hy > examples_translated_to_python/kgcreator/kgcreator_uri.py
hy2py3 kgcreator/kgcreator.hy > examples_translated_to_python/kgcreator/kgcreator.py
cp -R kgcreator/test_data examples_translated_to_python/kgcreator

hy2py3 kgn/colorize.hy > examples_translated_to_python/kgn/colorize.py
hy2py3 kgn/kgnutils.hy > examples_translated_to_python/kgn/kgnutils.py
hy2py3 kgn/sparql.hy > examples_translated_to_python/kgn/sparql.py
hy2py3 kgn/cache.hy > examples_translated_to_python/kgn/cache.py
hy2py3 kgn/kgn.hy > examples_translated_to_python/kgn/kgn.py
hy2py3 kgn/textui.hy > examples_translated_to_python/kgn/textui.py
hy2py3 kgn/relationships.hy > examples_translated_to_python/kgn/relationships.py
cp kgn/README.md examples_translated_to_python/kgn

hy2py3 matplotlib/plot_relu.hy > examples_translated_to_python/matplotlib/plot_relu.py
hy2py3 matplotlib/plot_sigmoid.hy > examples_translated_to_python/matplotlib/plot_sigmoid.py

hy2py3 webapp/cookie_test.hy > examples_translated_to_python/webapp/cookie_test.py
hy2py3 webapp/flask_test.hy > examples_translated_to_python/webapp/flask_test.py
hy2py3 webapp/jinja2_test.hy > examples_translated_to_python/webapp/jinja2_test.py
cp -R webapp/templates examples_translated_to_python/webapp

hy2py3 webscraping/get_page_data.hy > examples_translated_to_python/webscraping/get_page_data.py
hy2py3 webscraping/npr_front_page_summary.hy > examples_translated_to_python/webscraping/npr_front_page_summary.py
hy2py3 webscraping/democracynow_front_page.hy > examples_translated_to_python/webscraping/democracynow_front_page.py
hy2py3 webscraping/get_web_page.hy > examples_translated_to_python/webscraping/get_web_page.py
cp webscraping/Makefile examples_translated_to_python/webscraping

hy2py3 nlp/coref_nlp_lib.hy > examples_translated_to_python/nlp/coref_nlp_lib.py
hy2py3 nlp/nlp_lib.hy > examples_translated_to_python/nlp/nlp_lib.py
hy2py3 nlp/coref_example.hy > examples_translated_to_python/nlp/coref_example.py
hy2py3 nlp/nlp_example.hy > examples_translated_to_python/nlp/nlp_example.py
cp nlp/README.md examples_translated_to_python/nlp