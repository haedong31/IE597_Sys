# -*- coding: utf-8 -*-
import numpy as np
import matplotlib.pyplot as plt


## Problem 2 -----
def satlin(n):
    x = np.copy(n)
    x[x > 1] = 1
    x[x < -1] = -1
    
    return x

p = np.arange(-3, 3, step=0.1)
p = np.expand_dims(p, axis=0)

# weights - 1st layer
w1 = np.array([[2, 1]]).T
b1 = np.array([[2, -1]]).T

# weights - 2nd layer
w2 = np.array([[1, -1]])
b2 = np.array([[0]])

# 1st layer
n1 = np.dot(w1, p) + b1
a1 = satlin(n1)

# 2nd layer
n2 = np.dot(w2, a1) + b2
a2 = n2
    
# i.
figure, axis = plt.subplots(3, 2, figsize=(12, 12), dpi=300)
plt.subplots_adjust(hspace=1)
axis[0, 0].set_title('i. $n_1^1$')
axis[0, 0].plot(p[0, :], n1[0, :])
axis[0, 0].set_xlabel('p')

# ii.
axis[0, 1].set_title('ii. $a_1^1$')
axis[0, 1].plot(p[0, :], a1[0, :])
axis[0, 1].set_xlabel('p')

# iii.
axis[1, 0].set_title('iii. $n_2^1$')
axis[1, 0].plot(p[0, :], n1[1, :])
axis[1, 0].set_xlabel('p')

# iv.
axis[1, 1].set_title('iv. $a_2^1$')
axis[1, 1].plot(p[0, :], a1[1, :])
axis[1, 1].set_xlabel('p')

# v.
axis[2, 0].set_title('v. $n_1^2$')
axis[2, 0].plot(p[0, :], n2[0, :])
axis[2, 0].set_xlabel('p')

# vi.
axis[2, 1].set_title('vi. $a_1^2$')
axis[2, 1].plot(p[0, :], a2[0, :])
axis[2, 1].set_xlabel('p')

plt.tight_layout()
plt.show()
