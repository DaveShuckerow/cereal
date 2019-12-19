// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sample.dart';

// **************************************************************************
// CerealGenerator
// **************************************************************************

extension $Foo on Foo {
  Map<String, dynamic> toJson() {
    final __result = <String, dynamic>{};
    if (bar != null) __result['bar'] = bar;
    if (bazes != null) __result['bazes'] = [for (var e in bazes) e.toJson()];
    if (doubleToBop != null)
      __result['doubleToBop'] = [
        for (var entry in doubleToBop.entries)
          {"key": entry.key, "value": entry.value.toJson()}
      ];
    if (names != null) __result['names'] = [for (var e in names) e];
    return __result;
  }
}

extension $Foo$Reviver on JsonCodec {
  Foo decodeFoo(String input) => toFoo(this.decode(input));
  Foo toFoo(dynamic decoded) {
    final map = decoded;
    final int bar = map["bar"] == null
        ? null
        : (map['bar'] is int) ? map['bar'] : int.parse(map['bar']);
    final Set<Baz> bazes = map["bazes"] == null
        ? null
        : Set.from([for (var e in map['bazes']) toBaz(e)]);
    final Map<double, Bop> doubleToBop = map["doubleToBop"] == null
        ? null
        : Map.fromEntries([
            for (var entry in map['doubleToBop'])
              MapEntry(
                  (entry["key"] is double)
                      ? entry["key"]
                      : double.parse(entry["key"]),
                  toBop(entry["value"]))
          ]);
    final List<String> names =
        map["names"] == null ? null : [for (var e in map['names']) e];
    return Foo(
      bar: bar,
      bazes: bazes,
      doubleToBop: doubleToBop,
      names: names,
    );
  }
}
