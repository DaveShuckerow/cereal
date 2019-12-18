import 'package:codegen/sample.dart';

void main() {
  print(Foo(0, 'words').toJson());
  print({'bar': '0', 'baz': 'words'}.toFoo().toJson());
}
