// GENERATED CODE - DO NOT MODIFY BY HAND

part of chatwheel_line;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<ChatwheelLine> _$chatwheelLineSerializer =
    new _$ChatwheelLineSerializer();

class _$ChatwheelLineSerializer implements StructuredSerializer<ChatwheelLine> {
  @override
  final Iterable<Type> types = const [ChatwheelLine, _$ChatwheelLine];
  @override
  final String wireName = 'ChatwheelLine';

  @override
  Iterable<Object?> serialize(Serializers serializers, ChatwheelLine object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'name',
      serializers.serialize(object.name, specifiedType: const FullType(String)),
      'url',
      serializers.serialize(object.url, specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  ChatwheelLine deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new ChatwheelLineBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$ChatwheelLine extends ChatwheelLine {
  @override
  final String name;
  @override
  final String url;

  factory _$ChatwheelLine([void Function(ChatwheelLineBuilder)? updates]) =>
      (new ChatwheelLineBuilder()..update(updates)).build();

  _$ChatwheelLine._({required this.name, required this.url}) : super._() {
    BuiltValueNullFieldError.checkNotNull(name, 'ChatwheelLine', 'name');
    BuiltValueNullFieldError.checkNotNull(url, 'ChatwheelLine', 'url');
  }

  @override
  ChatwheelLine rebuild(void Function(ChatwheelLineBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatwheelLineBuilder toBuilder() => new ChatwheelLineBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatwheelLine && name == other.name && url == other.url;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, name.hashCode), url.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ChatwheelLine')
          ..add('name', name)
          ..add('url', url))
        .toString();
  }
}

class ChatwheelLineBuilder
    implements Builder<ChatwheelLine, ChatwheelLineBuilder> {
  _$ChatwheelLine? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  ChatwheelLineBuilder();

  ChatwheelLineBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _url = $v.url;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatwheelLine other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$ChatwheelLine;
  }

  @override
  void update(void Function(ChatwheelLineBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$ChatwheelLine build() {
    final _$result = _$v ??
        new _$ChatwheelLine._(
            name: BuiltValueNullFieldError.checkNotNull(
                name, 'ChatwheelLine', 'name'),
            url: BuiltValueNullFieldError.checkNotNull(
                url, 'ChatwheelLine', 'url'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
