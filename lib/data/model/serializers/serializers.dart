library serializers;

import 'package:built_value/serializer.dart';
import 'package:built_value/standard_json_plugin.dart';
import 'package:flutter_dota_2_chatwheel/data/model/local/chatwheel_line.dart';

part 'serializers.g.dart';

@SerializersFor(const [ChatwheelLine])
final Serializers serializers =
    (_$serializers.toBuilder()..addPlugin(StandardJsonPlugin())).build();
