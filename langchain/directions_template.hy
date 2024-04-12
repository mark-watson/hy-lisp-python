(import langchain.prompts [PromptTemplate])
(import langchain_openai.llms [OpenAI])

(setv llm (OpenAI :temperature 0.9))

(defn get_directions [thing_to_do]
   (setv
     prompt
     (PromptTemplate
       :input_variables ["thing_to_do"]
       :template "How do I {thing_to_do}?"))
    (setv
      prompt_text
      (prompt.format :thing_to_do thing_to_do))
    ;; Print out generated prompt when you are getting started:
    (print "\n" prompt_text ":")
    (llm prompt_text))

(print (get_directions "get to the store"))
(print (get_directions "hang a picture on the wall"))

