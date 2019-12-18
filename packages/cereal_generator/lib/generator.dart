import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

Builder buildCereal(BuilderOptions options) =>
    SharedPartBuilder([CerealGenerator()], 'cereal');

class CerealGenerator extends Generator {
  final TypeChecker checker = TypeChecker.any([
    TypeChecker.fromUrl('package:cereal/cereal.dart#CerealAnnotation'),
    TypeChecker.fromUrl('package:cereal/cereal.dart#cereal'),
  ]);
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    final buffer = StringBuffer();
    final structs = library.annotatedWith(checker);
    print('Checking $library for @struct annotations');
    print(structs);

    for (var struct in structs) {
      final element = struct.element;
      if (element is ClassElement) {
        assert(
            !element.hasNonFinalField, '${element.name} should be @immutable.');

        buffer.write(
          'extension \$${element.name} on ${element.name} {\n',
        );
        buffer.write('  String toJson() => \n');
        buffer.write('    {\n');
        for (var field in element.fields) {
          String value = '\$${field.name}';
          if (checker.hasAnnotationOf(field.type.element)) {
            value = '\${${field.name}.toJson()}';
          }
          buffer.write("      '${field.name}': '$value',\n");
        }
        buffer.write('    }.toString();\n');
        buffer.write('}\n');

        assert(element.constructors.any((e) {
          return e.parameters.every((parameter) {
            return parameter.isNamed;
          });
        }));

        buffer.write('extension \$${element.name}\$Reviver on String {\n');
        buffer.write('  ${element.name} to${element.name}() {\n');
        buffer.write('    ${element.name()}')
        buffer.write('  }\n');
        buffer.write('}\n');
      } else {
        assert(false, 'Only classes can be annotated @struct');
      }
    }
    return buffer.toString();
  }

  String deserializerFor(FieldElement field) {
    if (checker.hasAnnotationOf(field.type.element)) {
      return 'json'
    }
  }
}
