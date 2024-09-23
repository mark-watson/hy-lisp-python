(import os requests)
(import pprint [pprint])

(defn brave_search [query]
  (setv subscription-key (get os.environ "BRAVE_SEARCH_API_KEY"))
  (setv endpoint "https://api.search.brave.com/res/v1/web/search")

  ;; Construct a request
  (setv params {"q" query})
  (setv headers {"X-Subscription-Token" subscription-key})

  ;; Call the API
  (setv response (requests.get endpoint :headers headers :params params))

  ;; Pull out results
  (setv results (get (get (response.json) "web") "results"))

  ;; Create a list of lists containing title, URL, and description
  (setv res (lfor result results
                 [(get result "title")
                  (get result "url")
                  (get result "description")]))

  ;; Return the results
  res)

;; Example usage:
;;(setv search-results (brave-search "site:wikidata.org Sedona Arizona"))
;;(pprint search-results)
