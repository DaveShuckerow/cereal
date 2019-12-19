export 'dart:convert' show JsonCodec, json;

/// Annotation that describes a class as being serializable.
///
/// All files that use this annotation should include a `part` directive
/// at the top of the file after the imports:
///
/// ```dart
/// import 'package:cereal/cereal.dart';
///
/// part 'file_name.g.dart';
///
/// @cereal
/// class Serialized {
///   ...
/// }
/// ```
///
/// For a class named `Serialized` annoated with @cereal, a
/// `Serialized.toJson()` extension method will be generated to make it easy
/// to encode to json. An extension method `decodeSerialized()` will also be
/// generated on [JsonCodec] and [JsonCodec] instances.
///
/// NOTE: A class annoated with `@cereal` must obey the following restrictions:
///
///  * All fields should be public and final.
///  * It should have an unnamed constructor that takes all fields as
///    named parameters.
const cereal = CerealAnnotation();

/// The backing class for [cereal].
///
/// Do not use directly.
class CerealAnnotation {
  const CerealAnnotation();
}

/// Annotation that marks a field to be skipped by serialization.
const skip = SkipAnnotation();

/// The backing class for [skip].
///
/// Do not use directly.
class SkipAnnotation {
  const SkipAnnotation();
}
