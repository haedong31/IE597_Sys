# -*- coding: utf-8 -*-
import cv2 as cv
import numpy as np
import matplotlib.pyplot as plt
from glob import glob
import keras
from keras.models import Sequential, Model
from keras.layers import Dense, Conv2D, Flatten, GlobalAveragePooling2D
from keras.utils import plot_model


## data preparation -----
data_paths = glob('.\\recurrence_matrix\\*.png')
test_size = 5

x = list()
y = list()
ko_idx = list()
wt_idx = list()
for i in range(len(data_paths)):
    # ground-truth labels
    if 'ko' in data_paths[i]:
        y.append(1)
        ko_idx.append(i)
    else:
        y.append(0)
        wt_idx.append(i)
        
    # import input images
    img = cv.imread(data_paths[i])
    img = cv.resize(img, (64, 64))
    x.append(img)
x = np.array(x)
y = np.array(y)

# image normalization
x = x / 255.0
x = x.astype('float')

# generate test dataset (15%)
test_idx_ko = np.random.choice(ko_idx, test_size, replace=False)
test_idx_wt = np.random.choice(wt_idx, test_size, replace=False)
test_idx = np.concatenate((test_idx_ko, test_idx_wt))
train_idx = [i for i in range(len(data_paths)) if i not in test_idx]

x_test = x[test_idx]
y_test = y[test_idx]

x_train = x[train_idx]
y_train = y[train_idx]


## model learning -----
model = Sequential()
model.add(Conv2D(16,input_shape=(64,64,3),kernel_size=(3,3),activation='relu',padding='same'))
model.add(Conv2D(32,kernel_size=(3,3),activation='relu',padding='same'))
model.add(GlobalAveragePooling2D())
model.add(Dense(2,activation='softmax'))
model.compile(loss='sparse_categorical_crossentropy',metrics=['accuracy'],optimizer='adam')
model.fit(x_train, y_train, batch_size=3, epochs=50, validation_split=0.1, shuffle=True)

# evaluation and saving
model.evaluate(x_test, y_test)
model.summary()
model.save('pilot1_50epochs.h5')


## CAM -----
gap_weights = model.layers[-1].get_weights()[0]
gap_weights.shape

cam = Model(inputs=model.input, outputs=(model.layers[-3].output, model.layers[-1].output))
cam.summary()

ftrs, rlts = cam.predict(x_test)
ftrs.shape

for i in range(10):
    cam_ftr = ftrs[i, :, :, :]
    pred = np.argmax(rlts[i])
    
    cam_weights = gap_weights[:, pred]
    cam_output = np.dot(cam_ftr, cam_weights)
    
    plt.figure(facecolor='white')
    plt.xlabel(f"Predicted Class = {pred} | True Class = {y_test[i]}")
    plt.imshow(x_test[i], alpha=0.5)
    plt.imshow(cam_output, cmap='jet', alpha=0.5)

    plt.show()
    