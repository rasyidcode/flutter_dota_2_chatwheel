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
      'line',
      serializers.serialize(object.line, specifiedType: const FullType(String)),
      'url',
      serializers.serialize(object.url, specifiedType: const FullType(String)),
    ];
    Object? value;
    value = object.lineTranslate;
    if (value != null) {
      result
        ..add('lineTranslate')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
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
        case 'line':
          result.line = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'lineTranslate':
          result.lineTranslate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
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
  final String line;
  @override
  final String? lineTranslate;
  @override
  final String url;

  factory _$ChatwheelLine([void Function(ChatwheelLineBuilder)? updates]) =>
      (new ChatwheelLineBuilder()..update(updates)).build();

  _$ChatwheelLine._({required this.line, this.lineTranslate, required this.url})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(line, 'ChatwheelLine', 'line');
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
    return other is ChatwheelLine &&
        line == other.line &&
        lineTranslate == other.lineTranslate &&
        url == other.url;
  }

  @override
  int get hashCode {
    return $jf(
        $jc($jc($jc(0, line.hashCode), lineTranslate.hashCode), url.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ChatwheelLine')
          ..add('line', line)
          ..add('lineTranslate', lineTranslate)
          ..add('url', url))
        .toString();
  }
}

class ChatwheelLineBuilder
    implements Builder<ChatwheelLine, ChatwheelLineBuilder> {
  _$ChatwheelLine? _$v;

  String? _line;
  String? get line => _$this._line;
  set line(String? line) => _$this._line = line;

  String? _lineTranslate;
  String? get lineTranslate => _$this._lineTranslate;
  set lineTranslate(String? lineTranslate) =>
      _$this._lineTranslate = lineTranslate;

  String? _url;
  String? get url => _$this._url;
  set url(String? url) => _$this._url = url;

  ChatwheelLineBuilder();

  ChatwheelLineBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _line = $v.line;
      _lineTranslate = $v.lineTranslate;
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
            line: BuiltValueNullFieldError.checkNotNull(
                line, 'ChatwheelLine', 'line'),
            lineTranslate: lineTranslate,
            url: BuiltValueNullFieldError.checkNotNull(
                url, 'ChatwheelLine', 'url'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
