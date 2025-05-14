(import os)
(import openai)
(import pprint [pprint]) ; Import pprint for potentially pretty printing responses

;; Set your Perplexity API key from an environment variable
(setv YOUR-API-KEY (os.environ.get "PERPLEXITY_API_KEY"))

;; Define the messages for the conversation using triple quotes for multiline content
(setv system-message
      {"role" "system"
       "content" "You are an artificial intelligence assistant for helping a user with programming and tech questions using web search and reasoning."})

(defn search_llm [query]
  (setv user-message
        {"role" "user"
         "content" query})
  
  (setv messages [system-message user-message])

  ;; Initialize the OpenAI client, pointing to the Perplexity API base URL
  (setv client (openai.OpenAI :api-key YOUR-API-KEY
                              :base-url "https://api.perplexity.ai"))

  ;; --- Chat completion without streaming ---
  (setv response (client.chat.completions.create
                   :model "sonar" ; Use a model supported by Perplexity
                   :messages messages))
  (setv choices-list (. response choices))
  (setv first-choice (get choices-list 0))
  (setv message-object-result (. first-choice message))
  (setv content-string (. message-object-result content))
  ;;(print content-string)
  content-string)

(print (search_llm "Consultant Mark Watson has written many books on AI, Lisp and the semantic web. What musical instruments does he play?"))

