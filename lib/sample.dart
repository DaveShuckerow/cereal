import 'package:cereal/cereal.dart';
import 'package:meta/meta.dart';

import 'baz.dart';

part 'sample.g.dart';

@cereal
@immutable
class Foo {
  final int bar;
  final List<Baz> bazes;
  final List<String> names;

  Foo({this.bar, this.bazes, this.names});
}
