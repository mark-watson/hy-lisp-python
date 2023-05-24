(import transformers [pipeline])

(setv
  summarizer
  (pipeline "summarization" :model "facebook/bart-large-cnn"))
  
(setv
  text
  "The President sent a request for changing the debt ceiling to Congress. The president might call a press conference. The Congress was not oblivious of what the Supreme Court's majority had ruled on budget matters. Even four Justices had found nothing to criticize in the President's requirement that the Federal Government's four-year spending plan. It is unclear whether or not the President and Congress can come to an agreement before Congress recesses for a holiday. There is major dissagrement between the Democratic and Republican parties on spending.")

(setv results
  (get
    (summarizer text :max_length 60)
    0))

(print (.join "" (get results "summary_text")))
