# -*- coding: utf-8 -*-
"""
Created on Thu Nov 12 13:38:41 2020

@author: Haedong Kim
"""


import numpy as np
import matplotlib.pyplot as plt
from matplotlib import cm
from mpl_toolkits.mplot3d import Axes3D


def Fx(x1, x2):
    """quadratic function in Problem 4

    Args:
        x1 (numpy array): 1-dimentional vector
        x2 (numpy array): 1-dimentional vector

    Returns:
        numpy array: function values 
    """
    order2 = 3*np.power(x1, 2) + 3*np.power(x2, 2) -2*x1*x2
    order1 = -x1 - x2
    
    Fx = order1 + order2

    return Fx

def steepest_desc(x1, x2, alpha):
    """simple steepest descent algorithm

    Args:
        x1 (numeric): 1st dimension of current point 
        x2 (numeric): 2nd dimension of current point
        alpha (numeric): learning rate

    Returns:
        tuple: pair of coordinates of next point
    """
    dx1 = 6*x1 - 2*x2 -1
    dx2 = -2*x1 + 6*x2 -1

    new_x1 = x1 - alpha*dx1
    new_x2 = x2 - alpha*dx2

    return [new_x1, new_x2]


## i. contour plot -----
x1, x2 = np.meshgrid(np.arange(-3, 3, step=0.01), np.arange(-3, 3, step=0.01))
z = Fx(x1, x2)

fig1, ax1 = plt.subplots(dpi=300)
ax1 = Axes3D(fig1)
surf1 = ax1.plot_surface(x1, x2, z, cmap=cm.coolwarm)

## ii. steepest descent algorithm -----
init_pt = [0, 0]
max_iter = 500
learning_rate = 0.1
cnt = 1
pts = list()
fvals = list()

# initialization
pts.append(init_pt)
fvals.append(Fx(init_pt[0], init_pt[1]))

# learning loop
print(f'Initial point: ({init_pt[0]:.2f}, {init_pt[1]:.2f})')
next_pt = steepest_desc(init_pt[0], init_pt[1], alpha=learning_rate)
pts.append(next_pt)
fvals.append(Fx(next_pt[0], next_pt[1]))
for i in range(max_iter-1):
    # print(f'New x1: {next_pt[0]:.1f} | New x2: {next_pt[1]:.1f}')
    next_pt = steepest_desc(next_pt[0], next_pt[1], alpha=learning_rate)
    pts.append(next_pt)
    fvals.append(Fx(next_pt[0], next_pt[1]))
print(f'Terminated at: ({next_pt[0]:.2f}, {next_pt[1]:.2f})')

# learning path
x1_search = [x[0] for x in pts]
x2_search = [x[1] for x in pts]

fig2, ax2 = plt.subplots(dpi=300)
cp = ax2.contour(x1, x2, z)
ax2.clabel(cp, inline=True, fontsize=10)
ax2.scatter(x1_search, x2_search, color='red')
ax2.plot(x1_search[-1], x2_search[-1], marker='*', color='yellow')

fig3, ax3 = plt.subplots(dpi=300)
p = ax3.scatter(np.arange(len(fvals)), fvals, s=1)
plt.xlabel('Iteration')
plt.ylabel('Function values')

fig4, ax4 = plt.subplots(dpi=300)
cp1 = ax4.contour(x1, x2, z)
ax4.clabel(cp1, inline=True, fontsize=10)
