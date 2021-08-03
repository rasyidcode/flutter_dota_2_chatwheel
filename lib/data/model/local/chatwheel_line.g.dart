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
      'eventName',
      serializers.serialize(object.eventName,
          specifiedType: const FullType(String)),
      'packName',
      serializers.serialize(object.packName,
          specifiedType: const FullType(String)),
      'line',
      serializers.serialize(object.line, specifiedType: const FullType(String)),
      'lineTranslate',
      serializers.serialize(object.lineTranslate,
          specifiedType: const FullType(String)),
      'url',
      serializers.serialize(object.url, specifiedType: const FullType(String)),
      'localPath',
      serializers.serialize(object.localPath,
          specifiedType: const FullType(String)),
      'createdAt',
      serializers.serialize(object.createdAt,
          specifiedType: const FullType(int)),
      'updatedAt',
      serializers.serialize(object.updatedAt,
          specifiedType: const FullType(int)),
      'showInWheel',
      serializers.serialize(object.showInWheel,
          specifiedType: const FullType(bool)),
    ];
    Object? value;
    value = object.id;
    if (value != null) {
      result
        ..add('id')
        ..add(serializers.serialize(value, specifiedType: const FullType(int)));
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
        case 'id':
          result.id = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int?;
          break;
        case 'eventName':
          result.eventName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'packName':
          result.packName = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'line':
          result.line = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'lineTranslate':
          result.lineTranslate = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'url':
          result.url = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'localPath':
          result.localPath = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'createdAt':
          result.createdAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'updatedAt':
          result.updatedAt = serializers.deserialize(value,
              specifiedType: const FullType(int)) as int;
          break;
        case 'showInWheel':
          result.showInWheel = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
      }
    }

    return result.build();
  }
}

class _$ChatwheelLine extends ChatwheelLine {
  @override
  final int? id;
  @override
  final String eventName;
  @override
  final String packName;
  @override
  final String line;
  @override
  final String lineTranslate;
  @override
  final String url;
  @override
  final String localPath;
  @override
  final int createdAt;
  @override
  final int updatedAt;
  @override
  final bool showInWheel;

  factory _$ChatwheelLine([void Function(ChatwheelLineBuilder)? updates]) =>
      (new ChatwheelLineBuilder()..update(updates)).build();

  _$ChatwheelLine._(
      {this.id,
      required this.eventName,
      required this.packName,
      required this.line,
      required this.lineTranslate,
      required this.url,
      required this.localPath,
      required this.createdAt,
      required this.updatedAt,
      required this.showInWheel})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        eventName, 'ChatwheelLine', 'eventName');
    BuiltValueNullFieldError.checkNotNull(
        packName, 'ChatwheelLine', 'packName');
    BuiltValueNullFieldError.checkNotNull(line, 'ChatwheelLine', 'line');
    BuiltValueNullFieldError.checkNotNull(
        lineTranslate, 'ChatwheelLine', 'lineTranslate');
    BuiltValueNullFieldError.checkNotNull(url, 'ChatwheelLine', 'url');
    BuiltValueNullFieldError.checkNotNull(
        localPath, 'ChatwheelLine', 'localPath');
    BuiltValueNullFieldError.checkNotNull(
        createdAt, 'ChatwheelLine', 'createdAt');
    BuiltValueNullFieldError.checkNotNull(
        updatedAt, 'ChatwheelLine', 'updatedAt');
    BuiltValueNullFieldError.checkNotNull(
        showInWheel, 'ChatwheelLine', 'showInWheel');
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
        id == other.id &&
        eventName == other.eventName &&
        packName == other.packName &&
        line == other.line &&
        lineTranslate == other.lineTranslate &&
        url == other.url &&
        localPath == other.localPath &&
        createdAt == other.createdAt &&
        updatedAt == other.updatedAt &&
        showInWheel == other.showInWheel;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc(
                    $jc(
                        $jc(
                            $jc(
                                $jc(
                                    $jc($jc(0, id.hashCode),
                                        eventName.hashCode),
                                    packName.hashCode),
                                line.hashCode),
                            lineTranslate.hashCode),
                        url.hashCode),
                    localPath.hashCode),
                createdAt.hashCode),
            updatedAt.hashCode),
        showInWheel.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('ChatwheelLine')
          ..add('id', id)
          ..add('eventName', eventName)
          ..add('packName', packName)
          ..add('line', line)
          ..add('lineTranslate', lineTranslate)
          ..add('url', url)
          ..add('localPath', localPath)
          ..add('createdAt', createdAt)
          ..add('updatedAt', updatedAt)
          ..add('showInWheel', showInWheel))
        .toString();
  }
}

class ChatwheelLineBuilder
    implements Builder<ChatwheelLine, ChatwheelLineBuilder> {
  _$ChatwheelLine? _$v;

  int? _id;
  int? get id => _$this._id;
  set id(int? id) => _$this._id = id;

  String? _eventName;
  String? get eventName => _$this._eventName;
  set eventName(String? eventName) => _$this._eventName = eventName;

  String? _packName;
  String? get packName => _$this._packName;
  set packName(String? packName) => _$this._packName = packName;

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

  String? _localPath;
  String? get localPath => _$this._localPath;
  set localPath(String? localPath) => _$this._localPath = localPath;

  int? _createdAt;
  int? get createdAt => _$this._createdAt;
  set createdAt(int? createdAt) => _$this._createdAt = createdAt;

  int? _updatedAt;
  int? get updatedAt => _$this._updatedAt;
  set updatedAt(int? updatedAt) => _$this._updatedAt = updatedAt;

  bool? _showInWheel;
  bool? get showInWheel => _$this._showInWheel;
  set showInWheel(bool? showInWheel) => _$this._showInWheel = showInWheel;

  ChatwheelLineBuilder();

  ChatwheelLineBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _eventName = $v.eventName;
      _packName = $v.packName;
      _line = $v.line;
      _lineTranslate = $v.lineTranslate;
      _url = $v.url;
      _localPath = $v.localPath;
      _createdAt = $v.createdAt;
      _updatedAt = $v.updatedAt;
      _showInWheel = $v.showInWheel;
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
            id: id,
            eventName: BuiltValueNullFieldError.checkNotNull(
                eventName, 'ChatwheelLine', 'eventName'),
            packName: BuiltValueNullFieldError.checkNotNull(
                packName, 'ChatwheelLine', 'packName'),
            line: BuiltValueNullFieldError.checkNotNull(
                line, 'ChatwheelLine', 'line'),
            lineTranslate: BuiltValueNullFieldError.checkNotNull(
                lineTranslate, 'ChatwheelLine', 'lineTranslate'),
            url: BuiltValueNullFieldError.checkNotNull(
                url, 'ChatwheelLine', 'url'),
            localPath: BuiltValueNullFieldError.checkNotNull(
                localPath, 'ChatwheelLine', 'localPath'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, 'ChatwheelLine', 'createdAt'),
            updatedAt: BuiltValueNullFieldError.checkNotNull(
                updatedAt, 'ChatwheelLine', 'updatedAt'),
            showInWheel: BuiltValueNullFieldError.checkNotNull(
                showInWheel, 'ChatwheelLine', 'showInWheel'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
