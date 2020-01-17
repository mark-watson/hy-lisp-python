#!/usr/bin/env hy

;;(import argparse os)
(import [get-web-page [get-web-page-from-disk]])
(import [bs4 [BeautifulSoup]])

;;(print (get-web-page-from-disk "npr_home_page.html"))

;; you need to run 'make data' to fetch sample HTML data for dev and testing

(defn get-npr-links []
  (setv test-html (get-web-page-from-disk "npr_home_page.html"))
  (setv bs (BeautifulSoup test-html :features "lxml"))
  (setv all-anchor-elements (.findAll bs "a"))
  ;;(print all-anchor-elements)
  (setv filtered-a
    (lfor e all-anchor-elements
          :if (> (len (.get-text e)) 0)
          (, (.get e "href") (.get-text e))))
  ;;(print filtered-a)
  filtered-a)

(defn create-npr-summary []
  (setv links (get-npr-links))
  (setv filtered-links (lfor [uri text] links :if (> (len (.strip text)) 40) (.strip text)))
  ;;(string.join filtered-links))
  (.join "\n\n" filtered-links))

(if (= __name__ "__main__")
  (print (create-npr-summary)))