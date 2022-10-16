### [snippet.6601.fs](snippet.6601.fs)
```
// In the file program.fs.
let x = 40
```

### [snippet.6602.fs](snippet.6602.fs)
```
module Program
let x = 40
```

### [snippet.6603.fs](snippet.6603.fs)
```
// In the file multiplemodules.fs.
// MyModule1
module MyModule1 =
    // Indent all program elements within modules that are declared with an equal sign.
    let module1Value = 100

    let module1Function x =
        x + 10

// MyModule2
module MyModule2 =

    let module2Value = 121

    // Use a qualified name to access the function.
    // from MyModule1.
    let module2Function x =
        x * (MyModule1.module1Function module2Value)
```

### [snippet.6604.fs](snippet.6604.fs)
```
module Arithmetic

let add x y =
    x + y

let sub x y =
    x - y
```

### [snippet.6605.fs](snippet.6605.fs)
```
// Fully qualify the function name.
let result1 = Arithmetic.add 5 9
// Open the module.
open Arithmetic
let result2 = add 5 9
```

### [snippet.6607.fs](snippet.6607.fs)
```
module Y =
    let x = 1

    module Z =
        let z = 5
```

### [snippet.6608.fs](snippet.6608.fs)
```
module Y =
    let x = 1

module Z =
    let z = 5
```

### [snippet.6609.fs](snippet.6609.fs)
```
module Y =
        let x = 1

    module Z =
        let z = 5
```

### [snippet.6610.fs](snippet.6610.fs)
```
// This code produces a warning, but treats Z as a inner module.
module Y =
module Z =
    let z = 5
```

### [snippet.6611.fs](snippet.6611.fs)
```
module Y =
    module Z =
        let z = 5
```

### [snippet.6612.fs](snippet.6612.fs)
```
// The top-level module declaration can be omitted if the file is named
// TopLevel.fs or topLevel.fs, and the file is the only file in an
// application.
module TopLevel

let topLevelX = 5

module Inner1 =
    let inner1X = 1
module Inner2 =
    let inner2X = 5
```

