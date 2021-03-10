class ClassModel {
  final int _columnId;
  final String _columnClassName;
  final int _columnStartOfId;
  final int _columnEndOfId;
  final String _columnPrefixOfId;
  final String _columnSuffixOfId;

  ClassModel(this._columnId, this._columnClassName, this._columnStartOfId,
      this._columnEndOfId, this._columnPrefixOfId, this._columnSuffixOfId);

  int get id => _columnId;
  String get className => _columnClassName;
  int get start => _columnStartOfId;
  int get end => _columnEndOfId;
  String get prefix => _columnPrefixOfId;
  String get suffix => _columnSuffixOfId;
}
