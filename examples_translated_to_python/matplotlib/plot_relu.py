import numpy as np
import matplotlib.pyplot as plt


def relu(x):
    return np.maximum(0.0, x)


X = np.linspace(-8, 8, 50)
plt.plot(X, relu(X))
plt.title('Relu (Rectilinear) Function')
plt.ylabel('Relu')
plt.xlabel('X')
plt.grid()
plt.show()

