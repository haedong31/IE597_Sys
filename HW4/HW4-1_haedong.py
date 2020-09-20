# -*- coding: utf-8 -*-
import numpy as np
import matplotlib.pyplot as plt


## user-defined functions -----
def obj_fn(x1, x2):
    """cost function (or objective function)

    Args:
        x1 (numpy array)
        x2 (numpy array)

    Returns:
        J (numpy array)
    """
    J = np.power(x2-x1, 4) + 8*np.multiply(x1, x2) - x1 + x2 + 3
    return J

def gradient_fn(x1, x2):
    wrt_x1 = -4*np.power(x2-x1, 3) + 8*x2 - 1
    wrt_x2 = 4*np.power(x2-x1, 3) + 8*x1 + 1
    
    grads = [wrt_x1, wrt_x2]
    return grads
    
def gradient_learner(x1, x2, alpha):
    grads = gradient_fn(x1, x2)
    
    new_x1 = x1 - alpha*grads[0]
    new_x2 = x2 - alpha*grads[1]
    
    updated = [new_x1, new_x2]
    return updated


## problem a -----
xx1, xx2 = np.meshgrid(np.arange(-1, 1, 0.01), np.arange(-1, 1, 0.01))
jj = obj_fn(xx1, xx2)

fig1, ax1 = plt.subplots()
cm = ax1.pcolormesh(xx1, xx2, jj)
fig1.colorbar(cm, ax=ax1)

fig2, ax2 = plt.subplots()
cp = ax2.contour(xx1, xx2, jj)
ax2.clabel(cp, inline=True, fontsize=10)


## problem b to d -----
# learning parameters
iters = 50000
alpha = 0.00000001
init_pt = [10, -40]

pts = list()
pts.append(init_pt)

fvals = list()
for i in range(iters):
    pt = pts[i]
    fvals.append(obj_fn(pt[0], pt[1]))

    pts.append(gradient_learner(pt[0], pt[1], alpha))
    