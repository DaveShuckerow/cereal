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

## Adding to your project

To add Cereal to your project, change your pubspec.yaml like so:

```yaml
# You need at least Dart 2.6.0, which launched extension methods.
environment:
  sdk: '>=2.6.0 <3.0.0'

dependencies:
  # Depend on some version of cereal.
  cereal: ^0.0.2

dev_dependencies:
  # Depend on some version of cereal_generator
  cereal_generator: ^0.0.2
  # build_runner will run the code generator.
  build_runner: ^1.0.0
```

From there, you can run `pub get` or `flutter pub get` and start annotating data classes as `@cereal`.

To generate the json serializers, run the following:

```
pub run build_runner build
```
or
```
flutter pub run build_runner build
```