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

solvegroup =: 3 : 0
first =. > 0 { y
second =. > 1 { y
third =: > 2 { y
match =. ({.(I. (first e. second) *. (first e. third))) { first
ascii =. a. i. match
result =. ((priolower`prioupper)@.(ascii < (a.i.'a')))ascii
)

+/ (3,:3) (solvegroup;._3) arr