import 'dart:convert';

import 'package:codegen/baz.dart';
import 'package:codegen/sample.dart';

void main() {
  print(Foo(
    bar: 0,
    baz: Baz(value: 'words'),
  ).toJson());
  print(json
      .decodeFoo('{"bar": "0","baz": {"value": "words"}}'.toString())
      .toJson());
}
