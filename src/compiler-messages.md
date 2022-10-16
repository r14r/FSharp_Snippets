### [fs0001.fsx](fs0001.fsx)
```
(* simple type annotation mismatch example *)
let booleanBinding: bool = 10

(* more complex type-inference across functions example *)
// this function has type `int -> int`.
// `+` takes the type of the arguments passed to it, and `1` is of type `int`, so
// `+` must be of type `int -> int`
let addOne i = i + 1

// this function has type `int -> int`, which may be surprising because no types are explicitly specified.
// the `printfn` call on the first line is of type `'a -> unit`, because `printfn "%A"` takes a value of any type and returns unit.
// this means that the type of the `i` parameter hasn't yet been decided based on how the parameter is used.
// the `addOne` call on the second line is of type `int -> int`, because `addOne` is of type `int -> int` (see above).
// this means that `i` _must_ be of type `int`, so the overall type signature of `printThenAdd` is inferred to be `int -> int`
let printThenAdd i =
    printfn "%A" i
    addOne i

// this line triggers the error
// > This expression was expected to have type
// >   'int'
// > but here has type
// >   'string'
// because `printThenAdd` has been inferred to have type `int -> int`, but a string was passed in as the `int` parameter
printThenAdd "a number"
|> ignore
```

### [fs0002.fsx](fs0002.fsx)
```
let ignoreInt (f: int) = ()

do ignoreInt (fun x -> x + 1)


let ignoreInt (i: int) = ()

do ignoreInt 1
```

### [fs0003.fsx](fs0003.fsx)
```
(* passing a parameter to a value *)
let v = 10

v "a parameter"

(* incorrect indexer usage - missing dot *)
let listOfInts = [1; 2; 3]
printfn "%d" (listOfInts[1])
```

### [fs0005.fsx](fs0005.fsx)
```
(* simple mutable assignment of immutable record field example  *)
type Food =  { Kind: string
               DaysOld: int }

let apple = { Kind = "apple"
              DaysOld = 10 }

apple.Kind <- "orange"

(* solving the problem by making the field mutable *)
type Food =  { mutable Kind: string
               DaysOld: int }

let apple = { Kind = "apple"
              DaysOld = 10 }

apple.Kind <- "orange"

(* solving the problem by immutable update *)
type Food =  { Kind: string
               DaysOld: int }

let apple = { Kind = "apple"
              DaysOld = 10 }

let orange = { apple with Kind = "orange" }
```

### [fs0008.fsx](fs0008.fsx)
```
(* example of unboxing an obj to an unknown type *)
let unboxAndPrint x = 
    match x with
    | :? string as s -> printfn "%s" s
    | _ -> printfn "not a string"

(* fixing the error by giving `x` a known type *)
let unboxAndPrint (x: obj) = 
    match x with
    | :? string as s -> printfn "%s" s
    | _ -> printfn "not a string"

(* fixing the error by using `x` in a way the constrains the known types *)
let unboxAndPrint x = 
    printfn "%s" (string x)
```

### [fs0009.fsx](fs0009.fsx)
```
(* use of unverifiable function *)
let n: nativeptr<bool> = NativeInterop.NativePtr.stackalloc 1

(* use of the fixed expression *)
type R = { Address: int }

let useFixed (r: R) = 
    use f = fixed &r.Address
    ()

(* use of LayoutKind.Explicit *)
open System.Runtime.InteropServices

[<Struct; StructLayout(LayoutKind.Explicit)>]
type EmptyStruct = 
    struct end
```

### [fs0025.fsx](fs0025.fsx)
```
(* declaration and construction of Discriminated Union *)
type Faucet =
| Hot
| Cold

let faucet = Hot

(* complete match expression on Discriminated Union *)
let completeFaucetString =
    match faucet with
    | Hot -> "Hot"
    | Cold -> "Cold"

(* incomplete match expression on Discriminated Union *)
let incompleteFaucetString =
    match faucet with
    | Hot -> "Hot"

(* wildcard match expression on Discriminated Union *)
let wildcardFaucetString =
    match faucet with
    | Hot -> "Hot"
    | _ -> "Other"
```

### [fs0037.fsx](fs0037.fsx)
```
(* duplicate definition *)
let a = 5
let a = 6

(* different identifier *)
let b = 5
let c = 6

(* prime *)
let d = 5
let d' = 6
let d'' = 7

(* mutate *)
let mutable e = 5
e <- 6
```

### [fs0052.fsx](fs0052.fsx)
```
(* warn *)
System.DateTime.Now.ToString() |> printfn "%s"

(* No warn 1 *)
let now = System.DateTime.Now
now.ToString() |> printfn "%s"

(* No warn 2 *)
System.DateTime.Now |> printfn "%A"
```

### [fs0703.fsx](fs0703.fsx)
```
(*
Trying to use the result of typeof
on a unit of measure
*)
let theBadFunction<[<Measure>] 'u> = typeof<'u>
```

