# -*- coding: utf-8 -*-
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import cm
from mpl_toolkits.mplot3d import Axes3D


## Problrm 1 -----
def perform_idx(w, b, p, t):
    term1 = np.power(t[0] - (w*p[0] + b), 2)
    term2 = np.power(t[1] - (w*p[1] + b), 2)
    f = term1 + term2
    
    return f

def steepest_descent(w, b, p, t, alpha):
    # derivatives
    dFdw = -2*p[0]*(t[0]-p[0]*w-b)-2*p[1]*(t[1]-p[1]*w-b)
    dFdb = -2*(t[0]-p[0]*w-b)-2*(t[1]-p[1]*w-b)

    new_w = w - alpha*dFdw
    new_b = b - alpha*dFdb

    return new_w, new_b

# desired input and output
p = np.array([2, -1])
t = np.array([0.5, 0])


## 1-(1) sketch the performance index -----
# weights
w = np.arange(-3, 3, step=0.01)
b = np.arange(-3, 3, step=0.01)

ww, bb = np.meshgrid(w, b)
ff = perform_idx(ww, bb, p, t)

fig1 = plt.figure(dpi=300)
ax1 = Axes3D(fig1)
surf = ax1.plot_surface(ww, bb, ff, cmap=cm.coolwarm)
ax1.set_zlabel('F(w, b)')
ax1.set_xlabel('w')
ax1.set_ylabel('b')
fig1.colorbar(surf)
plt.show()


## 1-(2) 1-iteration performance optimization -----
w0 = 1
b0 = 1
new_w, new_b = steepest_descent(w0, b0, p, t, 0.05)
print(f'Updated w: {new_w:.4f} | Updated b: {new_b:.4f}')


# 1-(3) stationary point
max_iter = 50
opt_paths = list()
opt_paths.append([w0, b0])

w, b = steepest_descent(w0, b0, p, t, 0.05)
opt_paths.append([w, b])
cnt = 1
while cnt < max_iter:
    w, b = steepest_descent(w, b, p, t, 0.05)
    opt_paths.append([w, b])
    cnt += 1
    
wsearch = [x[0] for x in opt_paths]
bsearch = [x[1] for x in opt_paths]
    
fig2, ax2 = plt.subplots(dpi=300)
cp = ax2.contour(ww, bb, ff)
ax2.clabel(cp, inline=True, fontsize=10)
ax2.scatter(wsearch, bsearch, color='red')
ax2.plot(wsearch[-1], bsearch[-1], marker='*', color='yellow')
