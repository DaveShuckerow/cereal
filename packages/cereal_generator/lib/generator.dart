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
          if (isCereal(field)) {
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

        buffer.write('extension \$${element.name}\$Reviver on JsonCodec {\n');
        buffer
            .write('  ${element.name} decode${element.name}(String input) {\n');
        buffer.write('  final map = this.decode(input);\n');

        for (var field in element.fields) {
          if (isCereal(field)) {
            buffer.write(
              "    final ${field.type} ${field.name} = "
              "decode${field.type}(map['${field.name}'].toString());\n",
            );
          } else if (field.type.isDartCoreString) {
            buffer.write(
                "    final ${field.type} ${field.name} = map['${field.name}'];\n");
          } else if (field.type.isDartCoreBool) {
            buffer.write(
              "    final ${field.type} ${field.name} = "
              "this['${field.name}'] == 'true' || map['${field.name}'] == 'True';\n",
            );
          } else if (field.type.isDartCoreDouble) {
            buffer.write(
              "    final ${field.type} ${field.name} = double.parse(map['${field.name}']);\n",
            );
          } else if (field.type.isDartCoreInt) {
            buffer.write(
              "    final ${field.type} ${field.name} = int.parse(map['${field.name}']);\n",
            );
          } else if (field.type.isDartCoreNum) {
            buffer.write(
              "    final ${field.type} ${field.name} = num.parse(map['${field.name}']);\n",
            );
          }
        }
        buffer.write('    return ${element.name}(\n');
        for (var field in element.fields) {
          buffer.write("      ${field.name}: ${field.name},\n");
        }
        buffer.write('    );\n');
        buffer.write('  }\n');
        buffer.write('}\n');
      } else {
        assert(false, 'Only classes can be annotated @struct');
      }
    }
    return buffer.toString();
  }

  bool isCereal(FieldElement field) =>
      checker.hasAnnotationOf(field.type.element);
}
