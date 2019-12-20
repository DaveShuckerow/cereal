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

  final TypeChecker skipChecker = TypeChecker.any([
    TypeChecker.fromUrl('package:cereal/cereal.dart#SkipAnnotation'),
    TypeChecker.fromUrl('package:cereal/cereal.dart#skip'),
  ]);

  bool isSerializableField(FieldElement field) {
    return !field.isStatic &&
        !field.isPrivate &&
        !field.isSynthetic &&
        !skipChecker.hasAnnotationOf(field) &&
        !skipChecker.hasAnnotationOf(field.getter);
  }

  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    final buffer = StringBuffer();
    final structs = library.annotatedWith(checker);

    for (var struct in structs) {
      final element = struct.element;
      if (element is ClassElement) {
        assert(
            !element.hasNonFinalField, '${element.name} should be @immutable.');

        buffer.write(
          'extension \$${element.name} on ${element.name} {\n',
        );
        buffer.write('  Map<String, dynamic> toJson() { \n');
        buffer.write('    final __result = <String, dynamic>{};\n');
        for (var field in element.fields.where(isSerializableField)) {
          final value = serializerFor(field.type, field.name);
          buffer.write(
            "    if (${field.name} != null) __result['${field.name}'] = $value;\n",
          );
        }
        buffer.write('    return __result;\n');
        buffer.write('  }\n');
        buffer.write('}\n');

        assert(element.constructors.any((e) {
          return e.parameters.every((parameter) {
            return parameter.isNamed;
          });
        }));

        buffer.write('extension \$${element.name}\$Reviver on JsonCodec {\n');
        buffer.write(
            '  String encode${element.name}(${element.name} toEncode) =>\n');
        buffer.write('    encode(toEncode.toJson());\n');
        buffer.write(
            '  ${element.name} decode${element.name}(String input) =>\n');
        buffer.write('  to${element.name}(decode(input));\n');
        buffer
            .write('  ${element.name} to${element.name}(dynamic decoded) {\n');
        buffer.write('  final map = decoded;\n');
        for (var field in element.fields.where(isSerializableField)) {
          final deserializer = deserializerFor(
            field.type,
            "map['${field.name}']",
          );
          buffer.write(
              '    final ${field.type} ${field.name} = map["${field.name}"] == null ? null : $deserializer;\n');
        }
        buffer.write('    return ${element.name}(\n');
        for (var field in element.fields.where(isSerializableField)) {
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
      return '$value.toJson()';
    }
    if (type.isDartCoreList || type.isDartCoreSet) {
      final nextType = (type as InterfaceType).typeArguments.first;
      return '[for (var e in $value) ${serializerFor(nextType, 'e')}]';
    }
    if (type.isDartCoreMap) {
      final keyType = (type as InterfaceType).typeArguments.first;
      final valueType = (type as InterfaceType).typeArguments.last;
      // If the value is a Map<String, dynamic>, then we already have the correct type.
      if (keyType.isDartCoreString && valueType.isDynamic) {
        return value;
      }
      final serializedKey = serializerFor(keyType, 'entry.key');
      final serializedValue = serializerFor(valueType, 'entry.value');
      return '[for (var entry in $value.entries) {"key": $serializedKey, "value": $serializedValue}]';
    }
    return value;
  }

  String deserializerFor(DartType type, String value) {
    if (isCereal(type.element)) {
      return "to$type($value)";
    } else if (type.isDartCoreString) {
      return value;
    } else if (type.isDartCoreBool) {
      return "($value is bool || $value == null) ? $value : $value == 'true' || $value == 'True'";
    } else if (type.isDartCoreDouble) {
      return "($value is double || $value == null) ? $value : double.parse($value)";
    } else if (type.isDartCoreInt) {
      return "($value is int || $value == null) ? $value : int.parse($value)";
    } else if (type.isDartCoreNum) {
      return "($value is num || $value == null) ? $value : num.parse($value)";
    } else if (type.isDartCoreList || type.isDartCoreSet) {
      final nextType = (type as InterfaceType).typeArguments.first;
      final deserializer =
          '[for (var e in $value) ${deserializerFor(nextType, 'e')}]';
      if (type.isDartCoreSet) {
        return 'Set.from($deserializer)';
      }
      return deserializer;
    } else if (type.isDartCoreMap) {
      final keyType = (type as InterfaceType).typeArguments.first;
      final valueType = (type as InterfaceType).typeArguments.last;
      // If the value is a Map<String, dynamic>, then we already have the correct type.
      if (keyType.isDartCoreString && valueType.isDynamic) {
        return value;
      }
      // Else, the map is stored as a list of map entries that we need to convert back.
      final deserializedKey = deserializerFor(keyType, 'entry["key"]');
      final deserializedValue = deserializerFor(valueType, 'entry["value"]');
      return 'Map.fromEntries([for (var entry in $value) MapEntry($deserializedKey, $deserializedValue)])';
    } else if (type.isDynamic) {
      return value;
    }
    assert(false, 'unable to parse $value as a $type');
  }

  bool isCereal(Element element) => checker.hasAnnotationOf(element);
}
