# -*- coding: utf-8 -*-
import numpy as np
import matplotlib.pyplot as plt


## user-defined functions -----
def simulator(n, sig):
    x = np.random.choice(2*n, n, replace=False)
    x.sort()
    
    e = np.random.normal(0, sig, n)
    y = 3.2 + 4.5*x + e
    
    x = np.expand_dims(x, axis=1)
    y = np.expand_dims(y, axis=1)
   
    sim_data = np.concatenate((x, y), axis=1)
    return sim_data

def sse(x, y, b0, b1):
    hat = b0 + b1*x

    sse = 1/(2*len(x)) * np.sum(np.power(y - hat, 2))
    return sse

def sse_grid(x, y, bb0, bb1):
    grid_size = bb0.shape

    ee = np.empty(shape=grid_size)
    row_size = grid_size[0]
    col_size = grid_size[1]

    for i in range(row_size):
        for j in range(col_size):
            ee[i,j] = sse(x, y, bb0[i,j], bb1[i,j])

    return ee

def gradient_learner(x, y, b0, b1, alpha):
    # estimation
    hat = b0 + b1*x

    # calculate derivatives
    wrt_b0 = 1/len(x) * np.sum(hat - y)
    wrt_b1 = 1/len(x) * np.sum(np.multiply((hat - y), x))

    # update
    new_b0 = b0 - alpha * wrt_b0
    new_b1 = b1 - alpha * wrt_b1

    updated = [new_b0, new_b1]
    return updated


## problem a -----
sim_data = simulator(20, 1)
x = sim_data[:,0]
y = sim_data[:,1]

fig1, ax1 = plt.subplots(dpi=300)
ax1.scatter(x, y)
plt.xlabel('x')
plt.ylabel('y')


## problem b -----
alpha = 0.001
init_pt = [1, 1]
tol = 1.5
max_iter = 1000

cnt = 1
params = list()
fvals = list()

params.append(init_pt)
e = sse(x, y, init_pt[0], init_pt[1])
fvals.append(e)
# fvals.append(sse(x, y, init_pt[0], init_pt[1]))
params.append(gradient_learner(x, y, init_pt[0], init_pt[1], alpha))
while True:
    param = params[cnt]
    e = sse(x, y, param[0], param[1])
    fvals.append(e)
    # fvals.append(sse(x, y, param[0], param[1]))

    if (fvals[cnt]) < tol or cnt >= max_iter:
        break
    else:
        new_param = gradient_learner(x, y, param[0], param[1], alpha)
        params.append(new_param)
        cnt += 1


## problem c -----
bb0, bb1 = np.meshgrid(np.arange(-5, 5, 0.1), np.arange(-5, 5, 0.1))
ee = sse_grid(x, y, bb0, bb1)

b0_search = [p[0] for p in params]
b1_search = [p[1] for p in params]

fig2, ax2 = plt.subplots(dpi=300)
cp = ax2.contour(bb0, bb1, ee)
ax2.clabel(cp, inline=True, fontsize=10)
ax2.scatter(b0_search, b1_search, color='red')
ax2.plot(b0_search[-1], b1_search[-1], marker='*', color='yellow')
plt.xlabel('b0 (Intercept)')
plt.ylabel('b1 (Slope)')

best_param = params[-1]
x4fit = np.arange(0, 40, 0.01)
y4fit = best_param[0] + best_param[1]*x4fit

fig3, ax3 = plt.subplots(dpi=300)
ax3.scatter(x, y)
ax3.plot(x4fit, y4fit, color='red')
plt.xlabel('x')
plt.ylabel('y')
plt.legend()