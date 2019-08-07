import 'dart:convert';

import 'package:farmsmart_flutter/chat/model/form/form_item_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String formItemMockData =
      '{"text": "Will users create a profile?", "sender":"sender test",'
      '"sentiment":"happy","inputRequest": '
      '{"type": "com.wearemobilefirst.MultiChoice","uri": "%WillUsersCreateProfile",'
      '"inline": true,"localStore": false,"responseText": "","optional": false,'
      '"args": {"maxSelection": 1,"options": [{"id": "OptionKey1","title": "Yes",'
      '"description": "","responseText": "Yes"},{"id": "OptionKey2","title": "No",'
      '"description": "","responseText": "No"}]}},'
      '"media":{"uri":"media uri test", "mimeType":"mimeType test"},'
      '"senderMedia":{"uri":"sender media uri test", "mimeType":"sender mimeType test"}}';

  group('FormItem', (){
    var formItem = FormItemEntity.fromJson(jsonDecode(formItemMockData));

    test('fromJson() should parse json to the object correctly', () {


      expect(formItem.text, 'Will users create a profile?');
      expect(formItem.sender, 'sender test');
      expect(formItem.sentiment, 'happy');
      expect(formItem.inputRequest.type, 'com.wearemobilefirst.MultiChoice');
      expect(formItem.inputRequest.uri, '%WillUsersCreateProfile');
      expect(formItem.inputRequest.title, null);
      expect(formItem.inputRequest.optional, false);
      expect(formItem.inputRequest.responseText, '');
      expect(formItem.inputRequest.localStore, false);
      expect(formItem.inputRequest.inline, true);
      expect(formItem.inputRequest.args.options[0].id, 'OptionKey1');
      expect(formItem.inputRequest.args.options[0].title, 'Yes');
      expect(formItem.inputRequest.args.options[0].description, '');
      expect(formItem.inputRequest.args.options[0].responseText, 'Yes');
      expect(formItem.media.uri, 'media uri test');
      expect(formItem.media.mimeType, 'mimeType test');
      expect(formItem.senderMedia.uri, 'sender media uri test');
      expect(formItem.senderMedia.mimeType, 'sender mimeType test');

    });

    
    
    
    test('toJson() should parse the object to json correctly', () {
      var jsonMap = formItem.toJson();

      expect(jsonMap['text'], formItem.text);
      expect(jsonMap['media'], formItem.media);
      expect(jsonMap['inputRequest'], formItem.inputRequest);
      expect(jsonMap['sentiment'], formItem.sentiment);
      expect(jsonMap['sender'], formItem.sender);
      expect(jsonMap['senderMedia'], formItem.senderMedia);
    });
  });
}
