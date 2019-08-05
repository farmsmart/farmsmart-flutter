import 'dart:convert';

import 'package:farmsmart_flutter/chat/model/form/input_request_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String inputRequestDataMock = '{"type": "com.wearemobilefirst.MultiChoice",'
      '"uri": "%WillUsersCreateProfile","inline": true,"localStore": false,'
      '"title": "title test", "validationRegex": "^[a-zA-Z]+\$",'
      '"responseText": "None","optional": false,"args": {"maxSelection": 1,'
      '"options": [{"id": "OptionKey1","title": "Yes","description": "",'
      '"responseText": "Yes"},{"id": "OptionKey2",'
      '"title": "No","description": "","responseText": "No"}]}}';

  group('InputRequest', () {
    var inputRequest = InputRequestEntity.fromJson(jsonDecode(inputRequestDataMock));

    test('fromJson() should parse json to the object correctly', () {
      expect(inputRequest.type, 'com.wearemobilefirst.MultiChoice');
      expect(inputRequest.uri, '%WillUsersCreateProfile');
      expect(inputRequest.localStore, false);
      expect(inputRequest.inline, true);
      expect(inputRequest.title, 'title test');
      expect(inputRequest.validationRegex, '^[a-zA-Z]+\$');
      expect(inputRequest.responseText, 'None');
      expect(inputRequest.optional, false);
      expect(inputRequest.args.maxSelection, 1);

      var options = inputRequest.args.options;

      expect(options.isNotEmpty, true);
      expect(options.first.id, 'OptionKey1');
      expect(options.first.title, 'Yes');
      expect(options.first.description, '');
      expect(options.first.responseText, 'Yes');

      expect(options[1].id, 'OptionKey2');
      expect(options[1].title, 'No');
      expect(options[1].description, '');
      expect(options[1].responseText, 'No');
    });

    test('toJson() should parse the object to json correctly', () {
      var jsonMap = inputRequest.toJson();

      expect(jsonMap['type'], 'com.wearemobilefirst.MultiChoice');
      expect(jsonMap['uri'], '%WillUsersCreateProfile');
      expect(jsonMap['title'], 'title test');
      expect(jsonMap['responseText'], 'None');
      expect(jsonMap['localStore'], false);
      expect(jsonMap['inline'], true);
      expect(jsonMap['validationRegex'], '^[a-zA-Z]+\$');
      expect(jsonMap['optional'], false);
      expect(jsonMap['args'], inputRequest.args);
    });
  });
}
