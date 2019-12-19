# Cereal, a serialization library for Dart

Cereal offers no-boilerplate JSON serialization for Dart objects.
It does this with Dart's new extension methods & code generation.

## Example

```dart
import 'package:cereal/cereal.dart';

part 'my_file.g.dart';

@cereal
class Struct {
    final int foo;
    final String bar;

    Struct({this.foo, this.bar});
}
```

The code generator will generate a `Struct.toJson`, as well as a
`json.decodeStruct` method on the `json` object in `dart:convert`.

```dart
import 'dart:convert';

void main() {
    json.encode(
        Struct(
            foo: 0, 
            bar: 'hello world',
        ).toJson());

    final struct = json.decodeStruct(
        '{"foo": 0, "bar": "hello world"}',
    );
}
```
