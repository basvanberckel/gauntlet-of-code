filename =: < 'cases/input/2'

readfile =: 1!:1

readarr =: 3 : 0
arr1 =. readfile y
arr2 =. cutopen arr1
NB. arr3 =. ". each arr2
NB. arr4 =. > arr2
)

arr =: readarr filename

priolower =: 3 : 0
1 + y - (a. i. 'a')
)
prioupper =: 3 : 0
27 + y - (a. i. 'A')
)

solveline =: 3 : 0
len =.  -: {. # y
first =. len {. y
second =. len }. y
match =. ({.(I. first e. second)) { first
ascii =. a. i. match
result =. ((priolower`prioupper)@.(ascii < (a.i.'a')))ascii
)

+/ > solveline each arr