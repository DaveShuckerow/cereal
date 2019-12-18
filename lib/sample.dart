import 'package:cereal/cereal.dart';
import 'package:meta/meta.dart';

import 'baz.dart';

part 'sample.g.dart';

@cereal
@immutable
class Foo {
  final int bar;
  final Baz baz;

  Foo(this.bar, this.baz);
}
