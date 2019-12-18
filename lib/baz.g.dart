// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'baz.dart';

// **************************************************************************
// CerealGenerator
// **************************************************************************

extension $Baz on Baz {
  String toJson() => {
        'value': '$value',
      }.toString();
}

extension $Baz$Reviver on JsonCodec {
  Baz decodeBaz(String input) => toBaz(this.decode(input));
  Baz toBaz(dynamic decoded) {
    final map = decoded;
    final String value = map['value'];
    return Baz(
      value: value,
    );
  }
}
