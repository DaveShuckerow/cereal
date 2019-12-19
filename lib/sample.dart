import 'package:cereal/cereal.dart';
import 'package:meta/meta.dart';

import 'baz.dart';

part 'sample.g.dart';

@cereal
@immutable
class Foo {
  final int bar;
  final Set<Baz> bazes;
  final Map<double, Bop> doubleToBop;
  final List<String> names;

  Foo({this.bar, this.bazes, this.doubleToBop, this.names});
}
