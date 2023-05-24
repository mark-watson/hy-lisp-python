#!/usr/bin/env hy

(import get_web_page [get-raw-data-from-web])

(import bs4 [BeautifulSoup])

(defn get-element-data [anElement]
  {"text" (.getText anElement)
   "name" (. anElement name)
   "class" (.get anElement "class")
   "href" (.get anElement "href")})

(defn get-page-html-elements [aUri]
  (setv raw-data (get-raw-data-from-web aUri))
  (setv soup (BeautifulSoup raw-data "lxml"))
  (setv title (.find_all soup "title"))
  (setv a (.find_all soup "a"))
  (setv h1 (.find_all soup "h1"))
  (setv h2 (.find_all soup "h2"))
  {"title" title "a" a "h1" h1 "h2" h2})

(setv elements (get-page-html-elements "http://markwatson.com"))

(print (get elements "a"))

(for [ta (get elements "a")] (print (get-element-data ta)))


