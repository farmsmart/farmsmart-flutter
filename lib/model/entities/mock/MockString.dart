import 'dart:math';

class MockString {
  final Random _rand;
  final List<String> _library;

  MockString({List<String> library, int seed = 0})
      : _library = library,
        _rand = Random(seed);

  String _getLibraryString() {
    final errorString = "Error string library data missing";
    if (_library.isEmpty) {
      return errorString;
    }
    final index = _rand.nextInt(max(1, _library.length));
    final string = _library[index];
    return string.isNotEmpty ? string : errorString;
  }

  String random({int length = 0}) {
    final libraryString = _getLibraryString();
    if (length <= 0) {
      return libraryString;
    }
    final maxLength = libraryString.length;
    final lastIndex = max(0, _rand.nextInt(maxLength) - 1);
    return libraryString.substring(0, lastIndex);
  }

  String randomIndexed({String text = "index", int limit = 10}) {
      return indexed(text: text, index: _rand.nextInt(limit));
  }

  String indexed({String text = "index", int index}) {
    return text + " " + index.toString();
  }
  
  List<String> libarary(){
    return _library;
  }

  List<String> indexedList({String text = "index", int count}) {
    List<String> list = [];
    for (var i = 0; i < count; i++) {
      list.add(indexed(text: text, index: i));
    }
    return list;
  }

  String identifier() {
    int maxSupported = 1 << 32;
    return _rand.nextInt(maxSupported).toString();
  }

  List<String> list({int limit = 0}) {
      List<String> strings = [];
      final generationCount = (limit == 0) ? _rand.nextInt(_library.length) : limit;
      for (var i = 0; i < generationCount; i++) {
        strings.add(random());
      }
      return strings;
  }
}