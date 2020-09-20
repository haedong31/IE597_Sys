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
    # x vector
    # y vector
    hat = b0 + b1*x

    sse = 1/(2*len(x)) * np.power(y - hat, 2)
    return sse

def gradient_learner(x, y, b0, b1, alpha):
    # estimation
    hat = b0 + b1*x

    # calculate derivatives
    wrt_b0 = 1/len(x) * (hat - y)
    wrt_b1 = 1/len(x) * np.multiply((hat - y), x)

    # update
    new_b0 = b0 - alpha * wrt_b0
    new_b1 = b1 - alpha * wrt_b1

    updated = [new_b0, new_b1]
    return updated


## problem a -----
sim_data = simulator(20, 3)
plt.scatter(sim_data[:,0], sim_data[:,1])


## problem b -----
tol = 0.01
alpha = 0.05

x = sim_data[:,0]
y = sim_data[:,1]

params = list()
fvals = list()

params.append([1, 1])
cnt = 0
while True:
    param = params[cnt]
    fvals.append(sse(x, y, param[0], param[1]))

    if fvals[cnt] < tol:
        break
    else:
        new_param = gradient_learner(x, y, param[0], param[1], alpha)
        params.append(new_param)
        cnt += 1
