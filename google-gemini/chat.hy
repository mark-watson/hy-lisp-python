(import os)
(import requests)
(import json) ;; Explicitly import json for dumps

;; Get API key from environment variable (standard practice)
(setv api-key (os.getenv "GOOGLE_API_KEY"))

;; Gemini API endpoint
(setv api-url f"https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key={api-key}")

;; Initialize the chat history (Note: Gemini uses 'user' and 'model')
(setv chat-history [])

(defn call-gemini [chat-history user-input]
  "Calls the Gemini API with the chat history and user input using requests."

  (setv headers {"Content-Type" "application/json"})

  ;; Build the contents list, correctly alternating roles.
  (setv contents [])
  (for [message chat-history]
    (.append contents message))
  (.append contents {"role" "user" "parts" [{"text" user-input}]})

  (setv data {
              "contents" contents
              "generationConfig" {
                                  "maxOutputTokens" 200
                                  "temperature" 1.2
                                  }})

  ;; Use json.dumps to convert the Python/Hy dict to a JSON string
  (setv response (requests.post api-url :headers headers :data (json.dumps data)))

  ;; Raise HTTPError for bad responses (4xx or 5xx)
  (. response raise_for-status)

  ;; Return the JSON response as a Hy dictionary/list
  (response.json))

;; --- Main Chat Loop ---
(while True
  ;; Get user input from the console
  (setv user-input (input "You: "))


  ;; Call the Gemini API
  (setv response-data (call-gemini chat-history user-input))

  ;; Debug print (optional)
  ;; (print "Raw response data:" response-data)

  ;; Extract and print the assistant's message
  ;; Using sequential gets for clarity, assumes expected structure
  (setv candidates (get response-data "candidates"))
  (setv first-candidate (get candidates 0))
  (setv content (get first-candidate "content"))
  
  (setv parts (get content "parts"))

  (setv assistant-message (get (get parts 0) "text"))
  (print "Assistant:" assistant-message)

  ;; Append BOTH user and assistant messages to chat history (important for context)
  (.append chat-history {"role" "user" "parts" [{"text" user-input}]})
  (.append chat-history {"role" "model" "parts" [{"text" assistant-message}]}))
