import 'dart:async';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/type.dart';
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
          final value = serializerFor(field.type, field.name);
          buffer.write("      '${field.name}': $value,\n");
        }
        buffer.write('    }.toString();\n');
        buffer.write('}\n');

        assert(element.constructors.any((e) {
          return e.parameters.every((parameter) {
            return parameter.isNamed;
          });
        }));

        buffer.write('extension \$${element.name}\$Reviver on JsonCodec {\n');
        buffer.write(
            '  ${element.name} decode${element.name}(String input) =>\n');
        buffer.write('  to${element.name}(this.decode(input));\n');
        buffer
            .write('  ${element.name} to${element.name}(dynamic decoded) {\n');
        buffer.write('  final map = decoded;\n');
        for (var field in element.fields) {
          final deserializer = deserializerFor(
            field.type,
            "map['${field.name}']",
          );
          buffer.write(
              '    final ${field.type} ${field.name} = $deserializer;\n');
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

  String serializerFor(DartType type, String value) {
    if (isCereal(type.element)) {
      return "'\${$value.toJson()}'";
    }
    if (type.isDartCoreList) {
      final nextType = (type as InterfaceType).typeArguments.first;
      return '[for (var e in $value) ${serializerFor(nextType, 'e')}]';
    }
    return "'\$$value'";
  }

  String deserializerFor(DartType type, String value) {
    if (isCereal(type.element)) {
      return "to$type($value)";
    } else if (type.isDartCoreString) {
      return "$value";
    } else if (type.isDartCoreBool) {
      return "$value == 'true' || $value == 'True'";
    } else if (type.isDartCoreDouble) {
      return "double.parse($value)";
    } else if (type.isDartCoreInt) {
      return "int.parse($value)";
    } else if (type.isDartCoreNum) {
      "num.parse($value)";
    } else if (type.isDartCoreList) {
      final nextType = (type as InterfaceType).typeArguments.first;
      return '[for (var e in $value) ${deserializerFor(nextType, 'e')}]';
    }
    assert(false, 'unable to parse $value as a $type');
  }

  bool isCereal(Element element) => checker.hasAnnotationOf(element);
}
