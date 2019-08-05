import 'dart:convert';

import 'package:farmsmart_flutter/chat/model/form/form_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String formMockData =
      '{"uid": "18","title": "mock titl","subtitle": "mock sub","origin": '
      '"com.wearemobilefirst.wamfapp",'
      '"processMessage": "Creating account ...","processComplete": "Account created",'
      '"formResponse": {"type": "firebase.db","uri": "profiles/%UserID/","body": {"name": "%Nickname"}},'
      '"items": [{"text": "question mock","sentiment": "Positive"},'
      '{"text": "question 2 mock?","inputRequest": {"type": '
      '"com.wearemobilefirst.String","uri": "%Nickname","localStore": false,'
      '"inline": true,"title": "Nickname?","validationRegex": "^[a-zA-Z]+\$",'
      '"responseText": "My name is %Nickname","optional": false}}]}';

  group('Form ', () {
    var form = FormEntity.fromJson(jsonDecode(formMockData));

    test('fromJson() should parse json to the object correctly', () {
      expect(form.uid, "18");
      expect(form.title, 'mock titl');
      expect(form.subtitle, 'mock sub');
      expect(form.origin, 'com.wearemobilefirst.wamfapp');
      expect(form.formResponse.type, 'firebase.db');
      expect(form.processComplete, 'Account created');
      expect(form.processMessage, 'Creating account ...');
      expect(form.items.length, 2);
    });

    test('toJson() should parse the object to json correctly', () {
      var jsonMap = form.toJson();

      expect(jsonMap['uid'], form.uid);
      expect(jsonMap['title'], form.title);
      expect(jsonMap['subtitle'], form.subtitle);
      expect(jsonMap['formResponse'], form.formResponse);
      expect(jsonMap['processComplete'], form.processComplete);
      expect(jsonMap['processMessage'], form.processMessage);
      expect(jsonMap['items'], form.items);
    });
  });
}
