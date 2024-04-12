(import langchain.prompts [PromptTemplate])
(import langchain_openai.llms [OpenAI])

(setv llm (OpenAI :temperature 0.9))

(setv
  template
  "Predict the capital and population of a country.\n\nCountry: {country_name}\nCapital:\nPopulation:\n")

(defn get_country_information [country_name]
  (print "Processing " country_name ":")
  (setv
     prompt
     (PromptTemplate
       :input_variables ["country_name"]
       :template template))
  (setv
      prompt_text
      (prompt.format :country_name country_name))
  ;; Print out generated prompt when you are getting started:
  (print "\n" prompt_text ":")
  (llm prompt_text))

(print (get_country_information "Germany"))
;; (print (get_country_information "Canada"))
