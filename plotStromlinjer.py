import numpy as np
import matplotlib.pyplot as plt
import matplotlib.cm as cm

filename = "streamlines.csv"
J = np.loadtxt(filename, delimiter=",")

jc = np.loadtxt("jc.txt")
jc = jc[146:-146,146:-146]

mat = J - jc

#plt.imshow(jc)
#plt.hold("on")
plt.imshow(mat, cmap=cm.Greys)
plt.axis("off")
plt.savefig("streamlinesJC64.pdf")
plt.show()
