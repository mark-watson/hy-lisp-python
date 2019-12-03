#!/usr/bin/env hy

;;;-------------------------------------
;;; imports
;;;-------------------------------------

(import argparse
        os)

;;;-------------------------------------
;;; classes
;;;-------------------------------------

(defclass Alphabet [object]
  "Represents an alphabet of characters."

  (defn --init-- [self chars chars-are-words?]
    "Creates a new alphabet instance from the specified set of characters."
    (print "** set up dictionaries...")
    (setv self.chars            (.join (if chars-are-words? "\n" "") chars)
          self.chars-are-words? chars-are-words?
          self.num-chars        (len chars)
          self.char-to-index    (dict (lfor i (enumerate chars) (, (last i) (first i))))
          self.index-to-char    (dict (lfor i (enumerate chars) i)))
    (print self.char-to-index)
    (print self.index-to-char))

  (defn char [self i]
    "Gets the character in the alphabet associated with the specified index."
    (get self.index-to-char i))

  (defn char-index [self c]
    "Gets the index in the alphabet associated with the specified character."
    (get self.char-to-index c)))

;;;-------------------------------------
;;; functions
;;;-------------------------------------

(defn build-dataset [text chars-are-words? lookback stride]
  "Builds a dataset from the specified text with the specified settings by
   compiling it to a one-hot encoded tensor."
  (setv chars    (sorted (if chars-are-words? (set (.split text)) (list (set text))))
        alphabet (Alphabet chars chars-are-words?)
        n        (// (- (len text) lookback 1) stride)
        x        (np.zeros (, n lookback (. alphabet num-chars)) :dtype np.bool)
        y        (np.zeros (, n          (. alphabet num-chars)) :dtype np.bool))
  (for [i (range n)]
    (setv a  (* i stride)
          s  (cut text a (+ a lookback))
          yc (. text [(+ a lookback)])
          p  (/ i n))
    (for [(, j xc) (enumerate s)]
      (setv (. x [i] [j] [(.char-index alphabet xc)]) 1))
    (setv (. y [i] [(.char-index alphabet yc)]) 1)
    (if (= (% i 10000) 0)
      (print (.format "\r{:.2f}%" (* p 100.0)) :end "")))
  (print "\r100.0%")
  (, alphabet x y))

(defn build-x [alphabet text]
  (setv x (np.zeros (, 1 (len text) (. alphabet num-chars)) :dtype np.bool))
  (for [(, i c) (enumerate text)]
    (setv (. x [0] [i] [(.char-index alphabet c)]) 1))
  x)

(defn download-file [url]
  "Downloads a file from the specified URL and returns its local path."
  (setv (, _, fn) (.split os.path url))
  (keras.utils.data-utils.get-file fn :origin url))

(defn load-model [path]
  "Loads the specified model."
  (setv alphabet-path (+ path ".txt")
        model-path    (+ path ".h5"))

  (with [f (open alphabet-path "r")]
    (setv chars (.read f)))

  (, (Alphabet chars False) (keras.models.load_model model-path)))

(defn load-source [s]
  "Loads the specified source, either a filename or an HTTP URL."
  (if (or (.startswith s "http://")
          (.startswith s "https://"))
    (read-file (download-file s))
    (read-file s)))

(defn load-all-sources [sources]
  "Loads all specified sources and returns them in a list."
 ;;(list-comp (load-source s) [s sources]))
   (print "sources:")
   (print sources)
   (list (load-source (first sources))))

(defn read-file [fn]
  "Reads and returns the contents of the specified file."
  (with [f (open fn "r")]
    (.read f)))

(defn save-model [alphabet model path]
  "Saves a model and alphabet to the specified path."
  (setv model-path (+ path ".h5"))
  (if (os.path.isfile model-path)
    (do
      (setv bak-path (+ model-path ".bak"))
      (if (os.path.isfile bak-path)
        (os.remove bak-path))
      (os.rename model-path bak-path)))
  (.save model model-path)

  (setv alphabet-path (+ path ".txt"))
  (with [f (open alphabet-path "w")]
    ;;(.write f (. alphabet chars-are-words?))
    (.write f (. alphabet chars))))

(defn create-layer [spec first? last? alphabet model lookback]
  (if (= (.find spec ":") -1)
    (setv t "lstm"
          n (int spec))
    (setv (, t n) (.split spec ":")))
  (cond [(= t "dropout") (keras.layers.core.Dropout (float n))]
        [(= t "lstm")    (if (and first? (not last))
                           (keras.layers.recurrent.LSTM (int n)
                              :input-shape (, lookback (. alphabet num-chars))
                              :return-sequences True)
                           (keras.layers.recurrent.LSTM (int n)
                              :input-shape (, lookback (. alphabet num-chars))
                              :return-sequences (not last?)))]))

(defn create-model [alphabet layers learning-rate lookback]
  "Creates an LSTM-based RNN Keras model for text processing."
  (setv model (keras.models.Sequential))

  (for [(, i layer) (enumerate layers)]
    (setv first? (= i 0))
    (setv last? (= i (- (len layers) 1)))
    (setv layer (create-layer layer first? last? alphabet model lookback))
    (.add model layer))

  (.add model (keras.layers.core.Dense (. alphabet num-chars)
                 :activation "softmax"))

  (.compile model :loss      "categorical_crossentropy"
                  :metrics   ["categorical_accuracy"]
                  :optimizer (keras.optimizers.RMSprop :lr learning-rate))

  model)

(defn import-modules []
  "Imports modules needed by the program."
  (global keras np)
  (import keras
          keras.utils.data-utils
          [numpy :as np]))

(defn parse-args []
  "Parses command line arguments."
  (setv parser (argparse.ArgumentParser))

  (.add-argument parser "--batch-size" :default 128 :metavar "<n>" :type int
    :help "specify the batch size")

  (.add-argument parser "--cpu" :action "store_true"
    :help "only use cpu")

  (.add-argument parser "--generate" :metavar "<seed text>" :type str
    :help "generate text by specifying a seed")

  (.add-argument parser "--layers" :default "128" :metavar "<layers>" :type str
    :help "specify the layers (for example: lstm:128,dropout:0.2)")

  (.add-argument parser "--learning-rate" :default "0.01" :metavar "<rate>"
                                          :type float
    :help "specify the learning rate")

  (.add-argument parser "--lookback" :default 32 :metavar "<length>" :type int
    :help "specify the lookback (number of previous characters to look at)")

  (.add-argument parser "--lower" :action "store_true"
    :help "make source text lower case")

  (.add-argument parser "--model" :default "model" :metavar "<path>" :type str
    :help "specify the model filename")

  (.add-argument parser "--sources" :metavar "<path>" :nargs "*" :type str
    :help "specify the data sources to use")

  (.add-argument parser "--stride" :default 3 :metavar "<n>" :type int
    :help "specify the sliding window stride (in number of characters)")

  (.add-argument parser "--word-by-word" :action "store_true"
    :help "train word-by-word instead of character-by-character")

  (.parse-args parser))

(defn sample [y]
  "Samples a character index from the specified predictions."
  (setv y (.astype (np.asarray y) np.float64)
        y (np.log y)
        y-exp (np.exp y)
        y (/ y-exp (np.sum y-exp))
        p (np.random.multinomial 1 y 1))
  (np.argmax p))

(defn generate [alphabet model lookback seed]
  "Generates text using the specified settings."
  (print "\npress ctrl-c to exit\n\ngenerating...\n\n")

  (setv text seed)
  (while (< (len text) lookback)
    (setv text (+ " " text)))
  (setv text (cut text (- lookback)))

  (while True
    (setv x (build-x alphabet text)
          y (.predict model x)
          i (sample (. y [0]))
          c (.char alphabet i))
    (setv text (+ (cut text 1) c))
    (.write sys.stdout c)
    (.flush sys.stdout)))

(defn train [batch-size alphabet model x y model-name]
  (print "\npress ctrl-c to exit\n\ntraining...\n\n")

  (setv it 1)
  (while True
    (print "iteration" it)
    (setv it (inc it))
    (.fit model x y :batch-size batch-size :nb-epoch 1)
    (save-model alphabet model model-name)))

;;;-------------------------------------
;;; entry point
;;;-------------------------------------

(defmain [&rest args]
  "Program entry point."
  (print)

  (setv args (parse-args))

  (if args.word-by-word
    (do
      (print "word-by-word not yet implemented!")
      (import sys)
      (sys.exit 0)))

  (setv batch-size    (. args batch-size)
        layers        (.split (. args layers) ",")
        learning-rate (. args learning-rate)
        lookback      (. args lookback)
        stride        (. args stride)
        word-by-word? (. args word-by-word))

  (if (. args cpu)
    (assoc os.environ "CUDA_VISIBLE_DEVICES" ""))

  (print "initializing...")
  (import-modules)

  (setv model-name (. args model))
  (if (.endswith model-name ".h5")
    (setv model-name (cut model-name 0 -3)))

  (if (os.path.isfile (+ model-name ".h5"))
    (do
      (print "loading model...")
      (setv (, alphabet model) (load-model model-name)
            lookback           (. model layers [0] input-shape [1]))

      (if-not (. args generate)
        (do
          (print "loading sources...")
          (setv text (.join "" (load-all-sources (. args sources))))

          (if (. args lower)
            (setv text (.lower text)))

          (print "building dataset...")
          (setv (, alphabet x y) (build-dataset text word-by-word? lookback stride)))))
    (do
      (print "loading sources...")
      (setv text (.join "" (load-all-sources (. args sources))))

      (if (. args lower)
        (setv text (.lower text)))

      (print "building dataset...")
      (setv (, alphabet x y) (build-dataset text word-by-word? lookback stride))

      (print "creating model...")
      (setv model (create-model alphabet layers learning-rate lookback))))

  (.summary model)

  (try
    (if (. args generate)
      (generate alphabet model lookback (. args generate))
      (train batch-size alphabet model x y model-name))
    (except [e KeyboardInterrupt] (print "\n\n"))))
