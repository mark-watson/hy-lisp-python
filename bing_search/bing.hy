#!/usr/bin/env hy

(import json)
(import os)
(import sys)
(import pprint [pprint])
(import requests)

;; Add your Bing Search V7 subscription key and endpoint to your environment variables.
(setv subscription_key (get os.environ "BING_SEARCH_V7_SUBSCRIPTION_KEY"))

;; Query term(s) to search for. 
(setv query (get sys.argv 1)) ;;  "site:wikidata.org Sedona Arizona"

(setv endpoint "https://api.cognitive.microsoft.com/bing/v7.0/search")


;; Construct a request
(setv mkt "en-US")
(setv params { "q" query "mkt" mkt })
(setv headers { "Ocp-Apim-Subscription-Key" subscription_key })

;; Call the API
(setv response (requests.get endpoint :headers headers :params params))

(print "\nFull JSON response from Bing search query:\n")
(pprint (response.json))

;; pull out resuts and print them individually:

(setv results (get (response.json) "webPages"))

(print "\nResults from the key 'webPages':\n")
(pprint results)

(print "\nDetailed printout from the first search result:\n")

(setv result-list (get results "value"))

(print "\nResults for key 'value':\n")
(pprint result-list)

(setv first-result (get result-list 0))

(print "\nFirst result, all data:\n")
(pprint first-result)

(print "\nSummary of first search result:\n")

(pprint (get first-result "displayUrl"))

(when (in "displayUrl" first-result)
    (print (.format " key: {:15} \t:\t {}" "displayUrl" (get first-result "displayUrl"))))
(when (in "language" first-result)
    (print (.format " key: {:15} \t:\t {}" "language" (get first-result "language"))))
(when (in "name" first-result)
    (print (.format " key: {:15} \t:\t {}" "name" (get first-result "name"))))

