## snippet.0101.fs
```
let list1 = [ 1; 2; 3]
// Error: duplicate definition.
let list1 = []
let function1 () =
   let list1 = [1; 2; 3]
   let list1 = []
   list1
```

## snippet.0102.fs
```
let list1 = [ 1; 2; 3]
let sumPlus x =
// OK: inner list1 hides the outer list1.
   let list1 = [1; 5; 10]
   x + List.sum list1
```

## snippet.0103.fs
```
let cylinderVolume radius length =
    // Define a local value pi.
    let pi = 3.14159
    length * pi * radius * radius
```

## snippet.0105.fs
```
let cylinderVolume radius length : float =
   // Define a local value pi.
   let pi = 3.14159
   length * pi * radius * radius
```

## snippet.0106.fs
```
let smallPipeRadius = 2.0
let bigPipeRadius = 3.0

// These define functions that take the length as a remaining
// argument:

let smallPipeVolume = cylinderVolume smallPipeRadius
let bigPipeVolume = cylinderVolume bigPipeRadius
```

## snippet.0107.fs
```
let length1 = 30.0
let length2 = 40.0
let smallPipeVol1 = smallPipeVolume length1
let smallPipeVol2 = smallPipeVolume length2
let bigPipeVol1 = bigPipeVolume length1
let bigPipeVol2 = bigPipeVolume length2
```

## snippet.0108.fs
```
let rec fib n = if n < 2 then 1 else fib (n - 1) + fib (n - 2)
```

## snippet.0109.fs
```
let apply1 (transform : int -> int ) y = transform y
```

## snippet.0110.fs
```
let increment x = x + 1

let result1 = apply1 increment 100
```

## snippet.0111.fs
```
let apply2 ( f: int -> int -> int) x y = f x y

let mul x y = x * y

let result2 = apply2 mul 10 20
```

## snippet.0112.fs
```
let result3 = apply1 (fun x -> x + 1) 100

let result4 = apply2 (fun x y -> x * y ) 10 20
```

## snippet.0113.fs
```
let function1 x = x + 1
let function2 x = x * 2
let h = function1 >> function2
let result5 = h 100
```

## snippet.0114.fs
```
let result6 = 100 |> function1 |> function2
```

## snippet.0201.fs
```
open System
open System.Windows.Forms

let form1 = new Form()
form1.Text <- "XYZ"

[<STAThread>]
do
   Application.Run(form1)
```

## snippet.0301.fs
```
fun x -> x + 1
fun a b c -> printfn "%A %A %A" a b c
fun (a: int) (b: int) (c: int) -> a + b * c
fun x y -> let swap (a, b) = (b, a) in swap (x, y)
```

## snippet.0302.fs
```
let list = List.map (fun i -> i + 1) [1;2;3]
printfn "%A" list
```

## snippet.0601.fs
```
let a = 1
let b = 100u
let str = "text"

// A function value binding.

let f x = x + 1
```

## snippet.0602.fs
```
let mutable x = 1
x <- x + 1
```

## snippet.0701.fs
```
open System

// Pass a null value to a .NET method.
let ParseDateTime (str: string) =
    let (success, res) = DateTime.TryParse(str, null, System.Globalization.DateTimeStyles.AssumeUniversal)
    if success then
        Some(res)
    else
        None
```

## snippet.0702.fs
```
// Open a file and create a stream reader.
let fileStream1 =
    try
        System.IO.File.OpenRead("TextFile1.txt")
    with
        | :? System.IO.FileNotFoundException -> printfn "Error: TextFile1.txt not found."; exit(1)

let streamReader = new System.IO.StreamReader(fileStream1)

// ProcessNextLine returns false when there is no more input;
// it returns true when there is more input.
let ProcessNextLine nextLine =
    match nextLine with
    | null -> false
    | inputString ->
        match ParseDateTime inputString with
        | Some(date) -> printfn "%s" (date.ToLocalTime().ToString())
        | None -> printfn "Failed to parse the input."
        true

// A null value returned from .NET method ReadLine when there is
// no more input.
while ProcessNextLine (streamReader.ReadLine()) do ()
```

## snippet.0703.fs
```
match box value with
| null -> printf "The value is null."
| _ -> printf "The value is not null."
```

## snippet.0801.fs
```
let f a b = a + b + 100
```

## snippet.0802.fs
```
// Type annotations on a parameter.
let addu1 (x : uint32) y =
    x + y

// Type annotations on an expression.
let addu2 x y =
    (x : uint32) + y
```

## snippet.0803.fs
```
let addu1 x y : uint32 =
    x + y
```

## snippet.0804.fs
```
let makeTuple a b = (a, b)
```

## snippet.0901.fs
```
let function1 x y = x + y
// The next line results in a compiler warning.
function1 10 20
// Changing the code to one of the following eliminates the warning.
// Use this when you do want the return value.
let result = function1 10 20
// Use this if you are only calling the function for its side effects,
// and do not want the return value.
function1 10 20 |> ignore
```

## snippet.1001.fs
```
let str1 = "abc
def"
let str2 = "abc\
def"
```

## snippet.1002.fs
```
printfn "%c" str1[1]
```

## snippet.1003.fs
```
printfn "%s" str1[0..2]
printfn "%s" str2[3..5]
```

## snippet.1004.fs
```
// "abc" interpreted as a Unicode string.
let str1 : string = "abc"
// "abc" interpreted as an ASCII byte array.
let bytearray : byte[] = "abc"B
```

## snippet.1005.fs
```
let printChar (str : string) (index : int) =
    printfn "First character: %c" (str.Chars(index))
```

## snippet.1006.fs
```
let string1 = "Hello, " + "world"
```

## snippet.1101.fs
```
let i = 1
```

## snippet.1102.fs
```
let someVeryLongIdentifier =
    // Note indentation below.
    3 * 4 + 5 * 6
```

## snippet.1103.fs
```
let i, j, k = (1, 2, 3)
```

## snippet.1104.fs
```
let result =

    let i, j, k = (1, 2, 3)

    // Body expression:
    i + 2*j + 3*k
```

## snippet.1105.fs
```
// Error:
printfn "%d" x
let x = 100
// OK:
printfn "%d" x
```

## snippet.1106.fs
```
let function1 a =
    a + 1
```

## snippet.1107.fs
```
let function2 (a, b) = a + b
```

## snippet.1108.fs
```
let function1 (a: int) : int = a + 1
```

## snippet.1109.fs
```
let result =
    let function3 (a, b) = a + b
    100 * function3 (1, 2)
```

## snippet.1110.fs
```
type MyClass(a) =
    let field1 = a
    let field2 = "text"
    do printfn "%d %s" field1 field2
    member this.F input =
        printfn "Field1 %d Field2 %s Input %A" field1 field2 input
```

## snippet.1111.fs
```
[<Obsolete>]
let function1 x y = x + y
```

## snippet.1112.fs
```
let  a2, [<Obsolete>] b2 = (1, 2)
```

## snippet.1203.fs
```
let function1 (a, b) = a + b
```

## snippet.1207.fs
```
let sum a b = a + b
```

## snippet.1301.fs
```
let list123 = [ 1; 2; 3 ]
```

## snippet.13011.fs
```
let list123 = [
    1
    2
    3 ]
```

## snippet.13012.fs
```
let myControlList : Control list = [ new Button(); new CheckBox() ]
```

## snippet.1302.fs
```
let list1 = [ 1 .. 10 ]
```

## snippet.1303.fs
```
let listOfSquares = [ for i in 1 .. 10 -> i*i ]
```

## snippet.1304.fs
```
// An empty list.
let listEmpty = []
```

## snippet.1305.fs
```
let list2 = 100 :: list1
```

## snippet.1306.fs
```
let list3 = list1 @ list2
```

## snippet.1307.fs
```
let list1 = [ 1; 2; 3 ]

// Properties
printfn "list1.IsEmpty is %b" (list1.IsEmpty)
printfn "list1.Length is %d" (list1.Length)
printfn "list1.Head is %d" (list1.Head)
printfn "list1.Tail.Head is %d" (list1.Tail.Head)
printfn "list1.Tail.Tail.Head is %d" (list1.Tail.Tail.Head)
printfn "list1.Item(1) is %d" (list1.Item(1))
```

## snippet.13071.fs
```
let rec sum list =
   match list with
   | head :: tail -> head + sum tail
   | [] -> 0
```

## snippet.13072.fs
```
let sum list =
   let rec loop list acc =
       match list with
       | head :: tail -> loop tail (acc + head)
       | [] -> acc
   loop list 0
```

## snippet.1308.fs
```
let IsPrimeMultipleTest n x =
   x = n || x % n <> 0

let rec RemoveAllMultiples listn listx =
   match listn with
   | head :: tail -> RemoveAllMultiples tail (List.filter (IsPrimeMultipleTest head) listx)
   | [] -> listx


let GetPrimesUpTo n =
    let max = int (sqrt (float n))
    RemoveAllMultiples [ 2 .. max ] [ 1 .. n ]

printfn "Primes Up To %d:\n %A" 100 (GetPrimesUpTo 100)
```

## snippet.1309.fs
```
let list1 = [1;2;3]
let list2 = [4;5;6]
List.iter (fun x -> printfn "List.iter: element is %d" x) list1
List.iteri(fun i x -> printfn "List.iteri: element %d is %d" i x) list1
List.iter2 (fun x y -> printfn "List.iter2: elements are %d %d" x y) list1 list2
List.iteri2 (fun i x y ->
               printfn "List.iteri2: element %d of list_1 is %d element %d of list2 is %d"
                 i x i y)
            list1 list2
```

## snippet.1310.fs
```
let newList = List.map (fun x -> x + 1) list1
printfn "%A" newList
```

## snippet.1311.fs
```
let sumList = List.map2 (fun x y -> x + y) list1 list2
printfn "%A" sumList

let newList2 = List.map3 (fun x y z -> x + y + z) list1 list2 newList
printfn "%A" newList2

let collectList = List.collect (fun x -> [for i in 1..3 -> x * i]) list1
printfn "%A" collectList

let newListAddIndex = List.mapi (fun i x -> x + i) list1
printfn "%A" newListAddIndex

let listAddTimesIndex = List.mapi2 (fun i x y -> (x + y) * i) list1 list2
printfn "%A" listAddTimesIndex
```

## snippet.1312.fs
```
let evenOnlyList = List.filter (fun x -> x % 2 = 0) [1; 2; 3; 4; 5; 6]
```

## snippet.1401.fs
```
let exists (x : int option) =
    match x with
    | Some(x) -> true
    | None -> false
```

## snippet.1402.fs
```
open System.IO
let openFile filename =
    try
        let file = File.Open (filename, FileMode.Create)
        Some(file)
    with
        | ex -> eprintf "An exception occurred with message %s" ex.Message
                None
```

## snippet.1403.fs
```
let rec tryFindMatch pred list =
    match list with
    | head :: tail -> if pred(head)
                        then Some(head)
                        else tryFindMatch pred tail
    | [] -> None

// result1 is Some 100 and its type is int option.
let result1 = tryFindMatch (fun elem -> elem = 100) [ 200; 100; 50; 25 ]

// result2 is None and its type is int option.
let result2 = tryFindMatch (fun elem -> elem = 26) [ 200; 100; 50; 25 ]
```

## snippet.1404.fs
```
let keepIfPositive (a : int) = if a > 0 then Some(a) else None
```

## snippet.1501.fs
```
seq { 1 .. 5 }
```

## snippet.1502.fs
```
// Sequence that has an increment.
seq { 0 .. 10 .. 100 }
```

## snippet.1503.fs
```
seq { for i in 1 .. 10 -> i * i }
```

## snippet.1504.fs
```
seq { for i in 1 .. 10 do yield i * i }

// The 'yield' is implicit and doesn't need to be specified in most cases.
seq { for i in 1 .. 10 do i * i }
```

## snippet.1505.fs
```
let (height, width) = (10, 10)

seq {
    for row in 0 .. width - 1 do
        for col in 0 .. height - 1 ->
            (row, col, row*width + col)
    }
```

## snippet.1506.fs
```
seq { for n in 1 .. 100 do if isprime n then n }
```

## snippet.1507.fs
```
// Recursive isprime function.
let isprime n =
    let rec check i =
        i > n/2 || (n % i <> 0 && check (i + 1))
    check 2

let aSequence =
    seq {
        for n in 1..100 do
            if isprime n then
                n
    }

for x in aSequence do
    printfn "%d" x
```

## snippet.1508.fs
```
let multiplicationTable =
    seq {
        for i in 1..9 do
            for j in 1..9 ->
                (i, j, i*j)
    }
```

## snippet.1509.fs
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

## snippet.1601.fs
```
let array1 = [| 1; 2; 3 |]
```

## snippet.1602.fs
```
let array3 = [| for i in 1 .. 10 -> i * i |]
```

## snippet.1603.fs
```
array1[1]
```

## snippet.1604.fs
```
array1[0..2]  // elements from 0 to 2
array1[..2] // elements the beginning of the array to 2
array1[2..] // elements from 2 to the end
```

## snippet.1605.fs
```
let arrayOfTenZeroes : int array = Array.zeroCreate 10
```

## snippet.1700.fs
```
let makeList a b =
    [a; b]
```

## snippet.1701.fs
```
let function1 (x: 'a) (y: 'a) =
    printfn "%A %A" x y
```

## snippet.1702.fs
```
// In this case, the type argument is inferred to be int.
function1 10 20
// In this case, the type argument is float.
function1 10.0 20.0
// Type arguments can be specified, but should only be specified
// if the type parameters are declared explicitly. If specified,
// they have an effect on type inference, so in this example,
// a and b are inferred to have type int.
let function3 a b =
    // The compiler reports a warning:
    function1<int> a b
    // No warning.
    function2<int> a b
```

## snippet.1703.fs
```
let function2<'T> (x: 'T) (y: 'T) =
    printfn "%A, %A" x y
```

## snippet.1704.fs
```
let printSequence (sequence1: Collections.seq<_>) =
   Seq.iter (fun elem -> printf "%s " (elem.ToString())) sequence1
```

## snippet.1705.fs
```
// A generic function.
// In this example, the generic type parameter 'a makes function3 generic.
let function3 (x : 'a) (y : 'a) =
    printf "%A %A" x y

// A generic record, with the type parameter in angle brackets.
type GR<'a> =
    {
        Field1: 'a;
        Field2: 'a;
    }

// A generic class.
type C<'a>(a : 'a, b : 'a) =
    let z = a
    let y = b
    member this.GenericMethod(x : 'a) =
        printfn "%A %A %A" x y z

// A generic discriminated union.
type U<'a> =
    | Choice1 of 'a
    | Choice2 of 'a * 'a

type Test() =
    // A generic member
    member this.Function1<'a>(x, y) =
        printfn "%A, %A" x y

    // A generic abstract method.
    abstract abstractMethod<'a, 'b> : 'a * 'b -> unit
    override this.abstractMethod<'a, 'b>(x:'a, y:'b) =
         printfn "%A, %A" x y
```

## snippet.1801.fs
```
let max a b = if a > b then a else b
```

## snippet.1802.fs
```
let biggest_float = max 2.0 3.0

let biggest_int = max 2 3
```

## snippet.1803.fs
```
let test_string = max "cab" "cat"
```

## snippet.1804.fs
```
// Case 1: Too complex an expression.
// In this example, the list sqrList is intended to be a list of integers,
// but it is not defined as a simple immutable value.
let sqrList1 = [ for i in 1..10 -> i*i ]
// Adding a type annotation fixes the problem:
let sqrList2 : int list = [ for i in 1..10 -> i*i ]

// Case 2: Using a nongeneralizable construct to define a generic function.
// In this example, the construct is nongeneralizable because
// it involves partial application of function arguments.
let maxhash1 = max hash
// The following is acceptable because the argument for maxhash is explicit:
let maxhash2 obj = max hash obj

// Case 3: Adding an extra, unused parameter.
// Because this expression is not simple enough for generalization, the compiler
// issues the value restriction error.
let zeroList1 = Array.create 10 []
// Adding an extra (unused) parameter makes it a function, which is generalizable.
let zeroList2 () = Array.create 10 []

// Case 4: Adding type parameters.
let emptyset1 = Set.Empty
// Adding a type parameter and type annotation lets you write a generic value.
let emptyset2<'a> : Set<'a> = Set.Empty
```

## snippet.1901.fs
```
// Labels are separated by semicolons when defined on the same line.
type Point = { X: float; Y: float; Z: float; }

// You can define labels on their own line with or without a semicolon.
type Customer = 
    { First: string
      Last: string;
      SSN: uint32
      AccountNumber: uint32; }

// A struct record.
[<Struct>]
type StructPoint = 
    { X: float
      Y: float
      Z: float }
```

## snippet.1902.fs
```
let mypoint1 = { new Point with x = 1.0 and y = 1.0 and z = -1.0 }
let mypoint2 = { x = 1.0; y = 1.0; z = -1.0; }
```

## snippet.1903.fs
```
type Point = { X: float; Y: float; Z: float; }
type Point3D = { X: float; Y: float; Z: float }
// Ambiguity: Point or Point3D?
let mypoint3D = { X = 1.0; Y = 1.0; Z = 0.0; }
```

## snippet.1904.fs
```
type MyRecord = 
    { X: int
      Y: int
      Z: int }

let myRecord1 = { X = 1; Y = 2; Z = 3; }
```

## snippet.1905.fs
```
let myRecord2 = { MyRecord.X = 1; MyRecord.Y = 2; MyRecord.Z = 3 }
```

## snippet.1906.fs
```
let myRecord3 = { myRecord2 with Y = 100; Z = 2 }
```

## snippet.1907.fs
```
let mypoint = { X = 1.0; Y = 1.0; Z = -1.0; }
```

## snippet.1908.fs
```
let myPoint1 = { Point.X = 1.0; Y = 1.0; Z = 0.0; }
```

## snippet.1909.fs
```
type Car = 
    { Make : string
      Model : string
      mutable Odometer : int }

let myCar = { Make = "Fabrikam"; Model = "Coupe"; Odometer = 108112 }
myCar.Odometer <- myCar.Odometer + 21
```

## snippet.1910.fs
```
type Point3D = { X: float; Y: float; Z: float }
let evaluatePoint (point: Point3D) =
    match point with
    | { X = 0.0; Y = 0.0; Z = 0.0 } -> printfn "Point is at the origin."
    | { X = xVal; Y = 0.0; Z = 0.0 } -> printfn "Point is on the x-axis. Value is %f." xVal
    | { X = 0.0; Y = yVal; Z = 0.0 } -> printfn "Point is on the y-axis. Value is %f." yVal
    | { X = 0.0; Y = 0.0; Z = zVal } -> printfn "Point is on the z-axis. Value is %f." zVal
    | { X = xVal; Y = yVal; Z = zVal } -> printfn "Point is at (%f, %f, %f)." xVal yVal zVal

evaluatePoint { X = 0.0; Y = 0.0; Z = 0.0 }
evaluatePoint { X = 100.0; Y = 0.0; Z = 0.0 }
evaluatePoint { X = 10.0; Y = 0.0; Z = -1.0 }
```

## snippet.1911.fs
```
type RecordTest = { X: int; Y: int }

let record1 = { X = 1; Y = 2 }
let record2 = { X = 1; Y = 2 }

if (record1 = record2) then
    printfn "The records are equal."
else
    printfn "The records are unequal."
```

## snippet.2001.fs
```
let myOption1 = Some(10.0)
let myOption2 = Some("string")
let myOption3 = None
```

## snippet.2002.fs
```
let printValue opt =
    match opt with
    | Some x -> printfn "%A" x
    | None -> printfn "No value."
```

## snippet.2003.fs
```
type Shape =
  // The value here is the radius.
| Circle of float
  // The value here is the side length.
| EquilateralTriangle of double
  // The value here is the side length.
| Square of double
  // The values here are the height and width.
| Rectangle of double * double
```

## snippet.2004.fs
```
let pi = 3.141592654

let area myShape =
    match myShape with
    | Circle radius -> pi * radius * radius
    | EquilateralTriangle s -> (sqrt 3.0) / 4.0 * s * s
    | Square s -> s * s
    | Rectangle (h, w) -> h * w

let radius = 15.0
let myCircle = Circle(radius)
printfn "Area of circle that has radius %f: %f" radius (area myCircle)

let squareSide = 10.0
let mySquare = Square(squareSide)
printfn "Area of square that has side %f: %f" squareSide (area mySquare)

let height, width = 5.0, 10.0
let myRectangle = Rectangle(height, width)
printfn "Area of rectangle that has height %f and width %f is %f" height width (area myRectangle)
```

## snippet.2005.fs
```
type Tree =
    | Tip
    | Node of int * Tree * Tree

let rec sumTree tree =
    match tree with
    | Tip -> 0
    | Node(value, left, right) ->
        value + sumTree(left) + sumTree(right)
let myTree = Node(0, Node(1, Node(2, Tip, Tip), Node(3, Tip, Tip)), Node(4, Tip, Tip))
let resultSumTree = sumTree myTree
```

## snippet.2006.fs
```
type Expression =
    | Number of int
    | Add of Expression * Expression
    | Multiply of Expression * Expression
    | Variable of string

let rec Evaluate (env:Map<string,int>) exp =
    match exp with
    | Number n -> n
    | Add (x, y) -> Evaluate env x + Evaluate env y
    | Multiply (x, y) -> Evaluate env x * Evaluate env y
    | Variable id -> env[id]

let environment = Map [ "a", 1; "b", 2; "c", 3 ]

// Create an expression tree that represents
// the expression: a + 2 * b.
let expressionTree1 = Add(Variable "a", Multiply(Number 2, Variable "b"))

// Evaluate the expression a + 2 * b, given the
// table of values for the variables.
let result = Evaluate environment expressionTree1
```

## snippet.2101.fs
```
// Declaration of an enumeration.
type Color =
   | Red = 0
   | Green = 1
   | Blue = 2
// Use of an enumeration.
let col1 : Color = Color.Red
```

## snippet.2102.fs
```
// Conversion to an integral type.
let n = int col1
```

## snippet.2103.fs
```
let col2 = enum<Color>(3)
```

## snippet.2104.fs
```
type uColor =
   | Red = 0u
   | Green = 1u
   | Blue = 2u
let col3 = Microsoft.FSharp.Core.LanguagePrimitives.EnumOfValue<uint32, uColor>(2u)
```

## snippet.2201.fs
```
// Declare a reference.
let refVar = ref 6

// Change the value referred to by the reference.
refVar := 50

// Dereference by using the ! operator.
printfn "%d" !refVar
```

## snippet.2203.fs
```
let xRef : int ref = ref 10

printfn "%d" (xRef.Value)
printfn "%d" (xRef.contents)

xRef.Value <- 11
printfn "%d" (xRef.Value)
xRef.contents <- 12
printfn "%d" (xRef.contents)
```

## snippet.2204.fs
```
type Incrementor(delta) =
    member this.Increment(i : int byref) =
        i <- i + delta

let incrementor = new Incrementor(1)
let mutable myDelta1 = 10
incrementor.Increment(ref myDelta1)
// Prints 10:
printfn "%d" myDelta1

let mutable myDelta2 = 10
incrementor.Increment(&myDelta2)
// Prints 11:
printfn "%d" myDelta2

let refInt = ref 10
incrementor.Increment(refInt)
// Prints 11:
printfn "%d" !refInt
```

## snippet.2205.fs
```
// Print all the lines read in from the console.
let printLines1() =
    let mutable finished = false
    while not finished do
        match System.Console.ReadLine() with
        | null -> finished <- true
        | s -> printfn "line is: %s" s


// Attempt to wrap the printing loop into a
// sequence expression to delay the computation.
let printLines2() =
    seq {
        let mutable finished = false
        // Compiler error:
        while not finished do
            match System.Console.ReadLine() with
            | null -> finished <- true
            | s -> s
    }

// You must use a reference cell instead.
let printLines3() =
    seq {
        let mutable finished = false
        while not finished do
            match System.Console.ReadLine() with
            | null -> finished := true
            | s -> s
    }
```

## snippet.2207.fs
```
// The following code demonstrates the use of reference
// cells to enable partially applied arguments to be changed
// by later code.

let increment1 delta number = number + delta

let mutable myMutableIncrement = 10

// Closures created by partial application and literals.
let incrementBy1 = increment1 1
let incrementBy2 = increment1 2

// Partial application of one argument from a mutable variable.
let incrementMutable = increment1 myMutableIncrement

myMutableIncrement <- 12

// This line prints 110.
printfn "%d" (incrementMutable 100)

let myRefIncrement = ref 10

// Partial application of one argument, dereferenced
// from a reference cell.
let incrementRef = increment1 !myRefIncrement

myRefIncrement := 12

// This line also prints 110.
printfn "%d" (incrementRef 100)

// Reset the value of the reference cell.
myRefIncrement := 10

// New increment function takes a reference cell.
let increment2 delta number = number + !delta

// Partial application of one argument, passing a reference cell
// without dereferencing first.
let incrementRef2 = increment2 myRefIncrement

myRefIncrement := 12

// This line prints 112.
printfn "%d" (incrementRef2 100)
```

## snippet.2301.fs
```
type SizeType = uint32
```

## snippet.2302.fs
```
type Transform<'a> = 'a -> 'a
```

## snippet.2401.fs
```
type MyClass1(x: int, y: int) =
   do printfn "%d %d" x y
   new() = MyClass1(0, 0)
```

## snippet.2402.fs
```
type MyClass2(dataIn) as self =
   let data = dataIn
   do
       self.PrintMessage()
   member this.PrintMessage() =
       printf "Creating MyClass2 with Data %d" data
```

## snippet.2403.fs
```
type MyGenericClass<'a> (x: 'a) =
   do printfn "%A" x
```

## snippet.24031.fs
```
let g1 = MyGenericClass( seq { for i in 1 .. 10 -> (i, i*i) } )
```

## snippet.24032.fs
```
type ISprintable =
    abstract member Print : format:string -> unit
```

## snippet.2404.fs
```
open System.IO

type Folder(pathIn: string) =
  let path = pathIn
  let filenameArray : string array = Directory.GetFiles(path)
  member this.FileArray = Array.map (fun elem -> new File(elem, this)) filenameArray

and File(filename: string, containingFolder: Folder) =
   member this.Name = filename
   member this.ContainingFolder = containingFolder

let folder1 = new Folder(".")
for file in folder1.FileArray do
   printfn "%s" file.Name
```

## snippet.2501.fs
```
// In Point3D, three immutable values are defined.
// x, y, and z will be initialized to 0.0.
type Point3D =
    struct
        val x: float
        val y: float
        val z: float
    end

// In Point2D, two immutable values are defined.
// It also has a member which computes a distance between itself and another Point2D.
// Point2D has an explicit constructor.
// You can create zero-initialized instances of Point2D, or you can
// pass in arguments to initialize the values.
type Point2D =
    struct
        val X: float
        val Y: float
        new(x: float, y: float) = { X = x; Y = y }

        member this.GetDistanceFrom(p: Point2D) =
            let dX = (p.X - this.X) ** 2.0
            let dY = (p.Y - this.Y) ** 2.0
            
            dX + dY
            |> sqrt
    end
```

## snippet.2601.fs
```
type MyClassBase1() =
   let mutable z = 0
   abstract member function1 : int -> int
   default u.function1(a : int) = z <- z + a; z

type MyClassDerived1() =
   inherit MyClassBase1()
   override u.function1(a: int) = a + 1
```

## snippet.2602.fs
```
type MyClassBase2(x: int) =
   let mutable z = x * x
   do for i in 1..z do printf "%d " i


type MyClassDerived2(y: int) =
   inherit MyClassBase2(y * 2)
   do for i in 1..y do printf "%d " i
```

## snippet.2603.fs
```
open System

let object1 = { new Object() with
      override this.ToString() = "This overrides object.ToString()"
      }

printfn "%s" (object1.ToString())
```

## snippet.2801.fs
```
type IPrintable =
   abstract member Print : unit -> unit

type SomeClass1(x: int, y: float) =
   interface IPrintable with
      member this.Print() = printfn "%d %f" x y
```

## snippet.2802.fs
```
let x1 = new SomeClass1(1, 2.0)
(x1 :> IPrintable).Print()
```

## snippet.2803.fs
```
type SomeClass2(x: int, y: float) =
   member this.Print() = (this :> IPrintable).Print()
   interface IPrintable with
      member this.Print() = printfn "%d %f" x y

let x2 = new SomeClass2(1, 2.0)
x2.Print()
```

## snippet.2804.fs
```
let makePrintable(x: int, y: float) =
    { new IPrintable with
              member this.Print() = printfn "%d %f" x y }
let x3 = makePrintable(1, 2.0)
x3.Print()
```

## snippet.2805.fs
```
type Interface1 =
    abstract member Method1 : int -> int

type Interface2 =
    abstract member Method2 : int -> int

type Interface3 =
    inherit Interface1
    inherit Interface2
    abstract member Method3 : int -> int

type MyClass() =
    interface Interface3 with
        member this.Method1(n) = 2 * n
        member this.Method2(n) = n + 100
        member this.Method3(n) = n / 10
```

## snippet.2901.fs
```
// An abstract class that has some methods and properties defined
// and some left abstract.
[<AbstractClass>]
type Shape2D(x0 : float, y0 : float) =
    let mutable x, y = x0, y0
    let mutable rotAngle = 0.0

    // These properties are not declared abstract. They
    // cannot be overriden.
    member this.CenterX with get() = x and set xval = x <- xval
    member this.CenterY with get() = y and set yval = y <- yval

    // These properties are abstract, and no default implementation
    // is provided. Non-abstract derived classes must implement these.
    abstract Area : float with get
    abstract Perimeter : float  with get
    abstract Name : string with get

    // This method is not declared abstract. It cannot be
    // overridden.
    member this.Move dx dy =
       x <- x + dx
       y <- y + dy

    // An abstract method that is given a default implementation
    // is equivalent to a virtual method in other .NET languages.
    // Rotate changes the internal angle of rotation of the square.
    // Angle is assumed to be in degrees.
    abstract member Rotate: float -> unit
    default this.Rotate(angle) = rotAngle <- rotAngle + angle

type Square(x, y, sideLengthIn) =
    inherit Shape2D(x, y)
    member this.SideLength = sideLengthIn
    override this.Area = this.SideLength * this.SideLength
    override this.Perimeter = this.SideLength * 4.
    override this.Name = "Square"

type Circle(x, y, radius) =
    inherit Shape2D(x, y)
    let PI = 3.141592654
    member this.Radius = radius
    override this.Area = PI * this.Radius * this.Radius
    override this.Perimeter = 2. * PI * this.Radius
    // Rotating a circle does nothing, so use the wildcard
    // character to discard the unused argument and
    // evaluate to unit.
    override this.Rotate(_) = ()
    override this.Name = "Circle"

let square1 = new Square(0.0, 0.0, 10.0)
let circle1 = new Circle(0.0, 0.0, 5.0)
circle1.CenterX <- 1.0
circle1.CenterY <- -2.0
square1.Move -1.0 2.0
square1.Rotate 45.0
circle1.Rotate 45.0
printfn "Perimeter of square with side length %f is %f, %f"
        (square1.SideLength) (square1.Area) (square1.Perimeter)
printfn "Circumference of circle with radius %f is %f, %f"
        (circle1.Radius) (circle1.Area) (circle1.Perimeter)

let shapeList : list<Shape2D> = [ (square1 :> Shape2D);
                                  (circle1 :> Shape2D) ]
List.iter (fun (elem : Shape2D) ->
              printfn "Area of %s: %f" (elem.Name) (elem.Area))
          shapeList
```

## snippet.3001.fs
```
type PointWithCounter(a: int, b: int) =
    // A variable i.
    let mutable i = 0

    // A let binding that uses a pattern.
    let (x, y) = (a, b)

    // A private function binding.
    let privateFunction x y = x * x + 2*y

    // A static let binding.
    static let mutable count = 0

    // A do binding.
    do
       count <- count + 1

    member this.Prop1 = x
    member this.Prop2 = y
    member this.CreatedCount = count
    member this.FunctionValue = privateFunction x y

let point1 = PointWithCounter(10, 52)

printfn "%d %d %d %d" (point1.Prop1) (point1.Prop2) (point1.CreatedCount) (point1.FunctionValue)
```

## snippet.3101.fs
```
open System

type MyType(a:int, b:int) as this =
    inherit Object()
    let x = 2*a
    let y = 2*b
    do printfn "Initializing object %d %d %d %d %d %d"
               a b x y (this.Prop1) (this.Prop2)
    static do printfn "Initializing MyType."
    member this.Prop1 = 4*x
    member this.Prop2 = 4*y
    override this.ToString() = System.String.Format("{0} {1}", this.Prop1, this.Prop2)

let obj1 = new MyType(1, 2)
```

## snippet.3201.fs
```
// A read-only property.
member this.MyReadOnlyProperty = myInternalValue
// A write-only property.
member this.MyWriteOnlyProperty with set (value) = myInternalValue <- value
// A read-write property.
member this.MyReadWriteProperty
    with get () = myInternalValue
    and set (value) = myInternalValue <- value
```

## snippet.3202.fs
```
type MyClass(x : string) =
    let mutable myInternalValue = x
    member this.MyProperty
         with get() = myInternalValue
         and set(value) = myInternalValue <- value
```

## snippet.3203.fs
```
member this.MyReadWriteProperty with get () = myInternalValue
member this.MyReadWriteProperty with set (value) = myInternalValue <- value
```

## snippet.3204.fs
```
static member MyStaticProperty
    with get() = myStaticValue
    and set(value) = myStaticValue <- value
```

## snippet.3205.fs
```
// To apply a type annotation to a property that does not have an explicit
// get or set, apply the type annotation directly to the property.
member this.MyProperty1 : int = myInternalValue
// If there is a get or set, apply the type annotation to the get or set method.
member this.MyProperty2 with get() : int = myInternalValue
```

## snippet.3206.fs
```
// Assume that the constructor argument sets the initial value of the
// internal backing store.
let mutable myObject = new MyType(10)
myObject.MyProperty <- 20
printfn "%d" (myObject.MyProperty)
```

## snippet.3207.fs
```
// Abstract property in abstract class.
// The property is an int type that has a get and
// set method
[<AbstractClass>]
type AbstractBase() =
   abstract Property1 : int with get, set

// Implementation of the abstract property
type Derived1() =
   inherit AbstractBase()
   let mutable value = 10
   override this.Property1 with get() = value and set(v : int) = value <- v

// A type with a "virtual" property.
 type Base1() =
   let mutable value = 10
   abstract Property1 : int with get, set
   default this.Property1 with get() = value and set(v : int) = value <- v

// A derived type that overrides the virtual property
type Derived2() =
   inherit Base1()
   let mutable value2 = 11
   override this.Property1 with get() = value2 and set(v) = value2 <- v
```

## snippet.3301.fs
```
type NumberStrings() =
   let mutable ordinals = [| "one"; "two"; "three"; "four"; "five";
                             "six"; "seven"; "eight"; "nine"; "ten" |]
   let mutable cardinals = [| "first"; "second"; "third"; "fourth";
                              "fifth"; "sixth"; "seventh"; "eighth";
                              "ninth"; "tenth" |]
   member this.Item
      with get(index) = ordinals[index]
      and set index value = ordinals[index] <- value
   member this.Ordinal
      with get(index) = ordinals[index]
      and set index value = ordinals[index] <- value
   member this.Cardinal
      with get(index) = cardinals[index]
      and set index value = cardinals[index] <- value

let nstrs = new NumberStrings()
nstrs[0] <- "ONE"
for i in 0 .. 9 do
  printf "%s " nstrs[i]
printfn ""

nstrs.Cardinal(5) <- "6th"

for i in 0 .. 9 do
  printf "%s " (nstrs.Ordinal(i))
  printf "%s " (nstrs.Cardinal(i))
printfn ""
```

## snippet.3302.fs
```
open System.Collections.Generic

type SparseMatrix() =
    let mutable table = new Dictionary<(int * int), float>()
    member this.Item
        with get(key1, key2) = table[(key1, key2)]
        and set (key1, key2) value = table[(key1, key2)] <- value

let matrix1 = new SparseMatrix()
for i in 1..1000 do
    matrix1[i, i] <- float i * float i
```

## snippet.3401.fs
```
type SomeType(factor0: int) =
   let factor = factor0
   member this.SomeMethod(a, b, c) =
      (a + b + c) * factor

   member this.SomeOtherMethod(a, b, c) =
      this.SomeMethod(a, b, c) * factor
```

## snippet.3402.fs
```
static member SomeStaticMethod(a, b, c) =
   (a + b + c)

static member SomeOtherStaticMethod(a, b, c) =
   SomeType.SomeStaticMethod(a, b, c) * 100
```

## snippet.3403.fs
```
type Ellipse(a0 : float, b0 : float, theta0 : float) =
    let mutable axis1 = a0
    let mutable axis2 = b0
    let mutable rotAngle = theta0
    abstract member Rotate: float -> unit
    default this.Rotate(delta : float) = rotAngle <- rotAngle + delta
```

## snippet.3404.fs
```
type Circle(radius : float) =
    inherit Ellipse(radius, radius, 0.0)
     // Circles are invariant to rotation, so do nothing.
    override this.Rotate(_) = ()
```

## snippet.3405.fs
```
type SomeType2 =
   member this.SomeMethod(a : int, b : int) =
     a + b
   member this.SomeMethod(a : int, b : int, c : int) =
     a + b + c
   member this.AnotherMethod(a : int, b : int) =
     a + b
   member this.AnotherMethod(a: float, b : float) =
     a + b
```

## snippet.3406.fs
```
type RectangleXY(x1 : float, y1: float, x2: float, y2: float) =
    // Field definitions.
    let height = y2 - y1
    let width = x2 - x1
    let area = height * width
    // Private functions.
    static let maxFloat (x: float) (y: float) =
      if x >= y then x else y
    static let minFloat (x: float) (y: float) =
      if x <= y then x else y
    // Properties.
    // Here, "this" is used as the self identifier,
    // but it can be any identifier.
    member this.X1 = x1
    member this.Y1 = y1
    member this.X2 = x2
    member this.Y2 = y2
    // A static method.
    static member intersection(rect1 : RectangleXY, rect2 : RectangleXY) =
       let x1 = maxFloat rect1.X1 rect2.X1
       let y1 = maxFloat rect1.Y1 rect2.Y1
       let x2 = minFloat rect1.X2 rect2.X2
       let y2 = minFloat rect1.Y2 rect2.Y2
       let result : RectangleXY option =
         if ( x2 > x1 && y2 > y1) then
           Some (RectangleXY(x1, y1, x2, y2))
         else
           None
       result

// Test code.
let testIntersection =
    let r1 = RectangleXY(10.0, 10.0, 20.0, 20.0)
    let r2 = RectangleXY(15.0, 15.0, 25.0, 25.0)
    let r3 : RectangleXY option = RectangleXY.intersection(r1, r2)
    match r3 with
    | Some(r3) -> printfn "Intersection rectangle: %f %f %f %f" r3.X1 r3.Y1 r3.X2 r3.Y2
    | None -> printfn "No intersection found."

testIntersection
```

## snippet.3501.fs
```
// x, y and return value inferred to be int
// function1: int -> int -> int
let function1 x y = x + y

// x, y and return value inferred to be float
// function2: float -> float -> float
let function2 (x: float) y = x + y
```

## snippet.4001.fs
```
let rec fib n =
   if n <= 2 then 1
   else fib (n - 1) + fib (n - 2)
```

## snippet.4002.fs
```
let rec Even x = 
    if x = 0 then true 
    else Odd (x-1) 
and Odd x = 
    if x = 0 then false 
    else Even (x-1)
```

