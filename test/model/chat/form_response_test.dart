import 'dart:convert';

import 'package:farmsmart_flutter/chat/model/form/form_response_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String formResponseDataMock = '{"type": "com.google.firebase.database",'
      '"processMessage": "Creating account ...","processComplete": '
      '"Account created","uri": "profiles/%UserID/",'
      '"body": {"businessCard": {"uri": "%BusinessCardImage",'
      '"mimeType": "image/jpg"},"platformDevelop": "%PlatformDevelop",'
      '"name": "%Nickname","email": "%Email","phoneNumber": "%PhoneNumber",'
      '"loginType": "%LogInType","willUsersCreateProfile": "%WillUsersCreateProfile",'
      '"willAppBeConnectedToWebsite": "%WillAppBeConnectedToWebsite",'
      '"needHelpForDesign": "%NeedHelpForDesign"}}';

  group('FormResponse', () {
    var formResponse = FormResponseEntity.fromJson(jsonDecode(formResponseDataMock));

    test('fromJson() should parse json to the object correctly', () {
      expect(formResponse.type, 'com.google.firebase.database');
      expect(formResponse.uri, 'profiles/%UserID/');
      expect(formResponse.body['platformDevelop'], '%PlatformDevelop');
      expect(formResponse.body['name'], '%Nickname');
      expect(formResponse.body['loginType'], '%LogInType');
      expect(formResponse.body['needHelpForDesign'], '%NeedHelpForDesign');
      expect(formResponse.body['businessCard']['uri'], '%BusinessCardImage');
      expect(formResponse.body['businessCard']['mimeType'], 'image/jpg');

    });

    test('toJson() should parse the object to json correctly', () {
      var jsonMap = formResponse.toJson();

      expect(jsonMap['type'], 'com.google.firebase.database');
      expect(jsonMap['uri'], 'profiles/%UserID/');
      expect(jsonMap['body'], formResponse.body);
    });
  });
}
