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
    """calculate gradient

    Args:
        x1 (numeric): 1st dim
        x2 (numeric): 2nd dim

    Returns:
        list: gradient at current point
    """
    wrt_x1 = -4*np.power(x2-x1, 3) + 8*x2 - 1
    wrt_x2 = 4*np.power(x2-x1, 3) + 8*x1 + 1
    
    grads = [wrt_x1, wrt_x2]
    return grads
    
def gradient_learner(x1, x2, alpha):
    """gradient learning algorithm

    Args:
        x1 (numeric): 1st dim
        x2 (numeric): 2nd dim
        alpha (numeric): learning rate

    Returns:
        list: next point
    """
    grads = gradient_fn(x1, x2)
    
    new_x1 = x1 - alpha*grads[0]
    new_x2 = x2 - alpha*grads[1]
    
    updated = [new_x1, new_x2]
    return updated


## problem a -----
xx1, xx2 = np.meshgrid(np.arange(-1, 1, 0.01), np.arange(-1, 1, 0.01))
jj = obj_fn(xx1, xx2)

fig1, ax1 = plt.subplots(dpi=300)
cm = ax1.pcolormesh(xx1, xx2, jj)
fig1.colorbar(cm, ax=ax1)

fig2, ax2 = plt.subplots(dpi=300)
cp = ax2.contour(xx1, xx2, jj)
ax2.clabel(cp, inline=True, fontsize=10)


## problem b to d -----
# learning parameters
alpha = 0.01
init_pt = [0, 0]
tol = 0.00001
max_iter = 500

cnt = 1
pts = list()
fvals = list()

# initialization
pts.append(init_pt)
fvals.append(obj_fn(init_pt[0], init_pt[1]))
pts.append(gradient_learner(init_pt[0], init_pt[1], alpha))
while True:
    pt = pts[cnt]
    fvals.append(obj_fn(pt[0], pt[1]))

    # check stopping criteria
    fdiff = abs(fvals[cnt] - fvals[cnt-1])
    if (fdiff < tol) or cnt==max_iter:
        break
    else:
        pts.append(gradient_learner(pt[0], pt[1], alpha))
        cnt += 1

x1_search = [x[0] for x in pts]
x2_search = [x[1] for x in pts]

fig3, ax3 = plt.subplots(dpi=300)
cp = ax3.contour(xx1, xx2, jj)
ax3.clabel(cp, inline=True, fontsize=10)
ax3.scatter(x1_search, x2_search, color='red')
ax3.plot(x1_search[-1], x2_search[-1], marker='*', color='yellow')

fig4, ax4 = plt.subplots(dpi=300)
p = ax4.scatter(np.arange(len(fvals)), fvals, s=1)
plt.xlabel('Iterations')
plt.ylabel('Objective function')
