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

extension $Baz$Reviver on Map<String, dynamic> {
  Baz toBaz() {
    final String value = this['value'];
    return Baz(
      value: value,
    );
  }
}
