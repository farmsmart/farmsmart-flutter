class Basket<T> {
  List<T> _contents = [];
  final Function _didChange;

  Basket(this._didChange);

  void addIfNotAlready(T item) {
    if (!contains(item)){
      addItem(item);
    }
  }

  void addItem(T item) {
    final old = _contents;
    _contents.add(item);
    _update(old);
  }

  void removeItem(T item) {
    final old = _contents;
    _contents.remove(item);
     _update(old);
  }

  bool contains(T item) {
    return _contents.contains(item);
  }

  bool isEmpty() {
    return _contents.isEmpty;
  }

  List<T> empty() {
    final contents = _contents;
    _contents = [];
    _update(contents);
    return contents;
  }

  List<T> contents() {
    return _contents;
  }

  void _update(List<T> old) {
    if(_didChange != null){
       _didChange(old);
    }
  }
}