// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baz.dart';

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
  Baz decodeBaz(String input) => toBaz(this.decode(input));
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
  Bop decodeBop(String input) => toBop(this.decode(input));
  Bop toBop(dynamic decoded) {
    final map = decoded;
    final Map<String, int> numberOfPeopleWithName =
        map["numberOfPeopleWithName"] == null
            ? null
            : Map.fromEntries([
                for (var entry in map['numberOfPeopleWithName'])
                  MapEntry(
                      entry["key"],
                      (entry["value"] is int)
                          ? entry["value"]
                          : int.parse(entry["value"]))
              ]);
    return Bop(
      numberOfPeopleWithName: numberOfPeopleWithName,
    );
  }
}
