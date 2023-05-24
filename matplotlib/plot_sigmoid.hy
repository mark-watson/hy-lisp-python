(import numpy :as np)
(import matplotlib.pyplot :as plt)

(defn sigmoid [x]
  (/ 1.0 (+ 1.0 (np.exp (- x)))))

(setv X (np.linspace -8 8 50))
(plt.plot X (sigmoid X))
(plt.title "Sigmoid Function")
(plt.ylabel "Sigmoid")
(plt.xlabel "X")
(plt.grid)
(plt.show)
