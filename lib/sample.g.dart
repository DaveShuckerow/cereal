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

extension $Foo$Reviver on Map<String, dynamic> {
  Foo toFoo() {
    final int bar = int.parse(this['bar']);
    final Baz baz = (this['baz'] as Map<String, dynamic>).toBaz();
    return Foo(
      bar: bar,
      baz: baz,
    );
  }
}
