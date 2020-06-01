#!/usr/bin/env hy

(import json)
(import os)
(import sys)
(import [pprint [pprint]])
(import requests)

;; Add your Bing Search V7 subscription key and endpoint to your environment variables.
(setv subscription_key (get os.environ "BING_SEARCH_V7_SUBSCRIPTION_KEY"))

(print subscription_key)

;; Query term(s) to search for. 
(setv query (get sys.argv 1)) ;;  "site:wikidata.org Sedona Arizona"

(setv endpoint "https://api.cognitive.microsoft.com/bing/v7.0/search")


;; Construct a request
(setv mkt "en-US")
(setv params { "q" query "mkt" mkt })
(setv headers { "Ocp-Apim-Subscription-Key" subscription_key })

;; Call the API
(setv response (requests.get endpoint :headers headers :params params))
(print (response.json))
