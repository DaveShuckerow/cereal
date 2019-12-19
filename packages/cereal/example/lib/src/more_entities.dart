import 'package:cereal/cereal.dart';
import 'package:meta/meta.dart';

part 'more_entities.g.dart';

@cereal
@immutable
class Baz {
  final String value;
  final Map<String, dynamic> extraStuff;

  Baz({this.value, this.extraStuff});
}

@cereal
@immutable
class Bop {
  final Map<String, int> numberOfPeopleWithName;

  Bop({this.numberOfPeopleWithName});
}
