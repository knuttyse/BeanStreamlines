import numpy as np

# Select x,y-dimensions of the sample:
Nx = 1000
Ny = 1000

# make stripes
jc = np.ones((Nx,Ny))
jc[Nx/2:Nx/3,:] = 0.8

np.savetxt("jc.csv", jc, delimiter=",")
