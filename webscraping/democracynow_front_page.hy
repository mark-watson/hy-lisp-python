#!/usr/bin/env hy

;;(import argparse os)
(import [get-web-page [get-web-page-from-disk]])
(import [bs4 [BeautifulSoup]])

;;(print (get-web-page-from-disk "democracynow_home_page.html"))

;; you need to run 'make data' to fetch sample HTML data for dev and testing

(defn get-democracy-now-links []
  (setv test-html (get-web-page-from-disk "democracynow_home_page.html"))
  (setv bs (BeautifulSoup test-html :features "lxml"))
  (setv all-anchor-elements (.findAll bs "a"))
  ;;(print all-anchor-elements)
  (setv filtered-a
    (lfor e all-anchor-elements
          :if (> (len (.get-text e)) 0)
          (, (.get e "href") (.get-text e))))
  ;;(print filtered-a)
  filtered-a)

(if (= __name__ "__main__")
  (for [[uri text] (get-democracy-now-links)]
    (print uri ":" text)))