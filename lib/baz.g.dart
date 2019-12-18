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
  Baz decodeBaz(String input) {
    final map = this.decode(input);
    final String value = map['value'];
    return Baz(
      value: value,
    );
  }
}
