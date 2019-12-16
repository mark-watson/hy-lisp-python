#!/usr/bin/env hy

(import [os [scandir]])
(import [os.path [splitext exists]])

(defn process-directory [directory-name]
  (with [entries (scandir directory-name)]
    (for [entry entries]
      ;;(print entry.path)
      (setv [_ file-extension] (splitext entry.name))
      (if (= file-extension ".txt")
        (do
          (setv check-file-name (+ (cut entry.path 0 -4) ".meta"))
          (if (exists check-file-name)
            (process-file entry.path check-file-name)
            (print "Warning: no .meta file for" entry.path "in directory" directory-name)))))))

(defn process-file [txt-path meta-path]
  (print txt-path meta-path)
  (setv [txt meta] (read-data txt-path meta-path))
  (print txt meta))
        
(defn read-data [txt-path meta-path]
  (setv f1 (open txt-path))
  (setv f2 (open meta-path))
  (setv t1 (.read f1)) (setv t2 (.read f2))
  (f1.close)           (f2.close)
  [t1 t2])


(process-directory "test_data")
