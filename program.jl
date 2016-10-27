include("helpingfunctions.jl")
outfile = "streamlines.csv"
infilename = "jc.csv"
numberOfLines = 50

data =  initialize(infilename, numberOfLines)

J = solve(data)
println("I am done with computing the streamlines,
but I have to write the data to file.")

writecsv(outfile, float(J))
print("I am done with everything. Data stored in "
 * string(outfile) )
