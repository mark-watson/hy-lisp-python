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
(print "total chars (unique characters in input text):" (len chars))
(setv char_indices (dict (lfor i (enumerate chars) (, (last i) (first i)))))
(setv indices_char (dict (lfor i (enumerate chars) i)))

(print char_indices)
(print indices_char)
