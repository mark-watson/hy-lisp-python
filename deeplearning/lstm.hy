#!/usr/bin/env hy

;; This example was translated from the Python example in the Keras
;; documentation at: https://keras.io/examples/lstm_text_generation/

(import [keras.callbacks [LambdaCallback]])
(import [keras.models [Sequential]])
(import [keras.layers [Dense LSTM]])
(import [keras.optimizers [RMSprop]])
(import [keras.utils.data_utils [get_file]])
(import [numpy :as np]) ;; note the syntax for aliasing a module name
(import random sys io)

(setv path
      (get_file        ;; this saves a local copy in ~/.keras/datasets
        "nietzsche.txt"
        :origin "https://s3.amazonaws.com/text-datasets/nietzsche.txt"))

(with [f (io.open path :encoding "utf-8")]
  (setv text (.read f))) ;; note: sometimes we use (.lower text) to
;;       convert text to all lower case
(print "corpus length:" (len text))

(setv chars (sorted (list (set text))))
;;(.insert chars 0 "~") ;; to avoid zero cut, add a character not appearing in text
(print "total chars (unique characters in input text):" (len chars))
(setv char_indices (dict (lfor i (enumerate chars) (, (last i) (first i)))))
(setv indices_char (dict (lfor i (enumerate chars) i)))

;; cut the text in semi-redundant sequences of maxlen characters
(setv maxlen 40)
(setv step 3) ;; when we sample text, slide sampling window 3 characters
(setv sentences (list))
(setv next_chars (list))

(print "Create sentencs and next_chars data...")
(for [i (range 0 (- (len text) maxlen) step)]
  (.append sentences (cut text i (+ i maxlen)))
  (.append next_chars (get text (+ i maxlen))))

(print "next_chars:" next_chars)
(print "Vectorization...")
(setv x (np.zeros [(len sentences) maxlen (len chars)] :dtype np.bool))
(setv y (np.zeros [(len sentences) (len chars)] :dtype np.bool))
(for [[i sentence] (lfor j (enumerate sentences) j)]
  (for [[t char] (lfor j (enumerate sentence) j)]
    ;;(print "i:" i "t:" t "char:" char)
    ;;(print "(get char_indices char):" (get char_indices char))
    ;;(if (> (get char_indices char) 0)
    (setv (get x i t (get char_indices char)) 1))
        ;;(setv (get x i t 0) 1)))
  (setv (cut y i (get char_indices (get next_chars i))) 1))

(print "x:\n" x)
;;(print "y:\n" y)

(print "Done creating training data.")

