import 'dart:convert';

import 'package:cereal_example/more_entities.dart';
import 'package:cereal_example/sample.dart';

void main() {
  final unencodedJson = Foo(
    bar: 0,
    bazes: {
      Baz(
        value: 'words',
        extraStuff: {
          'key': 'value',
          'typed': 20.0,
        },
      )
    },
    doubleToBop: {
      0.0: Bop(
        numberOfPeopleWithName: {'Bob': 5, 'Yuqian': 20},
      ),
      0.5: Bop(
        numberOfPeopleWithName: {'Bob': 20, 'Yuqian': 5},
      ),
    },
    names: ['words1', 'words2'],
  ).toJson();

  print(
    JsonEncoder.withIndent('  ').convert(unencodedJson),
  );
  final encoded = '''
{
  "bar": 0,
  "bazes": [
    {
      "value": "words"
    }
  ],
  "doubleToBop": [
    {
      "key": 0.0,
      "value": {
        "numberOfPeopleWithName": [
          {
            "key": "Bob",
            "value": 5
          },
          {
            "key": "Yuqian",
            "value": 20
          }
        ]
      }
    },
    {
      "key": 0.5,
      "value": {
        "numberOfPeopleWithName": [
          {
            "key": "Bob",
            "value": 20
          },
          {
            "key": "Yuqian",
            "value": 5
          }
        ]
      }
    }
  ],
  "names": [
    "words1",
    "words2"
  ]
}
''';

  print(json.decodeFoo(encoded).toJson());
}
