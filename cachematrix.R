## Put comments here that give an overall description of what your
## functions do
# makeCacheMatrix: This function creates a special "matrix" object that can cache its inverse

# cacheSolve: Creates the inverse of the "matrix" returned by makeCacheMatrix above
#If the inverse has already been calculated (plus the matrix has not changed), 
#then the cachesolve will retrieve the inverse from the cache.

# Computing the inverse of a square matrix can be done with the solve function in R. 

## Write a short comment describing this function

# makeCacheMatrix: This function creates a special "matrix" object that can cache its inverse. 
# Run this function with the argument x as the matrix that needs to be inversed. This will return a list with set, get , setinverse,
getinverse function calls on x.

makeCacheMatrix <- function(x = matrix()) {
        invert <- NULL
        set <- function(y) {
                    x <<- y
                    invert <<- NULL
                }
        get <- function() {
                return(x) 
                }
        setinverse <- function(inverse) {
                invert <<- inverse 
                }
        getinverse <- function() { 
                invert 
                }
        list(set=set, get=get, setinverse=setinverse, getinverse=getinverse)

}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {

## Return a matrix that is the inverse of 'x'

    invert <- x$getinverse()
    if(!is.null(invert)) {
                message("already calculated inverse found, get cached data.")
        
        return(invert)
    }
     
    #When precalculted inverse not found for current matrix.. 
    #get the matrix data using matkecacheMatrix $get ..
    matrix_data<- x$get()
    #Invert matrix data
    invert <- solve(matrix_data)
    
    # set the inverted matrix in the Cache, using matkecacheMatrix$setinverse .. 
    x$setinverse(invert)
    invert
    
}

#...
#REsults of running this code..
#> x = rbind(c(2, 3, 5), c(1, 2, -3), c(4.5, 6, 10))
#> inv_matrix = makeCacheMatrix(x)
## > inv_matrix$get()
#       [,1] [,2] [,3]
#       [1,]  2.0    3    5
#       [2,]  1.0    2   -3
#       [3,]  4.5    6   10
#       > cacheSolve(inv_matrix)
#         [,1]          [,2]       [,3]
#       [1,] -4.0000000  3.454027e-16  2.0000000
#       [2,]  2.4736842  2.631579e-01 -1.1578947
#       [3,]  0.3157895 -1.578947e-01 -0.1052632
#       > cacheSolve(inv_matrix)
#       already calculated inverse found, get cached data.
#                  [,1]          [,2]       [,3]
#       [1,] -4.0000000  3.454027e-16  2.0000000
#       [2,]  2.4736842  2.631579e-01 -1.1578947
#       [3,]  0.3157895 -1.578947e-01 -0.1052632
#       
#       With a NEW DATASET
#       > x = rbind(c(2, 1, 5), c(-1, 2, 1), c(4, 6, 10))
#       >cacheSolve(inv_matrix)
#       already calculated inverse found, get cached data.
#       [,1]          [,2]       [,3]
#       [1,] -4.0000000  3.454027e-16  2.0000000
#       [2,]  2.4736842  2.631579e-01 -1.1578947
#       [3,]  0.3157895 -1.578947e-01 -0.1052632

#       > inv_matrix = makeCacheMatrix(x)
#       > cacheSolve(inv_matrix)
#       [,1]       [,2]       [,3]
#       [1,] -0.5 -0.7142857  0.3214286
#       [2,] -0.5  0.0000000  0.2500000
#       [3,]  0.5  0.2857143 -0.1785714
