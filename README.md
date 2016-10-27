# BeanStreamlines
This program is used to calculate the streamlines in a Bean critical state sample.

Dependencies:
python 2.x, matplotlib, numpy, julia 0.5.x

USEAGE:

VARIABLES TOP SET: 
- Nx and Ny in makeJc.py: Set them to the desired dimensions. Higher dimensions are good for precission, but make sure that you avvoid disk-swapping which slows down the process.
- numberOfLines in program.jl: The more lines the tighter the streamlines will be drawn.

>> python makeJc.py
>> julia program.jl
nx, ny = 1000, 1000
distanceScaling = 10.0
I am done with computing the streamlines,
but I have to write the data to file.
I am done with everything. Data stored in streamlines.csv
>> python plotStromlinjer.py 

