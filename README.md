# BeanStreamlines
This program is used to calculate the streamlines in a Bean critical state sample. The image is saved as a pdf-file.

Dependencies:
python 2.x, matplotlib, numpy, julia 0.5.x

USEAGE:

VARIABLES TOP SET: 
- Nx and Ny in makeJc.py: Set them to the desired dimensions. Higher dimensions are good for precission, but make sure that you avvoid disk-swapping which slows down the process.
- numberOfLines in program.jl: The more lines the tighter the streamlines will be drawn.

run these commands in terminal:

python makeJc.py
julia program.jl
python plotStromlinjer.py