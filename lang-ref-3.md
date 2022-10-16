### [snippet.0101.fs](snippet.0101.fs)
```
let max a b = if a > b then a else b
```

### [snippet.0102.fs](snippet.0102.fs)
```
let biggestFloat = max 2.0 3.0
let biggestInt = max 2 3
```

### [snippet.0103.fs](snippet.0103.fs)
```
// Error: type mismatch.
//let biggestIntFloat = max 2.0 3
```

### [snippet.0104.fs](snippet.0104.fs)
```
let testString = max "cab" "cat"
```

### [snippet.0105.fs](snippet.0105.fs)
```
//let sqrList = [ for i in 1..10 -> i*i ]
// Adding a type annotation fixes the problem:
let sqrList : int list = [ for i in 1..10 -> i*i ]
```

### [snippet.0106.fs](snippet.0106.fs)
```
//let maxhash = max hash
// The following is acceptable because the argument for maxhash is explicit:
let maxhash obj = max (hash obj)
```

### [snippet.0107.fs](snippet.0107.fs)
```
//let emptyList10 = Array.create 10 []
// Adding an extra (unused) parameter makes it a function, which is generalizable.
let emptyList10 () = Array.create 10 []
```

### [snippet.0108.fs](snippet.0108.fs)
```
//let emptyset = Set.empty
// Adding a type parameter and type annotation lets you write a generic value.
let emptyset<'a when 'a : comparison> : Set<'a> = Set.empty
```

### [snippet.0201.fs](snippet.0201.fs)
```
let inline increment x = x + 1
type WrapInt32() =
    member inline this.incrementByOne(x) = x + 1
    static member inline Increment(x) = x + 1
```

### [snippet.0202.fs](snippet.0202.fs)
```
let inline printAsFloatingPoint number =
    printfn "%f" (float number)
```

### [snippet.0301.fs](snippet.0301.fs)
```
let f a b = a + b + 100
```

### [snippet.0302.fs](snippet.0302.fs)
```
// Type annotations on a parameter.
let addu1 (x : uint32) y =
    x + y

// Type annotations on an expression.
let addu2 x y =
    (x : uint32) + y
```

### [snippet.0303.fs](snippet.0303.fs)
```
let addu1 x y : uint32 =
   x + y
```

### [snippet.0304.fs](snippet.0304.fs)
```
let replace(str: string) =
    str.Replace("A", "a")
```

### [snippet.0305.fs](snippet.0305.fs)
```
let makeTuple a b = (a, b)
```

### [snippet.0401.fs](snippet.0401.fs)
```
let inline (+@) x y = x + x * y
// Call that uses int.
printfn "%d" (1 +@ 1)
// Call that uses float.
printfn "%f" (1.0 +@ 0.5)
```

### [snippet.0501.fs](snippet.0501.fs)
```
open Microsoft.FSharp.Quotations
// A typed code quotation.
let expr : Expr<int> = <@ 1 + 1 @>
// An untyped code quotation.
let expr2 : Expr = <@@ 1 + 1 @@>
```

### [snippet.0502.fs](snippet.0502.fs)
```
// Valid:
<@ let f x = x + 10 in f 20 @>
// Valid:
<@
    let f x = x + 10
    f 20
@>
```

### [snippet.0601.fs](snippet.0601.fs)
```
module Print
open Microsoft.FSharp.Quotations
open Microsoft.FSharp.Quotations.Patterns
open Microsoft.FSharp.Quotations.DerivedPatterns

let println expr =
    let rec print expr =
        match expr with
        | Application(expr1, expr2) ->
            // Function application.
            print expr1
            printf " "
            print expr2
        | SpecificCall <@@ (+) @@> (_, _, exprList) ->
            // Matches a call to (+). Must appear before Call pattern.
            print exprList.Head
            printf " + "
            print exprList.Tail.Head
        | Call(exprOpt, methodInfo, exprList) ->
            // Method or module function call.
            match exprOpt with
            | Some expr -> print expr
            | None -> printf "%s" methodInfo.DeclaringType.Name
            printf ".%s(" methodInfo.Name
            if (exprList.IsEmpty) then printf ")" else
            print exprList.Head
            for expr in exprList.Tail do
                printf ","
                print expr
            printf ")"
        | Int32(n) ->
            printf "%d" n
        | Lambda(param, body) ->
            // Lambda expression.
            printf "fun (%s:%s) -> " param.Name (param.Type.ToString())
            print body
        | Let(var, expr1, expr2) ->
            // Let binding.
            if (var.IsMutable) then
                printf "let mutable %s = " var.Name
            else
                printf "let %s = " var.Name
            print expr1
            printf " in "
            print expr2
        | PropertyGet(_, propOrValInfo, _) ->
            printf "%s" propOrValInfo.Name
        | String(str) ->
            printf "%s" str
        | Value(value, typ) ->
            printf "%s" (value.ToString())
        | Var(var) ->
            printf "%s" var.Name
        | _ -> printf "%s" (expr.ToString())
    print expr
    printfn ""


let a = 2

// exprLambda has type "(int -> int)".
let exprLambda = <@ fun x -> x + 1 @>
// exprCall has type unit.
let exprCall = <@ a + 1 @>

println exprLambda
println exprCall
println <@@ let f x = x + 10 in f 10 @@>
```

### [snippet.0701.fs](snippet.0701.fs)
```
module Module1
open Print
open Microsoft.FSharp.Quotations
open Microsoft.FSharp.Quotations.DerivedPatterns
open Microsoft.FSharp.Quotations.ExprShape

let add x y = x + y
let mul x y = x * y

let rec substituteExpr expression =
    match expression with
    | SpecificCall <@@ add @@> (_, _, exprList) ->
        let lhs = substituteExpr exprList.Head
        let rhs = substituteExpr exprList.Tail.Head
        <@@ mul %%lhs %%rhs @@>
    | ShapeVar var -> Expr.Var var
    | ShapeLambda (var, expr) -> Expr.Lambda (var, substituteExpr expr)
    | ShapeCombination(shapeComboObject, exprList) ->
        RebuildShapeCombination(shapeComboObject, List.map substituteExpr exprList)

let expr1 = <@@ 1 + (add 2 (add 3 4)) @@>
println expr1
let expr2 = substituteExpr expr1
println expr2
```

