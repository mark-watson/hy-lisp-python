(import os)
(import openai)

(setv openai.api_key (os.environ.get "OPENAI_KEY"))

(setv client (openai.OpenAI))

(defn completion [query] ; return a Completion object
  (let [completion (client.chat.completions.create
                     :model "gpt-4o-mini"
                     :messages
                     [{"role" "user"
                       "content" query}])]
    ;;(print completion)
    (get completion.choices 0)))

(setv x (completion "how to fix leaky faucet?"))

(print x.message.content)
