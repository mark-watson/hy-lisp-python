#!/usr/bin/env hy

(import [os [scandir]])
(import [os.path [splitext exists]])

(defn process-directory [directory-name]
  (with [entries (scandir directory-name)]
    (for [entry entries]
      ;;(print entry.path)
      (setv [root-name file-extension] (splitext entry.name))
      (if (= file-extension ".txt")
        (do
          (setv check-file-name (+ (cut entry.path 0 -4) ".meta"))
          (if (exists check-file-name)
            (process-file entry.path check-file-name)
            (print "Warning: no .meta file for" entry.path "in directory" directory-name)))))))

(defn process-file [txt-path &optional meta-path]
  (print txt-path meta-path))
        



(process-directory "test_data")
