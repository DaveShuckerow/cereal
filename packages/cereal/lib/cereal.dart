import 'package:meta/meta.dart';

export 'dart:convert' show jsonDecode, jsonEncode;

const cereal = CerealAnnotation();

@immutable
class CerealAnnotation extends Immutable {
  const CerealAnnotation();
}
