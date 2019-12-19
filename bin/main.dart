import 'dart:convert';

import 'package:codegen/baz.dart';
import 'package:codegen/sample.dart';

void main() {
  print(
    json.encode(
      Foo(
        bar: 0,
        bazes: {Baz(value: 'words')},
        names: ['words1', 'words2'],
      ).toJson(),
    ),
  );
  final encoded =
      '{"bar": "0","bazes": [{"value": "words"}, {"value": "baz#2"}],"names": ["words1", "words2"]}';
  print(json.decodeFoo(encoded).toJson());
}
