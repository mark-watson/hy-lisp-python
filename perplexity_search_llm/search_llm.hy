(import os)
(import openai)
(import pprint [pprint]) ; Import pprint for potentially pretty printing responses

;; Set your Perplexity API key from an environment variable
(setv YOUR-API-KEY (os.environ.get "PERPLEXITY_API_KEY"))

;; Define the messages for the conversation using triple quotes for multiline content
(setv system-message
      {"role" "system"
       "content" "You are an artificial intelligence assistant and you need to engage in a helpful, detailed, polite conversation with a user."})

(setv user-message
      {"role" "user"
       "content" "How many stars are in the universe?"})

(setv messages [system-message user-message])

;; Initialize the OpenAI client, pointing to the Perplexity API base URL
(setv client (openai.OpenAI :api-key YOUR-API-KEY :base-url "https://api.perplexity.ai"))

;; --- Chat completion without streaming ---
(print "--- Non-streaming response ---")
(setv response (client.chat.completions.create
                 :model "sonar" ; Use a model supported by Perplexity
                 :messages messages))

(pprint response)

;; Break down attribute access for debugging
(setv choices-list (. response choices))
(setv first-choice (get choices-list 0))
(setv message-object-result (. first-choice message))
;; Now, try to access content on the result
(setv content-string (. message-object-result content)) ; <--- Error expected here if the previous traceback was misleading
(print content-string)
