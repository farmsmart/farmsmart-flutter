
class _Strings {
  static const divider = " ";
  static const empty = "";
}

class PersonName {
  final String _name;

  PersonName._(this._name);

  factory PersonName(String fullname){
    final components = fullname.trim().split(_Strings.divider);
    final capitalisedComponents = components.map((component) {
      if (component.isNotEmpty) {
        final uppercasedFirstChar = component.substring(0,1).toUpperCase();
        return component.replaceRange(0,1,uppercasedFirstChar);
      }
      return _Strings.empty;
    });
    var capitalised = _Strings.empty;
    for (var component in capitalisedComponents) {
      capitalised += (capitalised.isNotEmpty ? _Strings.divider + component : component);
    }
    return PersonName._(capitalised);
  }

  List<String> get components {
    return _name.split(_Strings.divider);
  }

  String get fullname {
    return _name;
  }

  String get firstName {
    return components.first;
  }

  String get initials {
    final names = this.components;
     if (names != null) {
            if (names.length > 0) {
              final firstName = (names.length > 0) ? names.first : _Strings.empty;
              final secondName = (names.length > 1) ? names[1] : _Strings.empty;
              final firstInitial =  firstName.isNotEmpty ? firstName.substring(0, 1) : _Strings.empty;
              final secondInitial = secondName.isNotEmpty ? secondName.substring(0, 1) : _Strings.empty;
              return firstInitial + secondInitial;
            }
          }
      return _Strings.empty;
  }
  
}