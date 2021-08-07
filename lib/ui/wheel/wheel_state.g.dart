// GENERATED CODE - DO NOT MODIFY BY HAND

part of wheel_state;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WheelState extends WheelState {
  @override
  final bool isLoading;
  @override
  final String error;
  @override
  final BuiltList<ChatwheelLine> lines;

  factory _$WheelState([void Function(WheelStateBuilder)? updates]) =>
      (new WheelStateBuilder()..update(updates)).build();

  _$WheelState._(
      {required this.isLoading, required this.error, required this.lines})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(isLoading, 'WheelState', 'isLoading');
    BuiltValueNullFieldError.checkNotNull(error, 'WheelState', 'error');
    BuiltValueNullFieldError.checkNotNull(lines, 'WheelState', 'lines');
  }

  @override
  WheelState rebuild(void Function(WheelStateBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WheelStateBuilder toBuilder() => new WheelStateBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WheelState &&
        isLoading == other.isLoading &&
        error == other.error &&
        lines == other.lines;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, isLoading.hashCode), error.hashCode), lines.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('WheelState')
          ..add('isLoading', isLoading)
          ..add('error', error)
          ..add('lines', lines))
        .toString();
  }
}

class WheelStateBuilder implements Builder<WheelState, WheelStateBuilder> {
  _$WheelState? _$v;

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

  WheelStateBuilder();

  WheelStateBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _isLoading = $v.isLoading;
      _error = $v.error;
      _lines = $v.lines.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(WheelState other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WheelState;
  }

  @override
  void update(void Function(WheelStateBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WheelState build() {
    _$WheelState _$result;
    try {
      _$result = _$v ??
          new _$WheelState._(
              isLoading: BuiltValueNullFieldError.checkNotNull(
                  isLoading, 'WheelState', 'isLoading'),
              error: BuiltValueNullFieldError.checkNotNull(
                  error, 'WheelState', 'error'),
              lines: lines.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'lines';
        lines.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'WheelState', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
