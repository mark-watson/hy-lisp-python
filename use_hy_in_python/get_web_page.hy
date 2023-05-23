(import urllib.request [Request urlopen])

(defn get-raw-data-from-web [aUri [anAgent {"User-Agent" "HyLangBook/1.0"}]]
  (setv req (Request aUri :headers anAgent))
  (setv httpResponse (urlopen req))
  (setv data (.read httpResponse))
  data)

(defn get-web-page-from-disk [filePath]
  (.read (open filePath "r")))

(defn main_hy []
  (print (get-raw-data-from-web "http://markwatson.com")))

