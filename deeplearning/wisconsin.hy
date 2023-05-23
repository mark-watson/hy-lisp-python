#!/usr/bin/env hy

(import argparse)
(import os)
(import tensorflow [keras])
(import tensorflow.keras [layers])

(import pandas [read-csv])
(import pandas)

(defn build-model []
  (setv model (keras.models.Sequential))
  (.add model (keras.layers.Dense 9
                 :activation "relu"))
  (.add model (keras.layers.Dense 12
                 :activation "relu"))
  (.add model (keras.layers.Dense 1
                 :activation "sigmoid"))
  (.compile model :loss      "binary_crossentropy"
                  :optimizer (keras.optimizers.RMSprop))
  model)

(defn first [x] (get x 0))

(defn train [batch-size model x y]
  (for [it (range 50)]
    (.fit model x y :batch-size batch-size :epochs 10 :verbose False)))

(defn predict [model x-data]
    (.predict model x-data))

(defn load-data [file-name]
  (setv all-data (read-csv file-name :header None))
  (setv x-data10 (. all-data.iloc [#((slice 0 10) [0 1 2 3 4 5 6 7 8])] values))
  (setv x-data (* 0.1 x-data10))
  (setv y-data (. all-data.iloc [#((slice 0 10) [9])] values))
  [x-data y-data])

(defn main []
  (setv xyd (load-data "train.csv"))
  (setv model (build-model))
  (setv xytest (load-data "test.csv"))
  (train 10 model (. xyd [0]) (. xyd [1]))
  (print "* predictions (calculated, expected):")
  (setv predictions (list (map first (predict model (. xytest [0])))))
  (setv expected (list (map first (. xytest [1]))))
  (print
    (list
      (zip predictions expected))))


(main)
