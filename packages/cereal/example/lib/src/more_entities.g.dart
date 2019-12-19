// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'more_entities.dart';

// **************************************************************************
// CerealGenerator
// **************************************************************************

extension $Baz on Baz {
  Map<String, dynamic> toJson() {
    final __result = <String, dynamic>{};
    if (value != null) __result['value'] = value;
    if (extraStuff != null) __result['extraStuff'] = extraStuff;
    return __result;
  }
}

extension $Baz$Reviver on JsonCodec {
  String encodeBaz(Baz) => encode(Baz.toJson());
  Baz decodeBaz(String input) => toBaz(decode(input));
  Baz toBaz(dynamic decoded) {
    final map = decoded;
    final String value = map["value"] == null ? null : map['value'];
    final Map<String, dynamic> extraStuff =
        map["extraStuff"] == null ? null : map['extraStuff'];
    return Baz(
      value: value,
      extraStuff: extraStuff,
    );
  }
}

extension $Bop on Bop {
  Map<String, dynamic> toJson() {
    final __result = <String, dynamic>{};
    if (numberOfPeopleWithName != null)
      __result['numberOfPeopleWithName'] = [
        for (var entry in numberOfPeopleWithName.entries)
          {"key": entry.key, "value": entry.value}
      ];
    return __result;
  }
}

extension $Bop$Reviver on JsonCodec {
  String encodeBop(Bop) => encode(Bop.toJson());
  Bop decodeBop(String input) => toBop(decode(input));
  Bop toBop(dynamic decoded) {
    final map = decoded;
    final Map<String, int> numberOfPeopleWithName =
        map["numberOfPeopleWithName"] == null
            ? null
            : Map.fromEntries([
                for (var entry in map['numberOfPeopleWithName'])
                  MapEntry(
                      entry["key"],
                      (entry["value"] is int || entry["value"] == null)
                          ? entry["value"]
                          : int.parse(entry["value"]))
              ]);
    return Bop(
      numberOfPeopleWithName: numberOfPeopleWithName,
    );
  }
}
