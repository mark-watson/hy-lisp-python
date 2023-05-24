#!/usr/bin/env hy

(import get-web-page [get-web-page-from-disk])
(import bs4 [BeautifulSoup])

;; you need to run 'make data' to fetch sample HTML data for dev and testing

(defn get-npr-links []
  (setv test-html (get-web-page-from-disk "npr_home_page.html"))
  (setv bs (BeautifulSoup test-html :features "lxml"))
  (setv all-anchor-elements (.findAll bs "a"))
  (setv filtered-a
    (lfor e all-anchor-elements
          :if (> (len (.get-text e)) 0)
          #((.get e "href") (.get-text e))))
  filtered-a)

(defn create-npr-summary []
  (setv links (get-npr-links))
  (setv filtered-links (lfor [uri text] links :if (> (len (.strip text)) 40) (.strip text)))
  (.join "\n\n" filtered-links))

(when (= __name__ "__main__")
  (print (create-npr-summary)))