// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nested_structure.dart';

// **************************************************************************
// CerealGenerator
// **************************************************************************

extension $NestedStructure on NestedStructure {
  Map<String, dynamic> toJson() {
    final __result = <String, dynamic>{};
    if (child != null) __result['child'] = child.toJson();
    if (children != null)
      __result['children'] = [for (var e in children) e.toJson()];
    return __result;
  }
}

extension $NestedStructure$Reviver on JsonCodec {
  String encodeNestedStructure(NestedStructure) =>
      encode(NestedStructure.toJson());
  NestedStructure decodeNestedStructure(String input) =>
      toNestedStructure(decode(input));
  NestedStructure toNestedStructure(dynamic decoded) {
    final map = decoded;
    final FlatStructure child =
        map["child"] == null ? null : toFlatStructure(map['child']);
    final List<FlatStructure> children = map["children"] == null
        ? null
        : [for (var e in map['children']) toFlatStructure(e)];
    return NestedStructure(
      child: child,
      children: children,
    );
  }
}

extension $SuperNestedStructure on SuperNestedStructure {
  Map<String, dynamic> toJson() {
    final __result = <String, dynamic>{};
    if (listOfSet != null)
      __result['listOfSet'] = [
        for (var e in listOfSet) [for (var e in e) e]
      ];
    return __result;
  }
}

extension $SuperNestedStructure$Reviver on JsonCodec {
  String encodeSuperNestedStructure(SuperNestedStructure) =>
      encode(SuperNestedStructure.toJson());
  SuperNestedStructure decodeSuperNestedStructure(String input) =>
      toSuperNestedStructure(decode(input));
  SuperNestedStructure toSuperNestedStructure(dynamic decoded) {
    final map = decoded;
    final List<Set<int>> listOfSet = map["listOfSet"] == null
        ? null
        : [
            for (var e in map['listOfSet'])
              Set.from(
                  [for (var e in e) (e is int || e == null) ? e : int.parse(e)])
          ];
    return SuperNestedStructure(
      listOfSet: listOfSet,
    );
  }
}
