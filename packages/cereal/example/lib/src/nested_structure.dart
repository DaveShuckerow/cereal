import 'package:cereal/cereal.dart';

import 'flat_structure.dart';

part 'nested_structure.g.dart';

@cereal
class NestedStructure {
  final FlatStructure child;
  final List<FlatStructure> children;

  NestedStructure({this.child, this.children});
}

@cereal
class SuperNestedStructure {
  final List<Set<int>> listOfSet;

  SuperNestedStructure({this.listOfSet});
}
