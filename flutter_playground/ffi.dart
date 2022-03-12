import 'dart:ffi';
import 'dart:io';
import 'package:path/path.dart' as p;

var libraryPath = p.join(Directory.current.path, 'libbar.dylib');
typedef TenNative = Int32 Function();
typedef TenFunc = int Function();


void main() {
  print(libraryPath);
  final dylib = DynamicLibrary.open(libraryPath);
  final TenFunc _ten = dylib.lookupFunction<TenNative, TenFunc>("ten");
  print(_ten.call());
}
