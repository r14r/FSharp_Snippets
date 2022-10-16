### [snippet.0001.fs](snippet.0001.fs)
```
// Use List.exists to determine whether there is an element of a list satisfies a given Boolean expression.
// containsNumber returns true if any of the elements of the supplied list match
// the supplied number.
let containsNumber number list = List.exists (fun elem -> elem = number) list
let list0to3 = [0 .. 3]
printfn "For list %A, contains zero is %b" list0to3 (containsNumber 0 list0to3)
```

### [snippet.0002.fs](snippet.0002.fs)
```
// Use List.exists2 to compare elements in two lists.
// isEqualElement returns true if any elements at the same position in two supplied
// lists match.
let isEqualElement list1 list2 = List.exists2 (fun elem1 elem2 -> elem1 = elem2) list1 list2
let list1to5 = [ 1 .. 5 ]
let list5to1 = [ 5 .. -1 .. 1 ]
if (isEqualElement list1to5 list5to1) then
    printfn "Lists %A and %A have at least one equal element at the same position." list1to5 list5to1
else
    printfn "Lists %A and %A do not have an equal element at the same position." list1to5 list5to1
```

### [snippet.0003.fs](snippet.0003.fs)
```
let isAllZeroes list = List.forall (fun elem -> elem = 0.0) list
printfn "%b" (isAllZeroes [0.0; 0.0])
printfn "%b" (isAllZeroes [0.0; 1.0])
```

### [snippet.0004.fs](snippet.0004.fs)
```
let listEqual list1 list2 = List.forall2 (fun elem1 elem2 -> elem1 = elem2) list1 list2
printfn "%b" (listEqual [0; 1; 2] [0; 1; 2])
printfn "%b" (listEqual [0; 0; 0] [0; 1; 0])
```

### [snippet.0005.fs](snippet.0005.fs)
```
let sortedList1 = List.sort [1; 4; 8; -2; 5]
printfn "%A" sortedList1
```

### [snippet.0006.fs](snippet.0006.fs)
```
let sortedList2 = List.sortBy (fun elem -> abs elem) [1; 4; 8; -2; 5]
printfn "%A" sortedList2
```

### [snippet.0007.fs](snippet.0007.fs)
```
type Widget = { ID: int; Rev: int }

let compareWidgets widget1 widget2 =
   if widget1.ID < widget2.ID then -1 else
   if widget1.ID > widget2.ID then 1 else
   if widget1.Rev < widget2.Rev then -1 else
   if widget1.Rev > widget2.Rev then 1 else
   0

let listToCompare = [
    { ID = 92; Rev = 1 }
    { ID = 110; Rev = 1 }
    { ID = 100; Rev = 5 }
    { ID = 100; Rev = 2 }
    { ID = 92; Rev = 1 }
    ]

let sortedWidgetList = List.sortWith compareWidgets listToCompare
printfn "%A" sortedWidgetList
```

### [snippet.0008.fs](snippet.0008.fs)
```
let isDivisibleBy number elem = elem % number = 0
let result = List.find (isDivisibleBy 5) [ 1 .. 100 ]
printfn "%d " result
```

### [snippet.0009.fs](snippet.0009.fs)
```
let valuesList = [ ("a", 1); ("b", 2); ("c", 3) ]

let resultPick = List.pick (fun elem ->
                    match elem with
                    | (value, 2) -> Some value
                    | _ -> None) valuesList
printfn "%A" resultPick
```

### [snippet.0010.fs](snippet.0010.fs)
```
let list1d = [1; 3; 7; 9; 11; 13; 15; 19; 22; 29; 36]
let isEven x = x % 2 = 0
match List.tryFind isEven list1d with
| Some value -> printfn "The first even value is %d." value
| None -> printfn "There is no even value in the list."

match List.tryFindIndex isEven list1d with
| Some value -> printfn "The first even value is at position %d." value
| None -> printfn "There is no even value in the list."
```

### [snippet.0011.fs](snippet.0011.fs)
```
// Compute the sum of the first 10 integers by using List.sum.
let sum1 = List.sum [1 .. 10]

// Compute the sum of the squares of the elements of a list by using List.sumBy.
let sum2 = List.sumBy (fun elem -> elem*elem) [1 .. 10]

// Compute the average of the elements of a list by using List.average.
let avg1 = List.average [0.0; 1.0; 1.0; 2.0]

printfn "%f" avg1
```

### [snippet.0012.fs](snippet.0012.fs)
```
let avg2 = List.averageBy (fun elem -> float elem) [1 .. 10]
printfn "%f" avg2
```

### [snippet.0013.fs](snippet.0013.fs)
```
let list1 = [ 1; 2; 3 ]
let list2 = [ -1; -2; -3 ]
let listZip = List.zip list1 list2
printfn "%A" listZip
```

### [snippet.0014.fs](snippet.0014.fs)
```
let list3 = [ 0; 0; 0]
let listZip3 = List.zip3 list1 list2 list3
printfn "%A" listZip3
```

### [snippet.0015.fs](snippet.0015.fs)
```
let lists = List.unzip [(1,2); (3,4)]
printfn "%A" lists
printfn "%A %A" (fst lists) (snd lists)
```

### [snippet.0016.fs](snippet.0016.fs)
```
let listsUnzip3 = List.unzip3 [(1,2,3); (4,5,6)]
printfn "%A" listsUnzip3
```

### [snippet.0017.fs](snippet.0017.fs)
```
let list1 = [1; 2; 3]
let list2 = [4; 5; 6]
List.iter (fun x -> printfn "List.iter: element is %d" x) list1
List.iteri(fun i x -> printfn "List.iteri: element %d is %d" i x) list1
List.iter2 (fun x y -> printfn "List.iter2: elements are %d %d" x y) list1 list2
List.iteri2 (fun i x y ->
                printfn "List.iteri2: element %d of list1 is %d element %d of list2 is %d"
                  i x i y)
            list1 list2
```

### [snippet.0018.fs](snippet.0018.fs)
```
let list1 = [1; 2; 3]
let newList = List.map (fun x -> x + 1) list1
printfn "%A" newList
```

### [snippet.0019.fs](snippet.0019.fs)
```
let list1 = [1; 2; 3]
let list2 = [4; 5; 6]
let sumList = List.map2 (fun x y -> x + y) list1 list2
printfn "%A" sumList
```

### [snippet.0020.fs](snippet.0020.fs)
```
let newList2 = List.map3 (fun x y z -> x + y + z) list1 list2 [2; 3; 4]
printfn "%A" newList2
```

### [snippet.0021.fs](snippet.0021.fs)
```
let newListAddIndex = List.mapi (fun i x -> x + i) list1
printfn "%A" newListAddIndex
```

### [snippet.0022.fs](snippet.0022.fs)
```
let listAddTimesIndex = List.mapi2 (fun i x y -> (x + y) * i) list1 list2
printfn "%A" listAddTimesIndex
```

### [snippet.0023.fs](snippet.0023.fs)
```
let collectList = List.collect (fun x -> [for i in 1..3 -> x * i]) list1
printfn "%A" collectList
```

### [snippet.0024.fs](snippet.0024.fs)
```
let evenOnlyList = List.filter (fun x -> x % 2 = 0) [1; 2; 3; 4; 5; 6]
```

### [snippet.0025.fs](snippet.0025.fs)
```
let listWords = [ "and"; "Rome"; "Bob"; "apple"; "zebra" ]
let isCapitalized (string1:string) = System.Char.IsUpper string1[0]
let results = List.choose (fun elem ->
    match elem with
    | elem when isCapitalized elem -> Some(elem + "'s")
    | _ -> None) listWords
printfn "%A" results
```

### [snippet.0026.fs](snippet.0026.fs)
```
let list1to10 = List.append [1; 2; 3] [4; 5; 6; 7; 8; 9; 10]
let listResult = List.concat [ [1; 2; 3]; [4; 5; 6]; [7; 8; 9] ]
List.iter (fun elem -> printf "%d " elem) list1to10
printfn ""
List.iter (fun elem -> printf "%d " elem) listResult
```

### [snippet.0027.fs](snippet.0027.fs)
```
let sumList list = List.fold (fun acc elem -> acc + elem) 0 list
printfn "Sum of the elements of list %A is %d." [ 1 .. 3 ] (sumList [ 1 .. 3 ])

// The following example computes the average of a list.
let averageList list = (List.fold (fun acc elem -> acc + float elem) 0.0 list / float list.Length)

// The following example computes the standard deviation of a list.
// The standard deviation is computed by taking the square root of the
// sum of the variances, which are the differences between each value
// and the average.
let stdDevList list =
    let avg = averageList list
    sqrt (List.fold (fun acc elem -> acc + (float elem - avg) ** 2.0 ) 0.0 list / float list.Length)

let testList listTest =
    printfn "List %A average: %f stddev: %f" listTest (averageList listTest) (stdDevList listTest)

testList [1; 1; 1]
testList [1; 2; 1]
testList [1; 2; 3]

// List.fold is the same as to List.iter when the accumulator is not used.
let printList list = List.fold (fun acc elem -> printfn "%A" elem) () list
printList [0.0; 1.0; 2.5; 5.1 ]

// The following example uses List.fold to reverse a list.
// The accumulator starts out as the empty list, and the function uses the cons operator
// to add each successive element to the head of the accumulator list, resulting in a
// reversed form of the list.
let reverseList list = List.fold (fun acc elem -> elem::acc) [] list
printfn "%A" (reverseList [1 .. 10])
```

### [snippet.0028.fs](snippet.0028.fs)
```
// Use List.fold2 to perform computations over two lists (of equal size) at the same time.
// Example: Sum the greater element at each list position.
let sumGreatest list1 list2 = List.fold2 (fun acc elem1 elem2 ->
                                              acc + max elem1 elem2) 0 list1 list2

let sum = sumGreatest [1; 2; 3] [3; 2; 1]
printfn "The sum of the greater of each pair of elements in the two lists is %d." sum
```

### [snippet.0029.fs](snippet.0029.fs)
```
// Discriminated union type that encodes the transaction type.
type Transaction =
    | Deposit
    | Withdrawal

let transactionTypes = [Deposit; Deposit; Withdrawal]
let transactionAmounts = [100.00; 1000.00; 95.00 ]
let initialBalance = 200.00

// Use fold2 to perform a calculation on the list to update the account balance.
let endingBalance = List.fold2 (fun acc elem1 elem2 ->
                                match elem1 with
                                | Deposit -> acc + elem2
                                | Withdrawal -> acc - elem2)
                                initialBalance
                                transactionTypes
                                transactionAmounts
printfn "%f" endingBalance
```

### [snippet.0030.fs](snippet.0030.fs)
```
let sumListBack list = List.foldBack (fun elem acc -> acc + elem) list 0
printfn "%d" (sumListBack [1; 2; 3])

// For a calculation in which the order of traversal is important, fold and foldBack have different
// results. For example, replacing fold with foldBack in the listReverse function
// produces a function that copies the list, rather than reversing it.
let copyList list = List.foldBack (fun elem acc -> elem::acc) list []
printfn "%A" (copyList [1 .. 10])
```

### [snippet.0031.fs](snippet.0031.fs)
```
type Transaction2 =
    | Deposit
    | Withdrawal
    | Interest

let transactionTypes2 = [Deposit; Deposit; Withdrawal; Interest]
let transactionAmounts2 = [100.00; 1000.00; 95.00; 0.05 / 12.0 ]
let initialBalance2 = 200.00

// Because fold2 processes the lists by starting at the head element,
// the interest is calculated last, on the balance of 1205.00.
let endingBalance2 = List.fold2 (fun acc elem1 elem2 ->
                                match elem1 with
                                | Deposit -> acc + elem2
                                | Withdrawal -> acc - elem2
                                | Interest -> acc * (1.0 + elem2))
                                initialBalance2
                                transactionTypes2
                                transactionAmounts2
printfn "%f" endingBalance2
```

### [snippet.0032.fs](snippet.0032.fs)
```
// Because foldBack2 processes the lists by starting at end of the list,
// the interest is calculated first, on the balance of only 200.00.
let endingBalance3 = List.foldBack2 (fun elem1 elem2 acc ->
                                match elem1 with
                                | Deposit -> acc + elem2
                                | Withdrawal -> acc - elem2
                                | Interest -> acc * (1.0 + elem2))
                                transactionTypes2
                                transactionAmounts2
                                initialBalance2
printfn "%f" endingBalance3
```

### [snippet.0033.fs](snippet.0033.fs)
```
let sumAList list =
    try
        List.reduce (fun acc elem -> acc + elem) list
    with
       | :? System.ArgumentException as exc -> 0

let resultSum = sumAList [2; 4; 10]
printfn "%d " resultSum
```

### [snippet.0034.fs](snippet.0034.fs)
```
type Transaction2 =
    | Deposit
    | Withdrawal
    | Interest

let transactionTypes2 = [Deposit; Deposit; Withdrawal; Interest]
let transactionAmounts2 = [100.00; 1000.00; 95.00; 0.05 / 12.0 ]
let initialBalance2 = 200.00

// Because fold2 processes the lists by starting at the head element,
// the interest is calculated last, on the balance of 1205.00.
let endingBalance2 = List.fold2 (fun acc elem1 elem2 ->
                                match elem1 with
                                | Deposit -> acc + elem2
                                | Withdrawal -> acc - elem2
                                | Interest -> acc * (1.0 + elem2))
                                initialBalance2
                                transactionTypes2
                                transactionAmounts2
printfn "%f" endingBalance2


// Because foldBack2 processes the lists by starting at end of the list,
// the interest is calculated first, on the balance of only 200.00.
let endingBalance3 = List.foldBack2 (fun elem1 elem2 acc ->
                                match elem1 with
                                | Deposit -> acc + elem2
                                | Withdrawal -> acc - elem2
                                | Interest -> acc * (1.0 + elem2))
                                transactionTypes2
                                transactionAmounts2
                                initialBalance2
printfn "%f" endingBalance3
```

### [snippet.0035.fs](snippet.0035.fs)
```
let list1 = [1; 2; 3]
let list2 = [4; 5; 6]
let newList = List.map3 (fun x y z -> x + y + z) list1 list2 [2; 3; 4]
printfn "%A" newList
```

### [snippet.0036.fs](snippet.0036.fs)
```
let list1 = [1; 2; 3]
let newList = List.mapi (fun i x -> (i, x)) list1
printfn "%A" newList
```

### [snippet.0037.fs](snippet.0037.fs)
```
let list1 = [1; 2; 3]
let list2 = [4; 5; 6]
let listAddTimesIndex = List.mapi2 (fun i x y -> (x + y) * i) list1 list2
printfn "%A" listAddTimesIndex
```

### [snippet.0038.fs](snippet.0038.fs)
```
let listA, listB = List.unzip [(1,2); (3,4)]
printfn "%A" listA
printfn "%A" listB
```

### [snippet.0039.fs](snippet.0039.fs)
```
let listA, listB, listC = List.unzip3 [(1,2,3); (4,5,6)]
printfn "%A %A %A" listA listB listC
```

### [snippet.0040.fs](snippet.0040.fs)
```
let list1 = [ 1; 2; 3 ]
let list2 = [ -1; -2; -3 ]
let list3 = [ 0; 0; 0]
let listZip3 = List.zip3 list1 list2 list3
printfn "%A" listZip3
```

### [snippet.0041.fs](snippet.0041.fs)
```
let sumListBack list = List.foldBack (fun acc elem -> acc + elem) list 0
printfn "%d" (sumListBack [1; 2; 3])

// For a calculation in which the order of traversal is important, fold and foldBack have different
// results. For example, replacing foldBack with fold in the copyList function
// produces a function that reverses the list, rather than copying it.
let copyList list = List.foldBack (fun elem acc -> elem::acc) list []
printfn "%A" (copyList [1 .. 10])
```

### [snippet.0042.fs](snippet.0042.fs)
```
let list1 = [10; 20; 30]
let collectList = List.collect (fun x -> [for i in 1..3 -> x * i]) list1
printfn "%A" collectList
```

### [snippet.0043.fs](snippet.0043.fs)
```
List.init 10 (fun i -> (i, i * i))
|> List.filter (fun (n, nsqr) -> n % 2 = 0)
|> List.rev
|> List.iter (fun (n, nsqr) -> printfn "(%d, %d) " n nsqr)
```

### [snippet.0044.fs](snippet.0044.fs)
```
// A generic empty list.
let emptyList1 = List.empty
// An empty list of a specific type.
let emptyList2 = List.empty<int>
```

### [snippet.0045.fs](snippet.0045.fs)
```
let list1 = [ 2 .. 100 ]
let delta = 1.0e-10
let isPerfectSquare (x:int) =
    let y = sqrt (float x)
    abs(y - round y) < delta
let isPerfectCube (x:int) =
    let y = System.Math.Pow(float x, 1.0/3.0)
    abs(y - round y) < delta
let element = List.find (fun elem -> isPerfectSquare elem && isPerfectCube elem) list1
let index = List.findIndex (fun elem -> isPerfectSquare elem && isPerfectCube elem) list1
printfn "The first element that is both a square and a cube is %d and its index is %d." element index
```

### [snippet.0046.fs](snippet.0046.fs)
```
printfn "List of squares: %A" (List.init 10 (fun index -> index * index))
```

### [snippet.0047.fs](snippet.0047.fs)
```
let printList list1 =
    if (List.isEmpty list1) then
        printfn "There are no elements in this list."
    else
        printfn "This list contains the following elements:"
        List.iter (fun elem -> printf "%A " elem) list1
        printfn ""
printList [ "test1"; "test2" ]
printList [ ]
```

### [snippet.0048.fs](snippet.0048.fs)
```
List.length [ 1 .. 100 ] |> printfn "Length: %d"
List.length [ ] |> printfn "Length: %d"
List.length [ 1 .. 2 .. 100 ] |> printfn "Length: %d"
```

### [snippet.0049.fs](snippet.0049.fs)
```
let list1 = [ -10 .. 10 ]
List.nth list1 5
|> printfn "The fifth element: %d"
```

### [snippet.0050.fs](snippet.0050.fs)
```
let list1 = [ 1 .. 10 ]
let listEven, listOdd = List.partition (fun elem -> elem % 2 = 0) list1
printfn "Evens: %A\nOdds: %A" listEven listOdd
```

### [snippet.0051.fs](snippet.0051.fs)
```
let printPermutation n list1 =
    let length = List.length list1
    if (n > 0 && n < length) then
        List.permute (fun index -> (index + n) % length) list1
    else
        list1
    |> printfn "%A"
let list1 = [ 1 .. 5 ]
// There are 5 valid permutations of list1, with n from 0 to 4.
for n in 0 .. 4 do
    printPermutation n list1
```

### [snippet.0052.fs](snippet.0052.fs)
```
let testList = List.replicate 4 "test"
printfn "%A" testList
```

### [snippet.0053.fs](snippet.0053.fs)
```
let reverseList = List.rev [ 1 .. 10 ]
printfn "%A" reverseList
```

### [snippet.0054.fs](snippet.0054.fs)
```
let initialBalance = 1122.73
let transactions = [ -100.00; +450.34; -62.34; -127.00; -13.50; -12.92 ]

let balances =
    (initialBalance, transactions)
    ||> List.scan (fun balance transactionAmount -> balance + transactionAmount)
              

printfn "Initial balance:\n $%10.2f" initialBalance
printfn "Transaction   Balance"

for i in 0 .. transactions.Length - 1 do
    printfn "$%10.2f $%10.2f" transactions[i] balances[i]

printfn "Final balance:\n $%10.2f" balances[ balances.Length - 1]
```

### [snippet.0055.fs](snippet.0055.fs)
```
[ for x in -100 .. 100 -> 4 - x * x ]
|> List.max
|> printfn "%A"
```

### [snippet.0056.fs](snippet.0056.fs)
```
[ -10.0 .. 10.0 ]
|> List.maxBy (fun x -> 1.0 - x * x)
|> printfn "%A"
```

### [snippet.0057.fs](snippet.0057.fs)
```
[ for x in -100 .. 100 -> x * x - 4 ]
|> List.min
|> printfn "%A"
```

### [snippet.0058.fs](snippet.0058.fs)
```
[ -10.0 .. 10.0 ]
|> List.minBy (fun x -> x * x - 1.0)
|> printfn "%A"
```

### [snippet.0059.fs](snippet.0059.fs)
```
let list1 = List.ofArray [| 1 .. 10 |]
```

### [snippet.0060.fs](snippet.0060.fs)
```
let list1 = List.ofSeq ( seq { 1 .. 10 } )
```

### [snippet.0061.fs](snippet.0061.fs)
```
// A list of functions that transform
// integers. (int -> int)
let ops1 =
  [ (fun x -> x + 1), "add 1"
    (fun x -> x + 2), "add 2"
    (fun x -> x - 5), "subtract 5" ]

let ops2 =
  [ (fun x -> x + 1), "add 1"
    (fun x -> x * 5), "multiply by 5"
    (fun x -> x * x), "square" ]

// Compare scan and scanBack, which apply the
// operations in the opposite order.
let compareOpOrder ops x0 =
    let ops, opNames = List.unzip ops
    let xs1 = List.scan (fun x op -> op x) x0 ops
    let xs2 = List.scanBack (fun op x -> op x) ops x0

    printfn "Operations:"
    opNames |> List.iter (fun opName -> printf "%s  " opName)
    printfn ""

    // Print the intermediate results.
    let xs = List.zip xs1 (List.rev xs2)
    printfn "List.scan List.scanBack"
    for (x1, x2) in xs do
        printfn "%10d %10d" x1 x2
    printfn ""

compareOpOrder ops1 10
compareOpOrder ops2 10
```

### [snippet.0062.fs](snippet.0062.fs)
```
open System

let list1 = [ "<>"; "&"; "&&"; "&&&"; "<"; ">"; "|"; "||"; "|||" ]
printfn "Before sorting: "
list1 |> printfn "%A"
let sortFunction (string1:string) (string2:string) =
    if (string1.Length > string2.Length) then
        1
    else if (string1.Length < string2.Length) then
        -1
    else
        String.Compare(string1, string2)
List.sortWith sortFunction list1
|> printfn "After sorting:\n%A"
```

### [snippet.0063.fs](snippet.0063.fs)
```
let list1 = [1; 2; 3]
let list2 = []
// The following line prints [2; 3].
printfn "%A" (List.tail list1)
// The following line throws System.ArgumentException.
printfn "%A" (List.tail list2)
```

### [snippet.0064.fs](snippet.0064.fs)
```
let array1 = [ 1; 3; -2; 4 ]
              |> List.toArray
Array.set array1 3 -10
Array.sortInPlaceWith (fun elem1 elem2 -> compare elem1 elem2) array1
printfn "%A" array1
```

### [snippet.0065.fs](snippet.0065.fs)
```
let findPerfectSquareAndCube list1 =
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
    match List.tryPick testElement list1 with
    | Some (n, sqrt, cuberoot) ->
        printfn "Found an element %d with square root %d and cube root %d." n sqrt cuberoot
    | None ->
        printfn "Did not find an element that is both a perfect square and a perfect cube."

findPerfectSquareAndCube [ 1 .. 10 ]
findPerfectSquareAndCube [ 2 .. 100 ]
findPerfectSquareAndCube [ 100 .. 1000 ]
findPerfectSquareAndCube [ 1000 .. 10000 ]
findPerfectSquareAndCube [ 2 .. 50 ]
```

### [snippet.0066.fs](snippet.0066.fs)
```
[ 1 .. 10 ]
|> List.sum
|> printfn "Sum: %d"
```

### [snippet.0067.fs](snippet.0067.fs)
```
[ 1 .. 10 ]
|> List.sumBy (fun x -> x * x)
|> printfn "Sum: %d"
```

### [snippet.0068.fs](snippet.0068.fs)
```
[ 1 .. 10 ]
|> List.toSeq
|> Seq.truncate 5
|> Seq.iter (fun elem -> printf "%d " elem)
printfn ""
```

### [snippet.0069.fs](snippet.0069.fs)
```
let list1 = [ 1 .. 10 ]

// The following chunks the list into sub-lists of size 2
printfn "%A" (List.chunkBySize 2 list1)

// The following chunks the list into sub-lists of size 3, with the last list being a single element
printfn "%A" (List.chunkBySize 3 list1)
```

### [snippet.0070.fs](snippet.0070.fs)
```
let binary n =
    let rec generateBinary n =
        if (n / 2 = 0) then [n]
        else (n % 2) :: generateBinary (n / 2)
    generateBinary n |> List.rev

printfn "%A" (binary 1024)

let resultList = List.distinct (binary 1024)
printfn "%A" resultList
```

### [snippet.0071.fs](snippet.0071.fs)
```
let inputList = [ -5 .. 10 ]
let printList list1 = List.iter (printf "%A ") list1; printfn ""
printfn "Original list: "
printList inputList
printfn "\nListwith distinct absolute values: "
let listDistinctAbsoluteValue = List.distinctBy (fun elem -> abs elem) inputList
listDistinctAbsoluteValue |> printList
```

### [snippet.0072.fs](snippet.0072.fs)
```
let myList = [ for i in 1 .. 10 -> i*i ]
let truncatedList = List.truncate 5 myList
let takenList = List.take 5 myList

let truncatedList2 = List.truncate 20 myList

let printList list1 = List.iter (printf "%A ") list1; printfn ""

truncatedList |> printList
takenList |> printList
truncatedList2 |> printList

// The following line produces a run-time error
List.take 20 myList |> printList
```

### [snippet.0111.fs](snippet.0111.fs)
```
// Compute the average of the elements of a list by using List.average.
let avg1 = List.average [0.0; 1.0; 1.0; 2.0]

printfn "%f" avg1
```

### [snippet.0112.fs](snippet.0112.fs)
```
let first, second = List.splitAt 2 [0..9]
printfn "First: %A\nSecond: %A" first second
```

### [snippet.0113.fs](snippet.0113.fs)
```
let list1 = [ 1 .. 10 ]
let list2 = List.empty

//The following line prints true
printfn "%A" (List.contains 5 list1)

//The following line prints false
printfn "%A" (List.contains 5 list2)
```

### [snippet.0114.fs](snippet.0114.fs)
```
let list1 = [ 1 .. 3 ]
let list2 = [ 1; 2; 4; ]

// Compare two lists element by element.
let compareLists = List.compareWith (fun elem1 elem2 ->
    if elem1 > elem2 then 1
    elif elem1 < elem2 then -1
    else 0)

// Prints List1 is less than List2
match compareLists list1 list2 with
| 1 -> printfn "List1 is greater than List2."
| -1 -> printfn "List1 is less than List2."
| 0 -> printfn "List1 is equal to List2."
| _ -> failwith("Invalid comparison result.")

let list3 = [ 1; 44; 3; ]
let list4 = [ 1; 2; ]

// Prints 42
printfn "%A" (List.compareWith (fun elem1 elem2 -> elem1 - elem2) list3 list4)
```

### [snippet.0115.fs](snippet.0115.fs)
```
let list1 = [ 1 .. 100 ]
let printList alist =
    alist
    |> List.iter (printf "%A ")
    printfn ""
let listResult = List.countBy (fun elem ->
    if (elem % 2 = 0) then 0 else 1) list1

printList listResult
```

