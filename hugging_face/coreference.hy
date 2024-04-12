(import json)
(import requests)
(import os)

(setv HF_API_TOKEN (os.environ.get "HF_API_TOKEN"))
(setv
  headers
  {"Authorization"
   (.join "" ["Bearer " HF_API_TOKEN])
  })
(setv
  API_URL
  "https://api-inference.huggingface.co/models/bert-base-uncased")

(defn query [payload]
   (setv data (json.dumps payload))
   (setv
     response
     (requests.request "POST" API_URL  :headers headers :data data))
   (json.loads (response.content.decode "utf-8")))

(print (query "John Smith bought a car. [MASK] drives it fast."))
