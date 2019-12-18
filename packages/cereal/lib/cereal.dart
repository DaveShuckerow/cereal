import 'package:meta/meta.dart';

export 'dart:convert' show JsonCodec, json;

const cereal = CerealAnnotation();

@immutable
class CerealAnnotation extends Immutable {
  const CerealAnnotation();
}
