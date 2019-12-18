import 'dart:convert';

import 'package:codegen/baz.dart';
import 'package:codegen/sample.dart';

void main() {
  print(Foo(
    bar: 0,
    bazes: [Baz(value: 'words')],
    names: ['words1', 'words2'],
  ).toJson());
  print(json
      .decodeFoo(
          '{"bar": "0","bazes": [{"value": "words"}],"names": ["words1", "words2"]}'
              .toString())
      .toJson());
}
