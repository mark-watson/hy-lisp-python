#!/usr/bin/env hy

(import [get-web-page [get-web-page-from-disk]])
(import [bs4 [BeautifulSoup]])

;; you need to run 'make data' to fetch sample HTML data for dev and testing

(defn get-democracy-now-links []
  (setv test-html (get-web-page-from-disk "democracynow_home_page.html"))
  (setv bs (BeautifulSoup test-html :features "lxml"))
  (setv all-anchor-elements (.findAll bs "a"))
  (lfor e all-anchor-elements
          :if (> (len (.get-text e)) 0)
          (, (.get e "href") (.get-text e))))

(if (= __name__ "__main__")
  (for [[uri text] (get-democracy-now-links)]
    (print uri ":" text)))