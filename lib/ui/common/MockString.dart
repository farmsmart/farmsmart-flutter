import 'dart:math';

class MockString {
  final Random _rand;
  final List<String> _library;

  MockString({List<String> library, int seed = 0}) : _library = library, _rand = Random(seed);

  String _getLibraryString() {
    final errorString =  "Error string library data missing";
    if ( _library.isEmpty){
      return errorString;
    }
    final index = _rand.nextInt(max(1,_library.length));
    final string = _library[index];
    return string.isNotEmpty ? string : errorString;
  }

  String random({int length = 0}) {
    final libraryString = _getLibraryString();
    if (length <= 0) {
      return libraryString;
    }
    final maxLength = libraryString.length;
    final lastIndex = max(0,_rand.nextInt(maxLength)-1);
    return libraryString.substring(0,lastIndex);
  }

  String indexed({String text = "index", int index}) {
    return text + " " + index.toString();
  }

  String identifier() {
    int maxSupported = 1 << 32;
    return _rand.nextInt(maxSupported).toString();
  }
}

class MockInt {
  final rng = new Random();
  MockInt(rng);
}
