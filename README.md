# ffi_prac
How to use ffi(foreign function interface) C -> Dart 

There are multiple ways(FFI) to get it done, but from this post, I will show you two possible ways.

## 1. Convert `.a`(a file contains a library of functions and headers that may be referenced by a C/C++ source file.) to `.dylib` 

```bash
# create .o from .c
gcc 'fileName'.c -o 'fileName'

ar rcs 'fileName'.a 'fileName'.o
clang -fpic -shared -Wl,-all_load ten.a -o libbar.dylib 

source: https://stackoverflow.com/questions/25321911/convert-a-to-dylib-in-mac-osx
```
## 2.  Create `dylib` using `CMake`


https://medium.com/flutter-community/flutterdesktop-and-c-7cd2e0106bd8

first ^ install all the dependencies and follow all the steps. This document is easy to read. So, I will skip the explanation.
```py
cmake 
.make
```

## After you done creating `dylib`. 

This is a code snippet how to call from Dart.

```dart
import 'dart:ffi';
import 'dart:io';
import 'package:path/path.dart' as p;

var libraryPath = p.join(Directory.current.path, 'libbar.dylib');
typedef TenNative = Int32 Function();
typedef TenFunc = int Function();


void main() {
  final dylib = DynamicLibrary.open(libraryPath);
  final TenFunc _ten = dylib.lookupFunction<TenNative, TenFunc>("ten");
  print(_ten.call());
}

```

ten.c
```c
#include "ten.h"

int ten()
{
    return 10;
}
```
