(import graphviz [Digraph]) ;; directional graph

(setv dot (Digraph :comment "Plt sample UMLS from MultiHop Paper Data"))
(setv input-file (open "test.triples" "r"))
(setv lines (.readlines input-file))

(for [line lines]
  (setv tokens (.split (.strip line)))
  (.node dot (get tokens 0))
  (.node dot (get tokens 1))
  (.edge dot (get tokens 0) (get tokens 1) :label (get tokens 2)))

(print "start rendering graph...")

(.render dot "mhop.gv" :view True)


