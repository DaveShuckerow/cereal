// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'flat_structure.dart';

// **************************************************************************
// CerealGenerator
// **************************************************************************

extension $FlatStructure on FlatStructure {
  Map<String, dynamic> toJson() {
    final __result = <String, dynamic>{};
    if (i != null) __result['i'] = i;
    if (d != null) __result['d'] = d;
    if (b != null) __result['b'] = b;
    if (n != null) __result['n'] = n;
    if (dyn != null) __result['dyn'] = dyn;
    if (str != null) __result['str'] = str;
    if (l != null) __result['l'] = [for (var e in l) e];
    if (s != null) __result['s'] = [for (var e in s) e];
    if (m != null)
      __result['m'] = [
        for (var entry in m.entries) {"key": entry.key, "value": entry.value}
      ];
    return __result;
  }
}

extension $FlatStructure$Reviver on JsonCodec {
  String encodeFlatStructure(FlatStructure) => encode(FlatStructure.toJson());
  FlatStructure decodeFlatStructure(String input) =>
      toFlatStructure(decode(input));
  FlatStructure toFlatStructure(dynamic decoded) {
    final map = decoded;
    final int i = map["i"] == null
        ? null
        : (map['i'] is int || map['i'] == null)
            ? map['i']
            : int.parse(map['i']);
    final double d = map["d"] == null
        ? null
        : (map['d'] is double || map['d'] == null)
            ? map['d']
            : double.parse(map['d']);
    final bool b = map["b"] == null
        ? null
        : (map['b'] is bool || map['b'] == null)
            ? map['b']
            : map['b'] == 'true' || map['b'] == 'True';
    final num n = map["n"] == null
        ? null
        : (map['n'] is num || map['n'] == null)
            ? map['n']
            : num.parse(map['n']);
    final dynamic dyn = map["dyn"] == null ? null : map['dyn'];
    final String str = map["str"] == null ? null : map['str'];
    final List<int> l = map["l"] == null
        ? null
        : [for (var e in map['l']) (e is int || e == null) ? e : int.parse(e)];
    final Set<double> s = map["s"] == null
        ? null
        : Set.from([
            for (var e in map['s'])
              (e is double || e == null) ? e : double.parse(e)
          ]);
    final Map<String, String> m = map["m"] == null
        ? null
        : Map.fromEntries([
            for (var entry in map['m']) MapEntry(entry["key"], entry["value"])
          ]);
    return FlatStructure(
      i: i,
      d: d,
      b: b,
      n: n,
      dyn: dyn,
      str: str,
      l: l,
      s: s,
      m: m,
    );
  }
}
