import 'dart:convert';

import 'package:cereal_example/src/flat_structure.dart';
import 'package:test/test.dart';

void main() {
  group('flat structure', () {
    test('serializes when empty', () {
      expect(FlatStructure().toJson(), {});
    });

    test('deserializes from empty', () {
      final decoded = json.decodeFlatStructure('{}');
      expectEqual(decoded, FlatStructure());
    });

    group('with primitive content', () {
      final structure = FlatStructure(
        b: true,
        i: 0,
        d: 0.0,
        str: 'string',
        n: 0,
      );
      final expectedJson = {
        'i': 0,
        'b': true,
        'd': 0.0,
        'str': 'string',
        'n': 0,
      };
      final serializedJson =
          '{"i": 0,"b": true,"d": 0.0,"str": "string","n": 0}';
      test('serializes', () {
        expect(structure.toJson(), expectedJson);
      });

      test('deserializes', () {
        final decoded = json.decodeFlatStructure(serializedJson);
        expectEqual(decoded, structure);
      });
    });

    group('with collection content', () {
      final structure = FlatStructure(
        l: [0, 1, 2],
        s: {3, 4, 5},
        m: {'a': 'b', 'c': 'd'},
      );
      final expectedJson = {
        'l': [0, 1, 2],
        's': [3.0, 4.0, 5.0],
        'm': [
          {'key': 'a', 'value': 'b'},
          {'key': 'c', 'value': 'd'},
        ],
      };
      final serializedJson =
          '{"l": [0,1,2], "s": [3.0,4.0,5.0], "m": [{"key": "a", "value": "b"}, {"key": "c", "value": "d"}]}';
      test('serializes', () {
        expect(structure.toJson(), expectedJson);
      });

      test('deserializes', () {
        final decoded = json.decodeFlatStructure(serializedJson);
        expectEqual(decoded, structure);
      });
    });

    group('with nulls in collections', () {
      final structure = FlatStructure(
        l: [0, null],
        s: {null},
        m: {'a': null, null: 'd'},
      );
      final expectedJson = {
        'l': [0, null],
        's': [null],
        'm': [
          {'key': 'a', 'value': null},
          {'key': null, 'value': 'd'},
        ],
      };
      final serializedJson =
          '{"l": [0,null], "s": [null], "m": [{"key": "a", "value": null}, {"key": null, "value": "d"}]}';
      test('serializes', () {
        expect(structure.toJson(), expectedJson);
      });

      test('deserializes', () {
        final decoded = json.decodeFlatStructure(serializedJson);
        expectEqual(decoded, structure);
      });
    });
  });
}

void expectEqual(FlatStructure actual, FlatStructure expected) {
  expect(actual.b, expected.b);
  expect(actual.i, expected.i);
  expect(actual.d, expected.d);
  expect(actual.n, expected.n);
  expect(actual.str, expected.str);
  expect(actual.m, expected.m);
  expect(
    (actual.s?.toList() ?? [])..sort(),
    (expected.s?.toList() ?? [])..sort(),
  );
  expect(actual.l, expected.l);
}
