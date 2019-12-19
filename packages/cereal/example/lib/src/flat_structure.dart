import 'package:cereal/cereal.dart';
import 'package:meta/meta.dart';

part 'flat_structure.g.dart';

@cereal
@immutable
class FlatStructure {
  final int i;
  final double d;
  final bool b;
  final num n;
  final dynamic dyn;
  final String str;
  final List<int> l;
  final Set<double> s;
  final Map<String, String> m;

  FlatStructure({
    this.i,
    this.d,
    this.b,
    this.n,
    this.dyn,
    this.str,
    this.l,
    this.s,
    this.m,
  });
}
