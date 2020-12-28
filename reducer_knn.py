#! /usr/bin/env python3

import sys
import numpy as np

train = []
test = []
for line in sys.stdin:
	# line = line.strip()
	# print(line)
	head, result = line.split("\t",1)
	result = result.split(",")
	if(head == "train"):
		train.append(result)
	else:
		test.append(result)

for i in range(len(test)):
	for j in range(len(test[i])):
		test[i][j] = test[i][j].replace("[","").replace("]","").replace("\'","")
test = np.asarray(test)

for i in range(len(train)):
	for j in range(len(train[i])):
		train[i][j] = train[i][j].replace("[","").replace("]","").replace("\'","")
train = np.asarray(train)

X_train = train[:, :48]
Y_train = train[:,-1]
Y_train = np.reshape(Y_train, (Y_train.shape[0], 1))

test = test.astype(np.float)
X_train = X_train.astype(np.float)
K=11
b = 2*np.dot(test, X_train.T)
a = np.sum(test**2, axis =1)[:,np.newaxis]
distance = np.sum(X_train**2, axis =1) + a - b
sorted_distance = np.argsort(distance, axis = 1)
top_k_neigh = sorted_distance[:,:K]
result = []

for i in top_k_neigh:
	c, cot = np.unique(Y_train[i], return_counts = True)
	index = np.argmax(cot)
	result.append(c[index])

for i in range(test.shape[0]):
	print("%s\t%s" % (test[i], result[i]))
