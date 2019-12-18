// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample.dart';

// **************************************************************************
// CerealGenerator
// **************************************************************************

extension $Foo on Foo {
  String toJson() => {
        'bar': '$bar',
        'baz': '${baz.toJson()}',
      }.toString();
}

extension $Foo$Reviver on JsonCodec {
  Foo decodeFoo(String input) {
    final map = this.decode(input);
    final int bar = int.parse(map['bar']);
    final Baz baz = decodeBaz(map['baz'].toString());
    return Foo(
      bar: bar,
      baz: baz,
    );
  }
}
