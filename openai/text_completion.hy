(import os)
(import openai)

(setv openai.api_key (os.environ.get "OPENAI_KEY"))

(defn completion [query]
  (setv
    completion
    (openai.ChatCompletion.create
      :model "gpt-3.5-turbo"
      :messages
      [{"role" "user"
        "content" query
        }]))
  (get
    (get (get (get completion "choices") 0) "message")
    "content"))

;; (print (completion "how to fix leaky faucet?"))

