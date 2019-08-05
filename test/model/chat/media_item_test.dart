import 'dart:convert';

import 'package:farmsmart_flutter/chat/model/form/media_item_entity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  String mediaItemMockData =
      '{"uri":"%BusinessCardImage","mimeType":"image/jpg"}';

  group('MediaItem', (){
    test('fromJson() should parse json to the object correctly', () {
      var mediaItem = MediaItemEntity.fromJson(jsonDecode(mediaItemMockData));

      expect(mediaItem.uri, '%BusinessCardImage');
      expect(mediaItem.mimeType, 'image/jpg');
    });

    test('toJson() should parse the object to json correctly', () {
      var mediaItem = MediaItemEntity('%BusinessCardImage', 'image/jpg');
      var jsonMap = mediaItem.toJson();

      expect(jsonMap['uri'], mediaItem.uri);
      expect(jsonMap['mimeType'], mediaItem.mimeType);
    });
  });
}
