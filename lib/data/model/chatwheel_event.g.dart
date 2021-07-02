// GENERATED CODE - DO NOT MODIFY BY HAND

part of chatwheel_event;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ChatwheelEvent> _$chatwheelEventSerializer =
    new _$ChatwheelEventSerializer();

class _$ChatwheelEventSerializer
    implements StructuredSerializer<ChatwheelEvent> {
  @override
  final Iterable<Type> types = const [ChatwheelEvent, _$ChatwheelEvent];
  @override
  final String wireName = 'ChatwheelEvent';

  @override
  Iterable<Object?> serialize(Serializers serializers, ChatwheelEvent object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'eventName',
      serializers.serialize(object.eventName,
          specifiedType: const FullType(String)),
      'packs',
      serializers.serialize(object.packs,
          specifiedType:
              const FullType(BuiltList, const [const FullType(ChatwheelPack)])),
    ];

    return result;
  }

  @override
  ChatwheelEvent deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChatwheelEventBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'eventName':
          result.eventName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'packs':
          result.packs.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ChatwheelPack)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$ChatwheelEvent extends ChatwheelEvent {
  @override
  final String eventName;
  @override
  final BuiltList<ChatwheelPack> packs;

  factory _$ChatwheelEvent([void Function(ChatwheelEventBuilder)? updates]) =>
      (new ChatwheelEventBuilder()..update(updates)).build();

  _$ChatwheelEvent._({required this.eventName, required this.packs})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        eventName, 'ChatwheelEvent', 'eventName');
    BuiltValueNullFieldError.checkNotNull(packs, 'ChatwheelEvent', 'packs');
  }

  @override
  ChatwheelEvent rebuild(void Function(ChatwheelEventBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatwheelEventBuilder toBuilder() =>
      new ChatwheelEventBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatwheelEvent &&
        eventName == other.eventName &&
        packs == other.packs;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, eventName.hashCode), packs.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ChatwheelEvent')
          ..add('eventName', eventName)
          ..add('packs', packs))
        .toString();
  }
}

class ChatwheelEventBuilder
    implements Builder<ChatwheelEvent, ChatwheelEventBuilder> {
  _$ChatwheelEvent? _$v;

  String? _eventName;
  String? get eventName => _$this._eventName;
  set eventName(String? eventName) => _$this._eventName = eventName;

  ListBuilder<ChatwheelPack>? _packs;
  ListBuilder<ChatwheelPack> get packs =>
      _$this._packs ??= new ListBuilder<ChatwheelPack>();
  set packs(ListBuilder<ChatwheelPack>? packs) => _$this._packs = packs;

  ChatwheelEventBuilder();

  ChatwheelEventBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _eventName = $v.eventName;
      _packs = $v.packs.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatwheelEvent other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ChatwheelEvent;
  }

  @override
  void update(void Function(ChatwheelEventBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ChatwheelEvent build() {
    _$ChatwheelEvent _$result;
    try {
      _$result = _$v ??
          new _$ChatwheelEvent._(
              eventName: BuiltValueNullFieldError.checkNotNull(
                  eventName, 'ChatwheelEvent', 'eventName'),
              packs: packs.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'packs';
        packs.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ChatwheelEvent', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
