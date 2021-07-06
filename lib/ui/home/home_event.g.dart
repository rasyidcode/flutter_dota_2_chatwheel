// GENERATED CODE - DO NOT MODIFY BY HAND

part of home_event;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$HomeInitiated extends HomeInitiated {
  factory _$HomeInitiated([void Function(HomeInitiatedBuilder)? updates]) =>
      (new HomeInitiatedBuilder()..update(updates)).build();

  _$HomeInitiated._() : super._();

  @override
  HomeInitiated rebuild(void Function(HomeInitiatedBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  HomeInitiatedBuilder toBuilder() => new HomeInitiatedBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is HomeInitiated;
  }

  @override
  int get hashCode {
    return 769982979;
  }

  @override
  String toString() {
    return newBuiltValueToStringHelper('HomeInitiated').toString();
  }
}

class HomeInitiatedBuilder
    implements Builder<HomeInitiated, HomeInitiatedBuilder> {
  _$HomeInitiated? _$v;

  HomeInitiatedBuilder();

  @override
  void replace(HomeInitiated other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$HomeInitiated;
  }

  @override
  void update(void Function(HomeInitiatedBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$HomeInitiated build() {
    final _$result = _$v ?? new _$HomeInitiated._();
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
