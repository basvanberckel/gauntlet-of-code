filename =: < 'cases/input/1'

readfile =: 1!:1

ls =: 3 : 0
ls1 =. 1!:0 y
ls2 =. 0{"1 ls1
ls3 =. > ls2
)

readarr =: 3 : 0
arr1 =. readfile y
arr2 =. cutopen arr1
arr3 =. ". each arr2
arr4 =. > arr3
)

arr =: readarr filename


NB. solution
+/ 2 </\ arr