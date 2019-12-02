#!/usr/bin/env hy

(import argparse os)
(import [get_web_page [get-raw-data-from-web]])

(import [bs4 [BeautifulSoup]])

(defn get-tag-data [aTag]
  {"text" (.getText aTag)
   "name" (. aTag name)
   "class" (.get aTag "class")
   "href" (.get aTag "href")})

(defn get-page-html-tags [aUri]
  (setv raw-data (get-raw-data-from-web aUri))
  (setv soup (BeautifulSoup raw-data "lxml"))
  (setv title (.find_all soup "title"))
  (setv a (.find_all soup "a"))
  (setv h1 (.find_all soup "h1"))
  (setv h2 (.find_all soup "h2"))
  {"title" title "a" a "h1" h1 "h2" h2})

(setv tags (get-page-html-tags "http://markwatson.com"))

(print (get tags "a"))

(for [ta (get tags "a")] (print (get-tag-data ta)))

;;  (for [e body] (print (.getText e)))

;; (.find_all soup "a")

;; (.find_all soup "b")
;; (for [x (.find_all soup "b")] (print (type x)))
  
