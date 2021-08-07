// GENERATED CODE - DO NOT MODIFY BY HAND

part of wheel_event;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$WheelInitiated extends WheelInitiated {
  factory _$WheelInitiated([void Function(WheelInitiatedBuilder)? updates]) =>
      (new WheelInitiatedBuilder()..update(updates)).build();

  _$WheelInitiated._() : super._();

  @override
  WheelInitiated rebuild(void Function(WheelInitiatedBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  WheelInitiatedBuilder toBuilder() =>
      new WheelInitiatedBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is WheelInitiated;
  }

  @override
  int get hashCode {
    return 790591086;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('WheelInitiated').toString();
  }
}

class WheelInitiatedBuilder
    implements Builder<WheelInitiated, WheelInitiatedBuilder> {
  _$WheelInitiated? _$v;

  WheelInitiatedBuilder();

  @override
  void replace(WheelInitiated other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$WheelInitiated;
  }

  @override
  void update(void Function(WheelInitiatedBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$WheelInitiated build() {
    final _$result = _$v ?? new _$WheelInitiated._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
