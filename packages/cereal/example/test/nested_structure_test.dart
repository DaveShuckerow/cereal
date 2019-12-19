import 'dart:convert';

import 'package:cereal_example/src/flat_structure.dart';
import 'package:cereal_example/src/nested_structure.dart';
import 'package:test/test.dart';

void main() {
  group('nested structure', () {
    test('serializes when empty', () {
      expect(NestedStructure().toJson(), {});
    });

    test('deserializes from empty', () {
      final decoded = json.decodeNestedStructure('{}');
      expectEqual(decoded, NestedStructure());
    });

    group('with child', () {
      final structure = NestedStructure(
        child: FlatStructure(
          b: true,
          i: 0,
          d: 0.0,
          str: 'string',
          n: 0,
        ),
      );
      final expectedJson = {
        'child': {
          'i': 0,
          'b': true,
          'd': 0.0,
          'str': 'string',
          'n': 0,
        },
      };
      final serializedJson =
          '{"child": {"i": 0,"b": true,"d": 0.0,"str": "string","n": 0}}';
      test('serializes', () {
        expect(structure.toJson(), expectedJson);
      });

      test('deserializes', () {
        final decoded = json.decodeNestedStructure(serializedJson);
        expectEqual(decoded, structure);
      });
    });

    group('with children', () {
      final structure = NestedStructure(
        children: [
          FlatStructure(
            b: true,
            i: 0,
            d: 0.0,
            str: 'string',
            n: 0,
          ),
          FlatStructure(
            l: [0, null],
            s: {null},
            m: {'a': null, null: 'd'},
          ),
        ],
      );
      final expectedJson = {
        'children': [
          {
            'i': 0,
            'b': true,
            'd': 0.0,
            'str': 'string',
            'n': 0,
          },
          {
            'l': [0, null],
            's': [null],
            'm': [
              {'key': 'a', 'value': null},
              {'key': null, 'value': 'd'},
            ],
          },
        ],
      };
      final serializedJson = '{"children": ['
          '{"i": 0,"b": true,"d": 0.0,"str": "string","n": 0},'
          '{"l": [0,null], "s": [null], "m": [{"key": "a", "value": null}, {"key": null, "value": "d"}]}'
          ']}';
      test('serializes', () {
        expect(structure.toJson(), expectedJson);
      });

      test('deserializes', () {
        final decoded = json.decodeNestedStructure(serializedJson);
        expectEqual(decoded, structure);
      });
    });
  });

  group('super nested structure', () {
    test('serializes when empty', () {
      expect(SuperNestedStructure().toJson(), {});
    });

    test('deserializes from empty', () {
      final decoded = json.decodeSuperNestedStructure('{}');
      expectSuperNestedEqual(decoded, SuperNestedStructure());
    });

    group('with list of set', () {
      final structure = SuperNestedStructure(listOfSet: [
        {1, 2},
        {3},
      ]);
      final expectedJson = {
        'listOfSet': [
          [1, 2],
          [3],
        ],
      };
      final serializedJson = '{"listOfSet": [[1,2],[3]]}';
      test('serializes', () {
        expect(structure.toJson(), expectedJson);
      });

      test('deserializes', () {
        final decoded = json.decodeSuperNestedStructure(serializedJson);
        expectSuperNestedEqual(decoded, structure);
      });
    });
  });
}

void expectSuperNestedEqual(
  SuperNestedStructure actual,
  SuperNestedStructure expected,
) {
  if (actual == null) {
    expect(actual, expected);
    return;
  }

  expect(actual.listOfSet, expected.listOfSet);
}

void expectEqual(NestedStructure actual, NestedStructure expected) {
  if (actual == null) {
    expect(actual, expected);
    return;
  }
  expectFlatStructureEqual(actual.child, expected.child);

  if (actual.children == null) {
    expect(actual.children, expected.children);
    return;
  }
  expect(actual.children.length, expected.children.length);
  for (var i = 0; i < actual.children.length; i++) {
    expectFlatStructureEqual(actual.children[i], expected.children[i]);
  }
}

void expectFlatStructureEqual(FlatStructure actual, FlatStructure expected) {
  if (actual == null) {
    expect(actual, expected);
    return;
  }
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
