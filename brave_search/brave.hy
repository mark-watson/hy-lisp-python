(import os requests)
(import pprint [pprint])

(defn brave_search [query]
  (let [subscription-key (get os.environ "BRAVE_SEARCH_API_KEY")
        endpoint "https://api.search.brave.com/res/v1/web/search"
        ;; Construct a request
        params {"q" query}
        headers {"X-Subscription-Token" subscription-key}
        ;; Call the API
        response (requests.get endpoint :headers headers :params params)
        ;; Pull out results
        results (get (get (response.json) "web") "results")
        ;; Create a list of lists containing title, URL, and description
        res (lfor result results
                  [(get result "title")
                   (get result "url")
                   (get result "description")])]
  ;; Return the results
  res))

;; Example usage:
;(setv search-results (brave-search "site:wikidata.org Sedona Arizona"))
;(pprint search-results)
