import 'dart:math';

class _Constants {
  static final week = 7;
  static final month = 30;
  static final year = 365;
  static final int endOfWorld = (1 << 32);
}

class MockDate {
  final List<DateTime> _library;
  final Random _rand;

  MockDate({List<DateTime> library, int seed = 0})
    : _library = library,
    _rand = Random(seed);

  DateTime _buildLibraryDate() {
    if (_library.isEmpty) {
      return _randomBetween();
    }
    final index = _rand.nextInt(max(1, _library.length));
    return _library[index];
  }

  DateTime random({DateTime from, DateTime to}) {
    if (from == null && to == null) {
      return  _buildLibraryDate();
    }
    return _randomBetween(from: from, to: to);
  }

  DateTime _randomBetween({DateTime from, DateTime to}) {
    final start = (from != null) ? from.millisecondsSinceEpoch : 0 ;
    final end =  (to != null) ? to.millisecondsSinceEpoch : (start + _Constants.endOfWorld);
    final expanse = end - start;
    final epocDate = start + (expanse * _rand.nextDouble());
    return DateTime.fromMillisecondsSinceEpoch(epocDate.toInt());
  }

  int _millisecondDays(int days) {
    return 1000*60*60*24*days;
  }

  DateTime randomWeekAgo() {
      final lastweek = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch - _millisecondDays(_Constants.week));
      return _randomBetween(from: lastweek, to: DateTime.now());
  }

  DateTime randomMonthAgo() {
      final lastweek = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch - _millisecondDays(_Constants.month));
      return _randomBetween(from: lastweek, to: DateTime.now());
  }

   DateTime randomYearAgo() {
      final lastweek = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch - _millisecondDays(_Constants.year));
      return _randomBetween(from: lastweek, to: DateTime.now());
  }

}