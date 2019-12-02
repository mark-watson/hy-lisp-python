#!/usr/bin/env hy

(import argparse os)
(import [urllib.request [Request urlopen]])

(defn get-raw-data-from-web [aUri &optional [anAgent {"User-Agent" "HyLangBook/1.0"}]]
  (setv req (Request aUri :headers anAgent))
  (setv httpResponse (urlopen req))
  (setv data (.read httpResponse))
  data)

;;(print (get-raw-data-from-web "http://markwatson.com"))
        
