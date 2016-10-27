import numpy as np

jc = np.loadtxt("jc.txt")

jc= jc[146:-146,146:-146]

np.savetxt("jc.csv", jc, delimiter=",")
