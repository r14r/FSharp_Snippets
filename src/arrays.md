### [snippet.0001.fs](snippet.0001.fs)
```
let array1 = [| 1; 2; 3 |]
```

### [snippet.0002.fs](snippet.0002.fs)
```
let array1 =
    [|
        1
        2
        3
     |]
```

### [snippet.0003.fs](snippet.0003.fs)
```
let array3 = [| for i in 1 .. 10 -> i * i |]
```

### [snippet.0004.fs](snippet.0004.fs)
```
let arrayOfTenZeroes : int array = Array.zeroCreate 10
```

### [snippet.0005.fs](snippet.0005.fs)
```
array1[0]
```

### [snippet.0006.fs](snippet.0006.fs)
```
array1[0..2]
```

### [snippet.0007.fs](snippet.0007.fs)
```
array1[..2]
```

### [snippet.0008.fs](snippet.0008.fs)
```
array1[2..]
```

### [snippet.0009.fs](snippet.0009.fs)
```
let array1 = Array.create 10 ""
for i in 0 .. array1.Length - 1 do
    Array.set array1 i (i.ToString())
for i in 0 .. array1.Length - 1 do
    printf "%s " (Array.get array1 i)
```

### [snippet.0010.fs](snippet.0010.fs)
```
let myEmptyArray = Array.empty
printfn "Length of empty array: %d" myEmptyArray.Length
```

### [snippet.0011.fs](snippet.0011.fs)
```
open System.Text

let firstArray : StringBuilder array = Array.init 3 (fun index -> new StringBuilder(""))
let secondArray = Array.copy firstArray
// Reset an element of the first array to a new value.
firstArray[0] <- new StringBuilder("Test1")
// Change an element of the first array.
firstArray[1].Insert(0, "Test2") |> ignore
printfn "%A" firstArray
printfn "%A" secondArray
```

### [snippet.0012.fs](snippet.0012.fs)
```
let a1 = [| 0 .. 99 |]
let a2 = Array.sub a1 5 10
printfn "%A" a2
```

### [snippet.0013.fs](snippet.0013.fs)
```
printfn "%A" (Array.append [| 1; 2; 3|] [| 4; 5; 6|])
```

### [snippet.0014.fs](snippet.0014.fs)
```
printfn "%A" (Array.choose (fun elem -> if elem % 2 = 0 then
                                            Some(float (elem*elem - 1))
                                        else
                                            None) [| 1 .. 10 |])
```

### [snippet.0015.fs](snippet.0015.fs)
```
printfn "%A" (Array.collect (fun elem -> [| 0 .. elem |]) [| 1; 5; 10|])
```

### [snippet.0016.fs](snippet.0016.fs)
```
Array.concat [ [|0..3|] ; [|4|] ]
//output [|0; 1; 2; 3; 4|]

Array.concat [| [|0..3|] ; [|4|] |]
//output [|0; 1; 2; 3; 4|]
```

### [snippet.0017.fs](snippet.0017.fs)
```
printfn "%A" (Array.filter (fun elem -> elem % 2 = 0) [| 1 .. 10|])
```

### [snippet.0018.fs](snippet.0018.fs)
```
let stringReverse (s: string) =
    System.String(Array.rev (s.ToCharArray()))

printfn "%A" (stringReverse("!dlrow olleH"))
```

### [snippet.0019.fs](snippet.0019.fs)
```
[| 1 .. 10 |]
|> Array.filter (fun elem -> elem % 2 = 0)
|> Array.choose (fun elem -> if (elem <> 8) then Some(elem*elem) else None)
|> Array.rev
|> printfn "%A"
```

### [snippet.0020.fs](snippet.0020.fs)
```
let my2DArray = array2D [ [ 1; 0]; [0; 1] ]
```

### [snippet.0021.fs](snippet.0021.fs)
```
let arrayOfArrays = [| [| 1.0; 0.0 |]; [|0.0; 1.0 |] |]
let twoDimensionalArray = Array2D.init 2 2 (fun i j -> arrayOfArrays[i][j])
```

### [snippet.0022.fs](snippet.0022.fs)
```
twoDimensionalArray[0, 1] <- 1.0
```

### [snippet.0023.fs](snippet.0023.fs)
```
let allNegative = Array.exists (fun elem -> abs (elem) = elem) >> not
printfn "%A" (allNegative [| -1; -2; -3 |])
printfn "%A" (allNegative [| -10; -1; 5 |])
printfn "%A" (allNegative [| 0 |])


let haveEqualElement = Array.exists2 (fun elem1 elem2 -> elem1 = elem2)
printfn "%A" (haveEqualElement [| 1; 2; 3 |] [| 3; 2; 1|])
```

### [snippet.0024.fs](snippet.0024.fs)
```
let allPositive = Array.forall (fun elem -> elem > 0)
printfn "%A" (allPositive [| 0; 1; 2; 3 |])
printfn "%A" (allPositive [| 1; 2; 3 |])


let allEqual = Array.forall2 (fun elem1 elem2 -> elem1 = elem2)
printfn "%A" (allEqual [| 1; 2 |] [| 1; 2 |])
printfn "%A" (allEqual [| 1; 2 |] [| 2; 1 |])
```

### [snippet.0025.fs](snippet.0025.fs)
```
let arrayA = [| 2 .. 100 |]
let delta = 1.0e-10
let isPerfectSquare (x:int) =
    let y = sqrt (float x)
    abs(y - round y) < delta
let isPerfectCube (x:int) =
    let y = System.Math.Pow(float x, 1.0/3.0)
    abs(y - round y) < delta
let element = Array.find (fun elem -> isPerfectSquare elem && isPerfectCube elem) arrayA
let index = Array.findIndex (fun elem -> isPerfectSquare elem && isPerfectCube elem) arrayA
printfn "The first element that is both a square and a cube is %d and its index is %d." element index
```

### [snippet.0026.fs](snippet.0026.fs)
```
let delta = 1.0e-10
let isPerfectSquare (x:int) =
    let y = sqrt (float x)
    abs(y - round y) < delta
let isPerfectCube (x:int) =
    let y = System.Math.Pow(float x, 1.0/3.0)
    abs(y - round y) < delta
let lookForCubeAndSquare array1 =
    let result = Array.tryFind (fun elem -> isPerfectSquare elem && isPerfectCube elem) array1
    match result with
    | Some x -> printfn "Found an element: %d" x
    | None -> printfn "Failed to find a matching element."

lookForCubeAndSquare [| 1 .. 10 |]
lookForCubeAndSquare [| 100 .. 1000 |]
lookForCubeAndSquare [| 2 .. 50 |]
```

### [snippet.0027.fs](snippet.0027.fs)
```
let findPerfectSquareAndCube array1 =
    let delta = 1.0e-10
    let isPerfectSquare (x:int) =
        let y = sqrt (float x)
        abs(y - round y) < delta
    let isPerfectCube (x:int) =
        let y = System.Math.Pow(float x, 1.0/3.0)
        abs(y - round y) < delta
    // intFunction : (float -> float) -> int -> int
    // Allows the use of a floating point function with integers.
    let intFunction function1 number = int (round (function1 (float number)))
    let cubeRoot x = System.Math.Pow(x, 1.0/3.0)
    // testElement: int -> (int * int * int) option
    // Test an element to see whether it is a perfect square and a perfect
    // cube, and, if so, return the element, square root, and cube root
    // as an option value. Otherwise, return None.
    let testElement elem =
        if isPerfectSquare elem && isPerfectCube elem then
            Some(elem, intFunction sqrt elem, intFunction cubeRoot elem)
        else None
    match Array.tryPick testElement array1 with
    | Some (n, sqrt, cuberoot) -> printfn "Found an element %d with square root %d and cube root %d." n sqrt cuberoot
    | None -> printfn "Did not find an element that is both a perfect square and a perfect cube."

findPerfectSquareAndCube [| 1 .. 10 |]
findPerfectSquareAndCube [| 2 .. 100 |]
findPerfectSquareAndCube [| 100 .. 1000 |]
findPerfectSquareAndCube [| 1000 .. 10000 |]
findPerfectSquareAndCube [| 2 .. 50 |]
```

### [snippet.0028.fs](snippet.0028.fs)
```
let arrayFill1 = [| 1 .. 25 |]
Array.fill arrayFill1 2 20 0
printfn "%A" arrayFill1
```

### [snippet.0029.fs](snippet.0029.fs)
```
let avg2 = Array.averageBy (fun elem -> float elem) [|1 .. 10|]
printfn "%f" avg2
```

### [snippet.0030.fs](snippet.0030.fs)
```
let array1 = [| 1 .. 10 |]
let array2 = Array.zeroCreate 20
// Copy 4 elements from index 3 of array1 to index 5 of array2.
Array.blit array1 3 array2 5 4
printfn "%A" array2
```

### [snippet.0031.fs](snippet.0031.fs)
```
let array1 = [| 1 .. 10 |]
let array2 = Array.copy array1
printfn "%A\n%A" array1 array2
```

### [snippet.0032.fs](snippet.0032.fs)
```
let sumArray array = Array.fold (fun acc elem -> acc + elem) 0 array
printfn "Sum of the elements of array %A is %d." [ 1 .. 3 ] (sumArray [| 1 .. 3 |])

// The following example computes the average of a array.
let averageArray array = (Array.fold (fun acc elem -> acc + float elem) 0.0 array / float array.Length)

// The following example computes the standard deviation of a array.
// The standard deviation is computed by taking the square root of the
// sum of the variances, which are the differences between each value
// and the average.
let stdDevArray array =
    let avg = averageArray array
    sqrt (Array.fold (fun acc elem -> acc + (float elem - avg) ** 2.0 ) 0.0 array / float array.Length)

let testArray arrayTest =
    printfn "Array %A average: %f stddev: %f" arrayTest (averageArray arrayTest) (stdDevArray arrayTest)

testArray [|1; 1; 1|]
testArray [|1; 2; 1|]
testArray [|1; 2; 3|]

// Array.fold is the same as to Array.iter when the accumulator is not used.
let printArray array = Array.fold (fun acc elem -> printfn "%A" elem) () array
printArray [|0.0; 1.0; 2.5; 5.1 |]
```

### [snippet.0033.fs](snippet.0033.fs)
```
let removeOutliers array1 min max =
    Array.partition (fun elem -> elem > min && elem < max) array1
    |> fst
removeOutliers [| 1 .. 100 |] 50 60
|> printf "%A"
```

### [snippet.0034.fs](snippet.0034.fs)
```
let printPermutation n array1 =
    let length = Array.length array1
    if (n > 0 && n < length) then
        Array.permute (fun index -> (index + n) % length) array1
    else
        array1
    |> printfn "%A"
let array1 = [| 1 .. 5 |]
// There are 5 valid permutations of array1, with n from 0 to 4.
for n in 0 .. 4 do
    printPermutation n array1
```

### [snippet.0035.fs](snippet.0035.fs)
```
let initialBalance = 1122.73
let transactions = [| -100.00; +450.34; -62.34; -127.00; -13.50; -12.92 |]

let balances =
    (initialBalance, transactions) 
    ||> Array.scan (fun balance transactionAmount -> balance + transactionAmount) 

printfn "Initial balance:\n $%10.2f" initialBalance
printfn "Transaction   Balance"

for i in 0 .. transactions.Length - 1 do
    printfn "$%10.2f $%10.2f" transactions[i] balances[i]

printfn "Final balance:\n $%10.2f" balances[ balances.Length - 1]
```

### [snippet.0036.fs](snippet.0036.fs)
```
// An array of functions that transform
// integers. (int -> int)
let ops1 =
 [| fun x -> x + 1
    fun x -> x + 2
    fun x -> x - 5 |]

let ops2 =
 [| fun x -> x + 1
    fun x -> x * 5
    fun x -> x * x |]

// Compare scan and scanBack, which apply the
// operations in the opposite order.
let compareOpOrder ops x0 =
    let xs1 = Array.scan (fun x op -> op x) x0 ops
    let xs2 = Array.scanBack (fun op x -> op x) ops x0

    // Print the intermediate results
    let xs = Array.zip xs1 (Array.rev xs2)
    for (x1, x2) in xs do
        printfn "%10d %10d" x1 x2
    printfn ""

compareOpOrder ops1 10
compareOpOrder ops2 10
```

### [snippet.0037.fs](snippet.0037.fs)
```
let sortedArray1 = Array.sort [|1; 4; 8; -2; 5|]
printfn "%A" sortedArray1
```

### [snippet.0038.fs](snippet.0038.fs)
```
let sortedArray2 = Array.sortBy (fun elem -> abs elem) [|1; 4; 8; -2; 5|]
printfn "%A" sortedArray2
```

### [snippet.0039.fs](snippet.0039.fs)
```
type Widget = { ID: int; Rev: int }

let compareWidgets widget1 widget2 =
   if widget1.ID < widget2.ID then -1 else
   if widget1.ID > widget2.ID then 1 else
   if widget1.Rev < widget2.Rev then -1 else
   if widget1.Rev > widget2.Rev then 1 else
   0

let arrayToSort =
 [|
    { ID = 92; Rev = 1 }
    { ID = 110; Rev = 1 }
    { ID = 100; Rev = 5 }
    { ID = 100; Rev = 2 }
    { ID = 92; Rev = 1 }
 |]

let sortedWidgetArray = Array.sortWith compareWidgets arrayToSort
printfn "%A" sortedWidgetArray
```

### [snippet.0040.fs](snippet.0040.fs)
```
let array1 = [|1; 4; 8; -2; 5|]
Array.sortInPlace array1
printfn "%A" array1
```

### [snippet.0041.fs](snippet.0041.fs)
```
let array1 = [|1; 4; 8; -2; 5|]
Array.sortInPlaceBy (fun elem -> abs elem) array1
printfn "%A" array1
```

### [snippet.0042.fs](snippet.0042.fs)
```
type Widget = { ID: int; Rev: int }

let compareWidgets widget1 widget2 =
   if widget1.ID < widget2.ID then -1 else
   if widget1.ID > widget2.ID then 1 else
   if widget1.Rev < widget2.Rev then -1 else
   if widget1.Rev > widget2.Rev then 1 else
   0

let array1 =
 [|
    { ID = 92; Rev = 1 }
    { ID = 110; Rev = 1 }
    { ID = 100; Rev = 5 }
    { ID = 100; Rev = 2 }
    { ID = 92; Rev = 1 }
 |]

Array.sortInPlaceWith compareWidgets array1
printfn "%A" array1
```

### [snippet.0043.fs](snippet.0043.fs)
```
let average1 = Array.average [| 1.0 .. 10.0 |]
printfn "Average: %f" average1
// To get the average of an array of integers,
// use Array.averageBy to convert to float.
let average2 = Array.averageBy (fun elem -> float elem) [|1 .. 10 |]
printfn "Average: %f" average2
```

### [snippet.0044.fs](snippet.0044.fs)
```
// Specify the type by using a type argument.
let array1 = Array.empty<int>
// Specify the type by using a type annotation.
let array2 : int array = Array.empty

// Even though array3 has a generic type,
// you can still use methods such as Length on it.
let array3 = Array.empty
printfn "Length of empty array: %d" array3.Length
```

### [snippet.0045.fs](snippet.0045.fs)
```
// Use Array.fold2 to perform computations over two arrays (of equal size)
// at the same time.
// Example: Add the greater element at each array position.
let sumGreatest array1 array2 =
    Array.fold2 (fun acc elem1 elem2 ->
        acc + max elem1 elem2) 0 array1 array2

let sum = sumGreatest [| 1; 2; 3 |] [| 3; 2; 1 |]
printfn "The sum of the greater of each pair of elements in the two arrays is %d." sum
```

### [snippet.0046.fs](snippet.0046.fs)
```
// This computes 3 - 2 - 1, which evalates to -6.
let subtractArray array1 = Array.fold (fun acc elem -> acc - elem) 0 array1
printfn "%d" (subtractArray [| 1; 2; 3 |])

// This computes 3 - (2 - (0 - 1)), which evaluates to 2.
let subtractArrayBack array1 = Array.foldBack (fun elem acc -> elem - acc) array1 0
printfn "%d" (subtractArrayBack [| 1; 2; 3 |])
```

### [snippet.0047.fs](snippet.0047.fs)
```
type Transaction =
    | Deposit
    | Withdrawal

let transactionTypes = [| Deposit; Deposit; Withdrawal |]
let transactionAmounts = [| 100.00; 1000.00; 95.00 |]
let initialBalance = 200.00

let endingBalance = Array.foldBack2 (fun elem1 elem2 acc ->
                        match elem1 with
                        | Deposit -> acc + elem2
                        | Withdrawal -> acc - elem2)
                        transactionTypes
                        transactionAmounts
                        initialBalance
printfn "Ending balance: $%.2f" endingBalance
```

### [snippet.0048.fs](snippet.0048.fs)
```
let printArray array1 =
    if (Array.isEmpty array1) then
        printfn "There are no elements in this array."
    else
        printfn "This array contains the following elements:"
        Array.iter (fun elem -> printf "%A " elem) array1
        printfn ""
printArray [| "test1"; "test2" |]
printArray [| |]
```

### [snippet.0049.fs](snippet.0049.fs)
```
let array1 = [| 1; 2; 3 |]
let array2 = [| 4; 5; 6 |]
Array.iter (fun x -> printfn "Array.iter: element is %d" x) array1
Array.iteri(fun i x -> printfn "Array.iteri: element %d is %d" i x) array1
Array.iter2 (fun x y -> printfn "Array.iter2: elements are %d %d" x y) array1 array2
Array.iteri2 (fun i x y ->
               printfn "Array.iteri2: element %d of array1 is %d element %d of array2 is %d"
                 i x i y)
            array1 array2
```

### [snippet.0050.fs](snippet.0050.fs)
```
Array.length [| 1 .. 100 |] |> printfn "Length: %d"
Array.length [| |] |> printfn "Length: %d"
Array.length [| 1 .. 2 .. 100 |] |> printfn "Length: %d"
```

### [snippet.0051.fs](snippet.0051.fs)
```
// Accesses elements from 0 to 2.

array1[0..2]

// Accesses elements from the beginning of the array to 2.

array1[..2]

// Accesses elements from 2 to the end of the array.

array1[2..]
```

### [snippet.0052.fs](snippet.0052.fs)
```
let array1 = [| 1; 2; 3 |]
let array2 = [| 4; 5; 6 |]
let arrayOfSums = Array.map2 (fun x y -> x + y) array1 array2
printfn "%A" arrayOfSums
```

### [snippet.0053.fs](snippet.0053.fs)
```
let array1 = [| 1; 2; 3 |]
let newArray = Array.mapi (fun i x -> (i, x)) array1
printfn "%A" newArray
```

### [snippet.0054.fs](snippet.0054.fs)
```
let array1 = [| 1; 2; 3 |]
let array2 = [| 4; 5; 6 |]
let arrayAddTimesIndex = Array.mapi2 (fun i x y -> (x + y) * i) array1 array2
printfn "%A" arrayAddTimesIndex
```

### [snippet.0055.fs](snippet.0055.fs)
```
[| for x in -100 .. 100 -> 4 - x * x |]
|> Array.max
|> printfn "%A"
```

### [snippet.0056.fs](snippet.0056.fs)
```
[| -10.0 .. 10.0 |]
|> Array.maxBy (fun x -> 1.0 - x * x)
|> printfn "%A"
```

### [snippet.0057.fs](snippet.0057.fs)
```
[| for x in -100 .. 100 -> x * x - 4 |]
|> Array.min
|> printfn "%A"
```

### [snippet.0058.fs](snippet.0058.fs)
```
[| -10.0 .. 10.0 |]
|> Array.minBy (fun x -> x * x - 1.0)
|> printfn "%A"
```

### [snippet.0059.fs](snippet.0059.fs)
```
let array1 = Array.ofList [ 1 .. 10]
```

### [snippet.0060.fs](snippet.0060.fs)
```
let array1 = Array.ofSeq ( seq { 1 .. 10 } )
```

### [snippet.0061.fs](snippet.0061.fs)
```
let array1 = Array.ofSeq ( seq { 1 .. 10 } )
```

### [snippet.0062.fs](snippet.0062.fs)
```
let values = [| ("a", 1); ("b", 2); ("c", 3) |]

let resultPick = Array.pick (fun elem ->
                    match elem with
                    | (value, 2) -> Some value
                    | _ -> None) values
printfn "%A" resultPick
```

### [snippet.0063.fs](snippet.0063.fs)
```
// Computes ((1 - 2) - 3) - 4 = -8
Array.reduce (fun elem acc -> elem - acc) [| 1; 2; 3; 4 |]
|> printfn "%A"
// Computes 1 - (2 - (3 - 4)) = -2
Array.reduceBack (fun elem acc -> elem - acc) [| 1; 2; 3; 4 |]
|> printfn "%A"
```

### [snippet.0064.fs](snippet.0064.fs)
```
open System

let array1 = [| "<>"; "&"; "&&"; "&&&"; "<"; ">"; "|"; "||"; "|||" |]
printfn "Before sorting: "
array1 |> printfn "%A"
let sortFunction (string1:string) (string2:string) =
    if (string1.Length > string2.Length) then
       1
    else if (string1.Length < string2.Length) then
       -1
    else
        String.Compare(string1, string2)
Array.sortInPlaceWith sortFunction array1
printfn "After sorting: "
array1 |> printfn "%A"
```

### [snippet.0065.fs](snippet.0065.fs)
```
open System

let array1 = [| "<>"; "&"; "&&"; "&&&"; "<"; ">"; "|"; "||"; "|||" |]
printfn "Before sorting: "
array1 |> printfn "%A"
let sortFunction (string1:string) (string2:string) =
    if (string1.Length > string2.Length) then
       1
    else if (string1.Length < string2.Length) then
       -1
    else
        String.Compare(string1, string2)

Array.sortWith sortFunction array1
|> printfn "After sorting: \n%A"
```

### [snippet.0066.fs](snippet.0066.fs)
```
[| 1 .. 10 |]
|> Array.sum
|> printfn "Sum: %d"
```

### [snippet.0067.fs](snippet.0067.fs)
```
[| 1 .. 10 |]
|> Array.sumBy (fun x -> x * x)
|> printfn "Sum: %d"
```

### [snippet.0068.fs](snippet.0068.fs)
```
[| 1 .. 10 |]
|> Array.toList
|> List.rev
|> List.iter (fun elem -> printf "%d " elem)
printfn ""
```

### [snippet.0069.fs](snippet.0069.fs)
```
[| 1 .. 10 |]
|> Array.toSeq
|> Seq.truncate 5
|> Seq.iter (fun elem -> printf "%d " elem)
printfn ""
```

### [snippet.0070.fs](snippet.0070.fs)
```
let array1, array2 = Array.unzip [| (1, 2); (3, 4) |]
printfn "%A" array1
printfn "%A" array2
```

### [snippet.0071.fs](snippet.0071.fs)
```
let array1, array2, array3 = Array.unzip3 [| (1, 2,3 ); (3, 4, 5) |]
printfn "%A" array1
printfn "%A" array2
printfn "%A" array3
```

### [snippet.0072.fs](snippet.0072.fs)
```
let array1 = [| 1; 2; 3 |]
let array2 = [| -1; -2; -3 |]
let arrayZip = Array.zip array1 array2
printfn "%A" arrayZip
```

### [snippet.0073.fs](snippet.0073.fs)
```
let array1 = [| 1; 2; 3 |]
let array2 = [| -1; -2; -3 |]
let array3 = [| "horse"; "dog"; "elephant" |]
let arrayZip3 = Array.zip3 array1 array2 array3
printfn "%A" arrayZip3
```

### [snippet.0074.fs](snippet.0074.fs)
```
let binary n =
    let rec generateBinary n =
        if (n / 2 = 0) then [n]
        else (n % 2) :: generateBinary (n / 2)
    generateBinary n |> List.rev |> Array.ofList

printfn "%A" (binary 1024)

let resultArray = Array.distinct (binary 1024)
printfn "%A" resultArray
```

### [snippet.0075.fs](snippet.0075.fs)
```
let array1 = [| 1 .. 10 |]

// The following chunks the array into sub-arrays of size 2
printfn "%A" (Array.chunkBySize 2 array1)

// The following chunks the array into sub-arrays of size 3, with the last array being a single element
printfn "%A" (Array.chunkBySize 3 array1)
```

### [snippet.0076.fs](snippet.0076.fs)
```
let inputArray = [| -5 .. 10 |]
let printArray array1 = Array.iter (printf "%A ") array1; printfn ""
printfn "Original array: "
printArray inputArray
printfn "\nArray with distinct absolute values: "
let arrayDistinctAbsoluteValue = Array.distinctBy (fun elem -> abs elem) inputArray
arrayDistinctAbsoluteValue |> printArray
```

### [snippet.0091.fs](snippet.0091.fs)
```
let myEmptyArray = Array.empty
printfn "Length of empty array: %d" myEmptyArray.Length



printfn "Array of floats set to 5.0: %A" (Array.create 10 5.0)


printfn "Array of squares: %A" (Array.init 10 (fun index -> index * index))

let (myZeroArray : float array) = Array.zeroCreate 10
```

### [snippet.0100.fs](snippet.0100.fs)
```
printfn "Array of floats set to 5.0: %A" (Array.create 10 5.0)
```

### [snippet.0101.fs](snippet.0101.fs)
```
printfn "Array of squares: %A" (Array.init 10 (fun index -> index * index))
```

### [snippet.0114.fs](snippet.0114.fs)
```
let array1 = [| 1 .. 3 |]
let array2 = [| 1; 2; 4; |]

// Compare two arrays element by element.
let compareArrays = Array.compareWith (fun elem1 elem2 ->
    if elem1 > elem2 then 1
    elif elem1 < elem2 then -1
    else 0)

// Prints Array1 is less than Array2
match compareArrays array1 array2 with
| 1 -> printfn "Array1 is greater than Array2."
| -1 -> printfn "Array1 is less than Array2."
| 0 -> printfn "Array1 is equal to Array2."
| _ -> failwith("Invalid comparison result.")

let array3 = [| 1; 44; 3; |]
let array4 = [| 1; 2; |]

// Prints 42
printfn "%A" (Array.compareWith (fun elem1 elem2 -> elem1 - elem2) array3 array4)
```

### [snippet.0115.fs](snippet.0115.fs)
```
let array1 = [| 1 .. 100 |]
let printArray anarray =
    anarray
    |> Array.iter (printf "%A ")
    printfn ""
let arrayResult = Array.countBy (fun elem ->
    if (elem % 2 = 0) then 0 else 1) array1

printArray arrayResult
```

### [snippet.0231.fs](snippet.0231.fs)
```
let allNegative = Array.exists (fun elem -> abs (elem) = elem) >> not
printfn "%A" (allNegative [| -1; -2; -3 |])
printfn "%A" (allNegative [| -10; -1; 5 |])
printfn "%A" (allNegative [| 0 |])
```

### [snippet.0232.fs](snippet.0232.fs)
```
let haveEqualElement = Array.exists2 (fun elem1 elem2 -> elem1 = elem2)
printfn "%A" (haveEqualElement [| 1; 2; 3 |] [| 3; 2; 1|])
```

### [snippet.0241.fs](snippet.0241.fs)
```
let allPositive = Array.forall (fun elem -> elem > 0)
printfn "%A" (allPositive [| 0; 1; 2; 3 |])
printfn "%A" (allPositive [| 1; 2; 3 |])
```

### [snippet.0242.fs](snippet.0242.fs)
```
let allEqual = Array.forall2 (fun elem1 elem2 -> elem1 = elem2)
printfn "%A" (allEqual [| 1; 2 |] [| 1; 2 |])
printfn "%A" (allEqual [| 1; 2 |] [| 2; 1 |])
```

### [snippet.0510.fs](snippet.0510.fs)
```
let data = [| 1; 2; 3; 4 |]
let r1 = data |> Array.map (fun x -> x + 1)
printfn "Adding '1' using map = %A" r1
let r2 = data |> Array.map string
printfn "Converting to strings by using map = %A" r2
let r3 = data |> Array.map (fun x -> (x, x))
printfn "Converting to tupels by using map = %A" r3
```

### [snippet.0511.fs](snippet.0511.fs)
```
let array1 = [| 1 .. 10 |]
let array2 = Array.empty

//The following line prints true
printfn "%A" (Array.contains 5 array1)

//The following line prints false
printfn "%A" (Array.contains 5 array2)
```

