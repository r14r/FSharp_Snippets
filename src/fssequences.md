### [snippet.0001.fs](snippet.0001.fs)
```
// Sequence that has an increment.
seq { 0 .. 10 .. 100 }
```

### [snippet.0002.fs](snippet.0002.fs)
```
seq { for i in 1 .. 10 -> i * i }
```

### [snippet.0003.fs](snippet.0003.fs)
```
seq { for i in 1 .. 10 -> i * i }
```

### [snippet.0004.fs](snippet.0004.fs)
```
let (height, width) = (10, 10)
let coordinates = seq {
     for row in 0 .. width - 1 do
        for col in 0 .. height - 1 ->
            (row, col, row*width + col) }
```

### [snippet.0005.fs](snippet.0005.fs)
```
seq { for n in 1 .. 100 do if isprime n then n }
```

### [snippet.0006.fs](snippet.0006.fs)
```
// Recursive isprime function.
let isprime n =
    let rec check i =
        i > n/2 || (n % i <> 0 && check (i + 1))
    check 2

let aSequence = seq { for n in 1..100 do if isprime n then n }
for x in aSequence do
    printfn "%d" x
```

### [snippet.0007.fs](snippet.0007.fs)
```
let multiplicationTable =
    seq {
        for i in 1..9 do
            for j in 1..9 ->
                (i, j, i*j) }
```

### [snippet.0008.fs](snippet.0008.fs)
```
// Yield the values of a binary tree in a sequence.
type Tree<'a> =
   | Tree of 'a * Tree<'a> * Tree<'a>
   | Leaf of 'a

// inorder : Tree<'a> -> seq<'a>
let rec inorder tree =
    seq {
      match tree with
          | Tree(x, left, right) ->
               yield! inorder left
               yield x
               yield! inorder right
          | Leaf x -> yield x
    }

let mytree = Tree(6, Tree(2, Leaf(1), Leaf(3)), Leaf(9))
let seq1 = inorder mytree
printfn "%A" seq1
```

### [snippet.0009.fs](snippet.0009.fs)
```
let seqEmpty = Seq.empty
let seqOne = Seq.singleton 10
```

### [snippet.0010.fs](snippet.0010.fs)
```
let seqFirst5MultiplesOf10 = Seq.init 5 (fun n -> n * 10)
Seq.iter (fun elem -> printf "%d " elem) seqFirst5MultiplesOf10
```

### [snippet.0011.fs](snippet.0011.fs)
```
// Convert an array to a sequence by using a cast.
let seqFromArray1 = [| 1 .. 10 |] :> seq<int>

// Convert an array to a sequence by using Seq.ofArray.
let seqFromArray2 = [| 1 .. 10 |] |> Seq.ofArray
```

### [snippet.0012.fs](snippet.0012.fs)
```
open System

let arr = ResizeArray<int>(10)

for i in 1 .. 10 do
    arr.Add(10)

let seqCast = Seq.cast arr
```

### [snippet.0013.fs](snippet.0013.fs)
```
let seqInfinite =
    Seq.initInfinite (fun index ->
        let n = float (index + 1)
        1.0 / (n * n * (if ((index + 1) % 2 = 0) then 1.0 else -1.0)))

printfn "%A" seqInfinite
```

### [snippet.0014.fs](snippet.0014.fs)
```
let seq1 =
    0 // Initial state
    |> Seq.unfold (fun state ->
        if (state > 20) then
            None
        else
            Some(state, state + 1))

printfn "The sequence seq1 contains numbers from 0 to 20."

for x in seq1 do
    printf "%d " x

let fib =
    (1, 1) // Initial state
    |> Seq.unfold (fun state ->
        if (snd state > 1000) then
            None
        else
            Some(fst state + snd state, (snd state, fst state + snd state)))

printfn "\nThe sequence fib contains Fibonacci numbers."
for x in fib do printf "%d " x
```

### [snippet.0015.fs](snippet.0015.fs)
```
// generateInfiniteSequence generates sequences of floating point
// numbers. The sequences generated are computed from the fDenominator
// function, which has the type (int -> float) and computes the
// denominator of each term in the sequence from the index of that
// term. The isAlternating parameter is true if the sequence has
// alternating signs.
let generateInfiniteSequence fDenominator isAlternating =
    if (isAlternating) then
        Seq.initInfinite (fun index ->
            1.0 /(fDenominator index) * (if (index % 2 = 0) then -1.0 else 1.0))
    else
        Seq.initInfinite (fun index -> 1.0 /(fDenominator index))

// The harmonic alternating series is like the harmonic series
// except that it has alternating signs.
let harmonicAlternatingSeries = generateInfiniteSequence (fun index -> float index) true

// This is the series of reciprocals of the odd numbers.
let oddNumberSeries = generateInfiniteSequence (fun index -> float (2 * index - 1)) true

// This is the series of recipocals of the squares.
let squaresSeries = generateInfiniteSequence (fun index -> float (index * index)) false

// This function sums a sequence, up to the specified number of terms.
let sumSeq length sequence =
    (0, 0.0)
    |>
    Seq.unfold (fun state ->
        let subtotal = snd state + Seq.item (fst state + 1) sequence
        if (fst state >= length) then
            None
        else
            Some(subtotal, (fst state + 1, subtotal)))

// This function sums an infinite sequence up to a given value
// for the difference (epsilon) between subsequent terms,
// up to a maximum number of terms, whichever is reached first.
let infiniteSum infiniteSeq epsilon maxIteration =
    infiniteSeq
    |> sumSeq maxIteration
    |> Seq.pairwise
    |> Seq.takeWhile (fun elem -> abs (snd elem - fst elem) > epsilon)
    |> List.ofSeq
    |> List.rev
    |> List.head
    |> snd

// Compute the sums for three sequences that converge, and compare
// the sums to the expected theoretical values.
let result1 = infiniteSum harmonicAlternatingSeries 0.00001 100000
printfn "Result: %f  ln2: %f" result1 (log 2.0)

let pi = Math.PI
let result2 = infiniteSum oddNumberSeries 0.00001 10000
printfn "Result: %f pi/4: %f" result2 (pi/4.0)

// Because this is not an alternating series, a much smaller epsilon
// value and more terms are needed to obtain an accurate result.
let result3 = infiniteSum squaresSeries 0.0000001 1000000
printfn "Result: %f pi*pi/6: %f" result3 (pi*pi/6.0)
```

### [snippet.0016.fs](snippet.0016.fs)
```
let mySeq = seq { for i in 1 .. 10 -> i*i }
let truncatedSeq = Seq.truncate 5 mySeq
let takenSeq = Seq.take 5 mySeq

let truncatedSeq2 = Seq.truncate 20 mySeq
let takenSeq2 = Seq.take 20 mySeq

let printSeq seq1 = Seq.iter (printf "%A ") seq1; printfn ""

// Up to this point, the sequences are not evaluated.
// The following code causes the sequences to be evaluated.
truncatedSeq |> printSeq
truncatedSeq2 |> printSeq
takenSeq |> printSeq
// The following line produces a run-time error (in printSeq):
takenSeq2 |> printSeq
```

### [snippet.0017.fs](snippet.0017.fs)
```
// takeWhile
let mySeqLessThan10 = Seq.takeWhile (fun elem -> elem < 10) mySeq
mySeqLessThan10 |> printSeq

// skip
let mySeqSkipFirst5 = Seq.skip 5 mySeq
mySeqSkipFirst5 |> printSeq

// skipWhile
let mySeqSkipWhileLessThan10 = Seq.skipWhile (fun elem -> elem < 10) mySeq
mySeqSkipWhileLessThan10 |> printSeq
```

### [snippet.0018.fs](snippet.0018.fs)
```
let printSeq seq1 = Seq.iter (printf "%A ") seq1; printfn ""
let seqPairwise = Seq.pairwise (seq { for i in 1 .. 10 -> i*i })
printSeq seqPairwise

printfn ""
let seqDelta = Seq.map (fun elem -> snd elem - fst elem) seqPairwise
printSeq seqDelta
```

### [snippet.0019.fs](snippet.0019.fs)
```
let sequence1 = seq { 1 .. 10 }
let sequence2 = seq { 10 .. -1 .. 1 }

// Compare two sequences element by element.
let compareSequences =
    Seq.compareWith (fun elem1 elem2 ->
        if elem1 > elem2 then 1
        elif elem1 < elem2 then -1
        else 0)

let compareResult1 = compareSequences sequence1 sequence2
match compareResult1 with
| 1 -> printfn "Sequence1 is greater than sequence2."
| -1 -> printfn "Sequence1 is less than sequence2."
| 0 -> printfn "Sequence1 is equal to sequence2."
| _ -> failwith("Invalid comparison result.")
```

### [snippet.0020.fs](snippet.0020.fs)
```
let mySeq1 = seq { 1.. 100 }
let printSeq seq1 =
    seq1
    |> Seq.iter (printf "%A ")
    printfn ""
let seqResult = Seq.countBy (fun elem ->
    if (elem % 2 = 0) then 0 else 1) mySeq1

printSeq seqResult
```

### [snippet.0021.fs](snippet.0021.fs)
```
let sequence = seq { 1 .. 100 }
let printSeq seq1 = Seq.iter (printf "%A ") seq1; printfn ""
let sequences3 = Seq.groupBy (fun index ->
    if (index % 2 = 0) then 0 else 1) sequence
sequences3 |> printSeq
```

### [snippet.0022.fs](snippet.0022.fs)
```
let binary n =
    let rec generateBinary n =
        if (n / 2 = 0) then [n]
        else (n % 2) :: generateBinary (n / 2)

    generateBinary n
    |> List.rev
    |> Seq.ofList

printfn "%A" (binary 1024)

let resultSequence = Seq.distinct (binary 1024)
printfn "%A" resultSequence
```

### [snippet.0023.fs](snippet.0023.fs)
```
let inputSequence = { -5 .. 10 }
let printSeq seq1 = Seq.iter (printf "%A ") seq1

printfn "Original sequence: "
printSeq inputSequence

printfn "\nSequence with distinct absolute values: "
let seqDistinctAbsoluteValue = Seq.distinctBy (fun elem -> abs elem) inputSequence
printSeq seqDistinctAbsoluteValue
```

### [snippet.0024.fs](snippet.0024.fs)
```
type ArrayContainer(start, finish) =
    let internalArray = [| start .. finish |]
    member this.RangeSeq = Seq.readonly internalArray
    member this.RangeArray = internalArray

let newArray = new ArrayContainer(1, 10)
let rangeSeq = newArray.RangeSeq
let rangeArray = newArray.RangeArray

// These lines produce an error:
//let myArray = rangeSeq :> int array
//myArray[0] <- 0

// The following line does not produce an error.
// It does not preserve encapsulation.
rangeArray[0] <- 0
```

### [snippet.0025.fs](snippet.0025.fs)
```
printfn "%A" (Seq.append [| 1; 2; 3|] [ 4; 5; 6])
```

### [snippet.0026.fs](snippet.0026.fs)
```
// You can use Seq.average to average elements of a list, array, or sequence.
let average1 = Seq.average [ 1.0 .. 10.0 ]
printfn "Average: %f" average1
// To average a sequence of integers, use Seq.averageBy to convert to float.
let average2 = Seq.averageBy (fun elem -> float elem) (seq { 1 .. 10 })
printfn "Average: %f" average2
```

### [snippet.0027.fs](snippet.0027.fs)
```
// Recursive isprime function.
let isPrime n =
    let rec check i =
        i > n/2 || (n % i <> 0 && check (i + 1))
    check 2

let seqPrimes = seq { for n in 2 .. 10000 do if isPrime n then n }
// Cache the sequence to avoid recomputing the sequence elements.
let cachedSeq = Seq.cache seqPrimes
for index in 1..5 do
    printfn "%d is prime." (Seq.nth (Seq.length cachedSeq - index) cachedSeq)
```

### [snippet.0028.fs](snippet.0028.fs)
```
let addNegations seq1 =
   Seq.collect (fun x -> seq { x; -x }) seq1
   |> Seq.sort
addNegations [ 1 .. 4 ] |> Seq.iter (fun elem -> printf "%d " elem)
printfn ""
addNegations [| 0; -4; 2; -12 |] |> Seq.iter (fun elem -> printf "%d " elem)
```

### [snippet.0029.fs](snippet.0029.fs)
```
// Using Seq.append to append an array to a list.
let seq1to10 = Seq.append [1; 2; 3] [| 4; 5; 6; 7; 8; 9; 10 |]
// Using Seq.concat to concatenate a list of arrays.
let seqResult = Seq.concat [ [| 1; 2; 3 |]; [| 4; 5; 6 |]; [|7; 8; 9|] ]
Seq.iter (fun elem -> printf "%d " elem) seq1to10
printfn ""
Seq.iter (fun elem -> printf "%d " elem) seqResult
```

### [snippet.0030.fs](snippet.0030.fs)
```
// Normally sequences are evaluated lazily.  In this case,
// the sequence is created from a list, which is not evaluated
// lazily. Therefore, without Seq.delay, the elements would be
// evaluated at the time of the call to makeSequence.
let makeSequence function1 maxNumber = Seq.delay (fun () ->
    let rec loop n acc =
        printfn "Evaluating %d." n
        match n with
        | 0 -> acc
        | n -> (function1 n) :: loop (n - 1) acc
    loop maxNumber []
    |> Seq.ofList)
printfn "Calling makeSequence."
let seqSquares = makeSequence (fun x -> x * x) 4
let seqCubes = makeSequence (fun x -> x * x * x) 4
printfn "Printing sequences."
printfn "Squares:"
seqSquares |> Seq.iter (fun x -> printf "%d " x)
printfn "\nCubes:"
seqCubes |> Seq.iter (fun x -> printf "%d " x)
```

### [snippet.0031.fs](snippet.0031.fs)
```
// Compare the output of this example with that of the previous.
// Notice that Seq.delay delays the
// execution of the loop until the sequence is used.
let makeSequence function1 maxNumber =
    let rec loop n acc =
        printfn "Evaluating %d." n
        match n with
        | 0 -> acc
        | n -> (function1 n) :: loop (n - 1) acc
    loop maxNumber []
    |> Seq.ofList
printfn "Calling makeSequence."
let seqSquares = makeSequence (fun x -> x * x) 4
let seqCubes = makeSequence (fun x -> x * x * x) 4
printfn "Printing sequences."
printfn "Squares:"
seqSquares |> Seq.iter (fun x -> printf "%d " x)
printfn "\nCubes:"
seqCubes |> Seq.iter (fun x -> printf "%d " x)
```

### [snippet.0032.fs](snippet.0032.fs)
```
// A generic empty sequence.
let emptySeq1 = Seq.empty
// A typed generic sequence.
let emptySeq2 = Seq.empty<string>
```

### [snippet.0033.fs](snippet.0033.fs)
```
// Use Seq.exists to determine whether there is an element of a sequence
// that satisfies a given Boolean expression.
// containsNumber returns true if any of the elements of the supplied sequence match
// the supplied number.
let containsNumber number seq1 = Seq.exists (fun elem -> elem = number) seq1
let seq0to3 = seq {0 .. 3}
printfn "For sequence %A, contains zero is %b" seq0to3 (containsNumber 0 seq0to3)
```

### [snippet.0034.fs](snippet.0034.fs)
```
// Use Seq.exists2 to compare elements in two sequences.
// isEqualElement returns true if any elements at the same position in two supplied
// sequences match.
let isEqualElement seq1 seq2 = Seq.exists2 (fun elem1 elem2 -> elem1 = elem2) seq1 seq2
let seq1to5 = seq { 1 .. 5 }
let seq5to1 = seq { 5 .. -1 .. 1 }
if (isEqualElement seq1to5 seq5to1) then
    printfn "Sequences %A and %A have at least one equal element at the same position." seq1to5 seq5to1
else
    printfn "Sequences %A and %A do not have any equal elements that are at the same position." seq1to5 seq5to1
```

### [snippet.0035.fs](snippet.0035.fs)
```
let random = new System.Random()
Seq.initInfinite (fun _ -> random.Next())
|> Seq.filter (fun x -> x % 2 = 0)
|> Seq.take 5
|> Seq.iter (fun elem -> printf "%d " elem)
printfn ""
```

### [snippet.0036.fs](snippet.0036.fs)
```
let isDivisibleBy number elem = elem % number = 0
let result = Seq.find (isDivisibleBy 5) [ 1 .. 100 ]
printfn "%d " result
```

### [snippet.0037.fs](snippet.0037.fs)
```
let seqA = [| 2 .. 100 |]
let delta = 1.0e-10
let isPerfectSquare (x:int) =
    let y = sqrt (float x)
    abs(y - round y) < delta
let isPerfectCube (x:int) =
    let y = System.Math.Pow(float x, 1.0/3.0)
    abs(y - round y) < delta
let element = Seq.find (fun elem -> isPerfectSquare elem && isPerfectCube elem) seqA
let index = Seq.findIndex (fun elem -> isPerfectSquare elem && isPerfectCube elem) seqA
printfn "The first element that is both a square and a cube is %d and its index is %d." element index
```

### [snippet.0038.fs](snippet.0038.fs)
```
let sumSeq sequence1 = Seq.fold (fun acc elem -> acc + elem) 0 sequence1
Seq.init 10 (fun index -> index * index)
|> sumSeq
|> printfn "The sum of the elements is %d."
```

### [snippet.0039.fs](snippet.0039.fs)
```
// This function can be used on any sequence, so the same function
// works with both lists and arrays.
let allPositive coll = Seq.forall (fun elem -> elem > 0) coll
printfn "%A" (allPositive [| 0; 1; 2; 3 |])
printfn "%A" (allPositive [ 1; 2; 3 ])
```

### [snippet.0040.fs](snippet.0040.fs)
```
// This function can be used on any sequence, so the same function
// works with both lists and arrays.
let allEqual coll = Seq.forall2 (fun elem1 elem2 -> elem1 = elem2) coll
printfn "%A" (allEqual [| 1; 2 |] [| 1; 2 |])
printfn "%A" (allEqual [ 1; 2 ] [ 2; 1 ])
```

### [snippet.0041.fs](snippet.0041.fs)
```
let headItem = Seq.head [| 1 .. 10 |]
printfn "%d" headItem
```

### [snippet.0042.fs](snippet.0042.fs)
```
let emptySeq = Seq.empty
let nonEmptySeq = seq { 1 .. 10 }
Seq.isEmpty emptySeq |> printfn "%b"
Seq.isEmpty nonEmptySeq |> printfn "%b"
```

### [snippet.0043.fs](snippet.0043.fs)
```
let seq1 = [1; 2; 3]
let seq2 = [4; 5; 6]
Seq.iter (fun x -> printfn "Seq.iter: element is %d" x) seq1
Seq.iteri(fun i x -> printfn "Seq.iteri: element %d is %d" i x) seq1
Seq.iter2 (fun x y -> printfn "Seq.iter2: elements are %d %d" x y) seq1 seq2
```

### [snippet.0044.fs](snippet.0044.fs)
```
let table1 = seq { for i in 1 ..10 do
                      for j in 1 .. 10 ->
                          (i, j, i*j)
                 }
Seq.length table1 |> printfn "Length: %d"
```

### [snippet.0045.fs](snippet.0045.fs)
```
let data = [(1,1,2001); (2,2,2004); (6,17,2009)]
let seq1 =
    data |> Seq.map (fun (a,b,c) ->
        let date = new System.DateTime(c, a, b)
        date.ToString("F"))

for i in seq1 do printfn "%A" i
```

### [snippet.0046.fs](snippet.0046.fs)
```
let seq1 = [1; 2; 3]
let seq2 = [4; 5; 6]
let sumSeq = Seq.map2 (fun x y -> x + y) seq1 seq2
printfn "%A" sumSeq
```

### [snippet.0047.fs](snippet.0047.fs)
```
let seq1 = [1; 2; 3]
let newSeq = Seq.mapi (fun i x -> (i, x)) seq1
printfn "%A" newSeq
```

### [snippet.0048.fs](snippet.0048.fs)
```
[| for x in -100 .. 100 -> 4 - x * x |]
|> Seq.max
|> printfn "%A"
```

### [snippet.0056.fs](snippet.0056.fs)
```
[| -10.0 .. 10.0 |]
|> Seq.maxBy (fun x -> 1.0 - x * x)
|> printfn "%A"
```

### [snippet.0057.fs](snippet.0057.fs)
```
[| for x in -100 .. 100 -> x * x - 4 |]
|> Seq.min
|> printfn "%A"
```

### [snippet.0058.fs](snippet.0058.fs)
```
[| -10.0 .. 10.0 |]
|> Seq.minBy (fun x -> x * x - 1.0)
|> printfn "%A"
```

### [snippet.0059.fs](snippet.0059.fs)
```
let seq1 = [ -10 .. 10 ]
Seq.nth 5 seq1
|> printfn "The fifth element: %d"
```

### [snippet.0060.fs](snippet.0060.fs)
```
let seq1 = Array.init 10 (fun index -> index.ToString())
           |> Seq.ofArray
```

### [snippet.0061.fs](snippet.0061.fs)
```
let seq1 = List.init 10 (fun index -> index.ToString())
           |> Seq.ofList
```

### [snippet.0062.fs](snippet.0062.fs)
```
let valuesSeq = [ ("a", 1); ("b", 2); ("c", 3) ]

let resultPick = Seq.pick (fun elem ->
                    match elem with
                    | (value, 2) -> Some value
                    | _ -> None) valuesSeq
printfn "%A" resultPick
```

### [snippet.0063.fs](snippet.0063.fs)
```
let names = [| "A"; "man"; "landed"; "on"; "the"; "moon" |]
let sentence = names |> Seq.reduce (fun acc item -> acc + " " + item)
printfn "sentence = %s" sentence
```

### [snippet.0064.fs](snippet.0064.fs)
```
let initialBalance = 1122.73
let transactions = [| -100.00; +450.34; -62.34; -127.00; -13.50; -12.92 |]

let balances =
    (initialBalance, transactions)
    ||> Seq.scan (fun balance transactionAmount -> balance + transactionAmount)
    |> Array.ofSeq

printfn "Initial balance:\n $%10.2f" initialBalance
printfn "Transaction   Balance"

for i in 0 .. transactions.Length - 1 do
    printfn "$%10.2f $%10.2f" transactions[i] balances[i]

printfn "Final balance:\n $%10.2f" balances[ balances.Length - 1 ]
```

### [snippet.0065.fs](snippet.0065.fs)
```
let seq1 = Seq.singleton "zero"
```

### [snippet.0066.fs](snippet.0066.fs)
```
let seq1 = { 1 .. 10 }

// The following chunks the sequence into sub-sequences of size 2
printfn "%A" (Seq.chunkBySize 2 seq1)

// The following chunks the sequence into sub-sequences of size 3, with the last sequence being a single element
printfn "%A" (Seq.chunkBySize 3 seq1)
```

### [snippet.0170.fs](snippet.0170.fs)
```
let mySeq = seq { for i in 1 .. 10 -> i*i }
let printSeq seq1 = Seq.iter (printf "%A ") seq1; printfn ""
let mySeqLessThan10 = Seq.takeWhile (fun elem -> elem < 10) mySeq
mySeqLessThan10 |> printSeq
```

### [snippet.0171.fs](snippet.0171.fs)
```
let mySeq = seq { for i in 1 .. 10 -> i*i }
let printSeq seq1 = Seq.iter (printf "%A ") seq1; printfn ""
let mySeqSkipFirst5 = Seq.skip 5 mySeq
mySeqSkipFirst5 |> printSeq
```

### [snippet.0172.fs](snippet.0172.fs)
```
let mySeq = seq { for i in 1 .. 10 -> i*i }
let printSeq seq1 = Seq.iter (printf "%A ") seq1; printfn ""
let mySeqSkipWhileLessThan10 = Seq.skipWhile (fun elem -> elem < 10) mySeq
mySeqSkipWhileLessThan10 |> printSeq
```

### [snippet.0180.fs](snippet.0180.fs)
```
let seqNumbers = [ 1.0; 1.5; 2.0; 1.5; 1.0; 1.5 ] :> seq<float>
let seqWindows = Seq.windowed 3 seqNumbers
let seqMovingAverage = Seq.map Array.average seqWindows
printfn "Initial sequence: "
printSeq seqNumbers
printfn "\nWindows of length 3: "
printSeq seqWindows
printfn "\nMoving average: "
printSeq seqMovingAverage
```

### [snippet.0201.fs](snippet.0201.fs)
```
let mySeq1 = seq { 1.. 100 }

let printSeq seq1 = Seq.iter (printf "%A ") seq1

let seqResult =
    mySeq1
    |> Seq.countBy (fun elem ->
        if elem % 3 = 0 then 0
        elif elem % 3 = 1 then 1
        else 2)

printSeq seqResult
```

### [snippet.0202.fs](snippet.0202.fs)
```
let sequence = seq { 1 .. 100 }

let printSeq seq1 = Seq.iter (printf "%A ") seq1

let sequences3 =
    sequences
    |> Seq.groupBy (fun index ->
        if (index % 3 = 0) then 0
        elif (index % 3 = 1) then 1
        else 2)

sequences3 |> printSeq
```

### [snippet.0203.fs](snippet.0203.fs)
```
let secondItem = seq { "foo"; "bar"; "baz" } |> Seq.item 1
printfn "%s" secondItem
```

### [snippet.0204.fs](snippet.0204.fs)
```
let seq1 = seq { 1..10 }
let seq2 = Seq.empty

//The following line prints seq [2; 3; 4; 5; ...]
printfn "%A" (Seq.tail seq1)

//The following line prints this error message:
//Error: The input sequence has an insufficient number of elements.
//Parameter name: source
printfn "%A" (Seq.tail seq2)
```

### [snippet.0205.fs](snippet.0205.fs)
```
let seq1 = seq { 1..10 }
let seq2 = Seq.empty

//The following line prints true
printfn "%A" (Seq.contains 5 seq1)

//The following line prints false
printfn "%A" (Seq.contains 5 seq2)
```

