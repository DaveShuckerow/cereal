// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample.dart';

// **************************************************************************
// CerealGenerator
// **************************************************************************

extension $Foo on Foo {
  String toJson() => {
        'bar': '$bar',
        'bazes': [for (var e in bazes) '${e.toJson()}'],
        'names': [for (var e in names) '$e'],
      }.toString();
}

extension $Foo$Reviver on JsonCodec {
  Foo decodeFoo(String input) => toFoo(this.decode(input));
  Foo toFoo(dynamic decoded) {
    final map = decoded;
    final int bar = int.parse(map['bar']);
    final List<Baz> bazes = [for (var e in map['bazes']) toBaz(e)];
    final List<String> names = [for (var e in map['names']) e];
    return Foo(
      bar: bar,
      bazes: bazes,
      names: names,
    );
  }
}
