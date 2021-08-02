// GENERATED CODE - DO NOT MODIFY BY HAND

part of home_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HomeState extends HomeState {
  @override
  final bool isLoading;
  @override
  final String error;
  @override
  final BuiltList<ChatwheelLine> lines;
  @override
  final bool hasReachedEndOfResults;
  @override
  final bool isDownloading;
  @override
  final bool isDownloaded;
  @override
  final bool isFailDownload;
  @override
  final int? downloadingId;

  factory _$HomeState([void Function(HomeStateBuilder)? updates]) =>
      (new HomeStateBuilder()..update(updates)).build();

  _$HomeState._(
      {required this.isLoading,
      required this.error,
      required this.lines,
      required this.hasReachedEndOfResults,
      required this.isDownloading,
      required this.isDownloaded,
      required this.isFailDownload,
      this.downloadingId})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(isLoading, 'HomeState', 'isLoading');
    BuiltValueNullFieldError.checkNotNull(error, 'HomeState', 'error');
    BuiltValueNullFieldError.checkNotNull(lines, 'HomeState', 'lines');
    BuiltValueNullFieldError.checkNotNull(
        hasReachedEndOfResults, 'HomeState', 'hasReachedEndOfResults');
    BuiltValueNullFieldError.checkNotNull(
        isDownloading, 'HomeState', 'isDownloading');
    BuiltValueNullFieldError.checkNotNull(
        isDownloaded, 'HomeState', 'isDownloaded');
    BuiltValueNullFieldError.checkNotNull(
        isFailDownload, 'HomeState', 'isFailDownload');
  }

  @override
  HomeState rebuild(void Function(HomeStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HomeStateBuilder toBuilder() => new HomeStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomeState &&
        isLoading == other.isLoading &&
        error == other.error &&
        lines == other.lines &&
        hasReachedEndOfResults == other.hasReachedEndOfResults &&
        isDownloading == other.isDownloading &&
        isDownloaded == other.isDownloaded &&
        isFailDownload == other.isFailDownload &&
        downloadingId == other.downloadingId;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc($jc($jc(0, isLoading.hashCode), error.hashCode),
                            lines.hashCode),
                        hasReachedEndOfResults.hashCode),
                    isDownloading.hashCode),
                isDownloaded.hashCode),
            isFailDownload.hashCode),
        downloadingId.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('HomeState')
          ..add('isLoading', isLoading)
          ..add('error', error)
          ..add('lines', lines)
          ..add('hasReachedEndOfResults', hasReachedEndOfResults)
          ..add('isDownloading', isDownloading)
          ..add('isDownloaded', isDownloaded)
          ..add('isFailDownload', isFailDownload)
          ..add('downloadingId', downloadingId))
        .toString();
  }
}

class HomeStateBuilder implements Builder<HomeState, HomeStateBuilder> {
  _$HomeState? _$v;

  bool? _isLoading;
  bool? get isLoading => _$this._isLoading;
  set isLoading(bool? isLoading) => _$this._isLoading = isLoading;

  String? _error;
  String? get error => _$this._error;
  set error(String? error) => _$this._error = error;

  ListBuilder<ChatwheelLine>? _lines;
  ListBuilder<ChatwheelLine> get lines =>
      _$this._lines ??= new ListBuilder<ChatwheelLine>();
  set lines(ListBuilder<ChatwheelLine>? lines) => _$this._lines = lines;

  bool? _hasReachedEndOfResults;
  bool? get hasReachedEndOfResults => _$this._hasReachedEndOfResults;
  set hasReachedEndOfResults(bool? hasReachedEndOfResults) =>
      _$this._hasReachedEndOfResults = hasReachedEndOfResults;

  bool? _isDownloading;
  bool? get isDownloading => _$this._isDownloading;
  set isDownloading(bool? isDownloading) =>
      _$this._isDownloading = isDownloading;

  bool? _isDownloaded;
  bool? get isDownloaded => _$this._isDownloaded;
  set isDownloaded(bool? isDownloaded) => _$this._isDownloaded = isDownloaded;

  bool? _isFailDownload;
  bool? get isFailDownload => _$this._isFailDownload;
  set isFailDownload(bool? isFailDownload) =>
      _$this._isFailDownload = isFailDownload;

  int? _downloadingId;
  int? get downloadingId => _$this._downloadingId;
  set downloadingId(int? downloadingId) =>
      _$this._downloadingId = downloadingId;

  HomeStateBuilder();

  HomeStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isLoading = $v.isLoading;
      _error = $v.error;
      _lines = $v.lines.toBuilder();
      _hasReachedEndOfResults = $v.hasReachedEndOfResults;
      _isDownloading = $v.isDownloading;
      _isDownloaded = $v.isDownloaded;
      _isFailDownload = $v.isFailDownload;
      _downloadingId = $v.downloadingId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(HomeState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HomeState;
  }

  @override
  void update(void Function(HomeStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$HomeState build() {
    _$HomeState _$result;
    try {
      _$result = _$v ??
          new _$HomeState._(
              isLoading: BuiltValueNullFieldError.checkNotNull(
                  isLoading, 'HomeState', 'isLoading'),
              error: BuiltValueNullFieldError.checkNotNull(
                  error, 'HomeState', 'error'),
              lines: lines.build(),
              hasReachedEndOfResults: BuiltValueNullFieldError.checkNotNull(
                  hasReachedEndOfResults,
                  'HomeState',
                  'hasReachedEndOfResults'),
              isDownloading: BuiltValueNullFieldError.checkNotNull(
                  isDownloading, 'HomeState', 'isDownloading'),
              isDownloaded: BuiltValueNullFieldError.checkNotNull(
                  isDownloaded, 'HomeState', 'isDownloaded'),
              isFailDownload: BuiltValueNullFieldError.checkNotNull(
                  isFailDownload, 'HomeState', 'isFailDownload'),
              downloadingId: downloadingId);
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'lines';
        lines.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'HomeState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
