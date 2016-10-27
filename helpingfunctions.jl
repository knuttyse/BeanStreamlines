function initialize(filename, numberOfLines::Int64)

    # critical current init:
    jc = readcsv("jc.csv")
    s = size(jc)

    # number of rows and collumns:
    nx = s[1]
    ny = s[2]

    # distance between streamlines:
    distance = zeros(Int64, (nx,ny))
    distanceScaling = round(min(nx, ny) / (2.0*numberOfLines))
    println("nx, ny = " * string(nx) * ", " *string(ny))
    println("distanceScaling = " * string(distanceScaling))
    for i in 1:nx
        for j in 1:ny
            distance[i,j] = round(distanceScaling/jc[i,j])
        end
    end

    # The matrix of current stream lines:
    J = falses(nx, ny)
    J[1,:] = true
    J[nx,:] = true
    J[:,ny] = true
    J[:,1] = true

    # the indices for which J[currIndX[k],currIndY[k]]
    # are true:
    currIndX = Int64[]
    currIndY = Int64[]

    for i in 1:nx
        for j in 1:ny
            if J[i,j]
                push!(currIndX, i)
                push!(currIndY, j)
            end
        end
    end

    # boolean matrix init:
    boolMat = trues(nx,ny)

    return (distance, J, nx, ny, currIndX, currIndY, boolMat)

end

function solve(data)
    dist, J, nx, ny, currIndX, currIndY, boolMat= data

    # As long as there is space for more current in the current
    # matrix J:
    while any1(boolMat)
        # Update which elements of the sample that we are allowed
        # to add current to:
        updateBoolMat(currIndX, currIndY, dist, nx, ny, boolMat)
        # From a new boolean matrix created above we will
        # drawCurrentline the next iteration of current lines:
        currIndX, currIndY = drawCurrentline(boolMat, J, nx, ny)
    end

    return J
end

"""
Checks if multidimensional bitarray has a 1
returns true if one or more elements contains 1
"""
function any1(mat::BitArray{2})
    s = size(mat)
    for h in 1:s[1]
        for k in 1:s[2]
            if mat[h,k]
                return true
            end
        end
    end
    return false
end

"""
Given the indices of the latest streamlines,
the function modifies the booleanMatrix.
The elements of the booleanMatrix which are
within a certain distance of streamline elements
are set to zero.
"""
function updateBoolMat(currIndX::Array{Int64,1},
                       currIndY::Array{Int64,1},
                       distance::Array{Int64,2},
                       nx::Int64, ny::Int64,
                       bolsk_matrise::BitArray{2})

    s = size(currIndX)
    length = s[1]

    # Iterate through the elements that are within
    # a distance distance[x,y] of element (x,y)
    for k in 1:length
        x = currIndX[k]
        y = currIndY[k]

        spacing = distance[x,y]
        spacing2 = spacing*spacing
        i_min = max(x - spacing, 1)
        i_max = min(x + spacing, nx)

        for i in i_min:i_max
            deltaX = i-x
            deltaX2 = deltaX*deltaX
            inted_semi_circle = isqrt(spacing2 - deltaX2)

            j_min = max(1,  y - inted_semi_circle )
            j_max = min(ny, y + inted_semi_circle)
            for j in j_min:j_max
                bolsk_matrise[i,j] = 0
            end
        end
    end
end

function testIfNeighboursHave0(mat::BitArray{2},
                               x::Int64, y::Int64,
                               nx::Int64, ny::Int64)
    # Avoid index out of bouds errors:
    i_min = max(1,x-1)
    j_min = max(1,y-1)
    i_max = min(nx,x+1)
    j_max = min(ny,y+1)

    # check elements:
    for i in i_min:i_max
        for j in j_min:j_max
            if !mat[i,j]
                return true
            end
        end
    end

    # returns false if no zeros in neighbours
    return false
end

"""
Given a BitArray{2}, yields an the indices of
where current lines should be placed.
"""
function drawCurrentline(boolMat::BitArray{2},
                         J::BitArray{2}, nx::Int64,
                         ny::Int64)
    currIndX = Int64[]
    currIndY = Int64[]

    for i in 1:nx
        for j in 1:ny
            # if the element is true and at least one of its
            # neighbours are false
            if boolMat[i,j] && testIfNeighboursHave0(boolMat,
                                                     i, j,
                                                     nx, ny)
                # Dra a pixel of current
                J[i,j] = 1
                # Add the indices of new current pixel to the
                # current indices:
                currIndX = push!(currIndX, i)
                currIndY = push!(currIndY, j)
            end
        end
    end

    return currIndX , currIndY
end
