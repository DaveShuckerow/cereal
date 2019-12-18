import 'package:cereal/cereal.dart';
import 'package:meta/meta.dart';

part 'baz.g.dart';

@cereal
@immutable
class Baz {
  final String value;

  Baz(this.value);
}
