#!/usr/bin/env hy

(import [urllib.request [Request urlopen]])

(defn get-raw-data-from-web [aUri &optional [anAgent {"User-Agent" "HyLangBook/1.0"}]]
  (setv req (Request aUri :headers anAgent))
  (setv httpResponse (urlopen req))
  (setv data (.read httpResponse))
  data)

(defn get-web-page-from-disk [filePath]
  (.read (open filePath "r")))

;;(print (get-raw-data-from-web "http://markwatson.com"))
;;(print (get-web-page-from-disk "democracynow_home_page.html"))
