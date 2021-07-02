// GENERATED CODE - DO NOT MODIFY BY HAND

part of chatwheel_pack;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ChatwheelPack> _$chatwheelPackSerializer =
    new _$ChatwheelPackSerializer();

class _$ChatwheelPackSerializer implements StructuredSerializer<ChatwheelPack> {
  @override
  final Iterable<Type> types = const [ChatwheelPack, _$ChatwheelPack];
  @override
  final String wireName = 'ChatwheelPack';

  @override
  Iterable<Object?> serialize(Serializers serializers, ChatwheelPack object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'packName',
      serializers.serialize(object.packName,
          specifiedType: const FullType(String)),
      'bpLevel',
      serializers.serialize(object.bpLevel, specifiedType: const FullType(int)),
      'lines',
      serializers.serialize(object.lines,
          specifiedType:
              const FullType(BuiltList, const [const FullType(ChatwheelLine)])),
    ];

    return result;
  }

  @override
  ChatwheelPack deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChatwheelPackBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'packName':
          result.packName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'bpLevel':
          result.bpLevel = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'lines':
          result.lines.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType(ChatwheelLine)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$ChatwheelPack extends ChatwheelPack {
  @override
  final String packName;
  @override
  final int bpLevel;
  @override
  final BuiltList<ChatwheelLine> lines;

  factory _$ChatwheelPack([void Function(ChatwheelPackBuilder)? updates]) =>
      (new ChatwheelPackBuilder()..update(updates)).build();

  _$ChatwheelPack._(
      {required this.packName, required this.bpLevel, required this.lines})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        packName, 'ChatwheelPack', 'packName');
    BuiltValueNullFieldError.checkNotNull(bpLevel, 'ChatwheelPack', 'bpLevel');
    BuiltValueNullFieldError.checkNotNull(lines, 'ChatwheelPack', 'lines');
  }

  @override
  ChatwheelPack rebuild(void Function(ChatwheelPackBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatwheelPackBuilder toBuilder() => new ChatwheelPackBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatwheelPack &&
        packName == other.packName &&
        bpLevel == other.bpLevel &&
        lines == other.lines;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, packName.hashCode), bpLevel.hashCode), lines.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ChatwheelPack')
          ..add('packName', packName)
          ..add('bpLevel', bpLevel)
          ..add('lines', lines))
        .toString();
  }
}

class ChatwheelPackBuilder
    implements Builder<ChatwheelPack, ChatwheelPackBuilder> {
  _$ChatwheelPack? _$v;

  String? _packName;
  String? get packName => _$this._packName;
  set packName(String? packName) => _$this._packName = packName;

  int? _bpLevel;
  int? get bpLevel => _$this._bpLevel;
  set bpLevel(int? bpLevel) => _$this._bpLevel = bpLevel;

  ListBuilder<ChatwheelLine>? _lines;
  ListBuilder<ChatwheelLine> get lines =>
      _$this._lines ??= new ListBuilder<ChatwheelLine>();
  set lines(ListBuilder<ChatwheelLine>? lines) => _$this._lines = lines;

  ChatwheelPackBuilder();

  ChatwheelPackBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _packName = $v.packName;
      _bpLevel = $v.bpLevel;
      _lines = $v.lines.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatwheelPack other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ChatwheelPack;
  }

  @override
  void update(void Function(ChatwheelPackBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ChatwheelPack build() {
    _$ChatwheelPack _$result;
    try {
      _$result = _$v ??
          new _$ChatwheelPack._(
              packName: BuiltValueNullFieldError.checkNotNull(
                  packName, 'ChatwheelPack', 'packName'),
              bpLevel: BuiltValueNullFieldError.checkNotNull(
                  bpLevel, 'ChatwheelPack', 'bpLevel'),
              lines: lines.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'lines';
        lines.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'ChatwheelPack', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
