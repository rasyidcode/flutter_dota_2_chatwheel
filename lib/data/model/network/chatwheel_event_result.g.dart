// GENERATED CODE - DO NOT MODIFY BY HAND

part of chatwheel_event_result;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChatwheelEventResult extends ChatwheelEventResult {
  @override
  final BuiltList<ChatwheelEvent?> events;

  factory _$ChatwheelEventResult(
          [void Function(ChatwheelEventResultBuilder)? updates]) =>
      (new ChatwheelEventResultBuilder()..update(updates)).build();

  _$ChatwheelEventResult._({required this.events}) : super._() {
    BuiltValueNullFieldError.checkNotNull(
        events, 'ChatwheelEventResult', 'events');
  }

  @override
  ChatwheelEventResult rebuild(
          void Function(ChatwheelEventResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatwheelEventResultBuilder toBuilder() =>
      new ChatwheelEventResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatwheelEventResult && events == other.events;
  }

  @override
  int get hashCode {
    return $jf($jc(0, events.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ChatwheelEventResult')
          ..add('events', events))
        .toString();
  }
}

class ChatwheelEventResultBuilder
    implements Builder<ChatwheelEventResult, ChatwheelEventResultBuilder> {
  _$ChatwheelEventResult? _$v;

  ListBuilder<ChatwheelEvent?>? _events;
  ListBuilder<ChatwheelEvent?> get events =>
      _$this._events ??= new ListBuilder<ChatwheelEvent?>();
  set events(ListBuilder<ChatwheelEvent?>? events) => _$this._events = events;

  ChatwheelEventResultBuilder();

  ChatwheelEventResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _events = $v.events.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatwheelEventResult other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ChatwheelEventResult;
  }

  @override
  void update(void Function(ChatwheelEventResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ChatwheelEventResult build() {
    _$ChatwheelEventResult _$result;
    try {
      _$result = _$v ?? new _$ChatwheelEventResult._(events: events.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'events';
        events.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ChatwheelEventResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
