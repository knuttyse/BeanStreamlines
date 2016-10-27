import numpy as np
import matplotlib.pyplot as plt
import matplotlib.cm as cm

filenameJ = "streamlines.csv"
filenamejc = "jc.csv"

J = np.loadtxt(filenameJ, delimiter=",")
jc = np.loadtxt(filenamejc, delimiter=",")

mat = J - jc

plt.imshow(mat, cmap=cm.Greys)
plt.axis("off")
plt.savefig("streamlines.pdf")
plt.show()
