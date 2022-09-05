class Movie {
  late final String _name;
  late final String _subName;
  late final String _img;

  String get name => _name;

  String get subName => _subName;

  String get img => _img;

  Movie(this._name, this._subName, this._img);
}