#!/usr/bin/env hy

(import [pydash [py_]])

(defn lens [a-nested-hash lens-pattern]
  (py_.get a-nested-hash lens-pattern))
  