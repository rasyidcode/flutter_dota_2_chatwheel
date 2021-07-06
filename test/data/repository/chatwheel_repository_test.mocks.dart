// Mocks generated by Mockito 5.0.10 from annotations
// in flutter_dota_2_chatwheel/test/data/repository/chatwheel_repository_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:flutter_dota_2_chatwheel/data/model/network/chatwheel_event_result.dart'
    as _i2;
import 'package:flutter_dota_2_chatwheel/data/network/chatwheel_data_source.dart'
    as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: comment_references
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis

class _FakeChatwheelEventResult extends _i1.Fake
    implements _i2.ChatwheelEventResult {}

/// A class which mocks [ChatwheelDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockChatwheelDataSource extends _i1.Mock
    implements _i3.ChatwheelDataSource {
  MockChatwheelDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.Future<_i2.ChatwheelEventResult> getChatwheelEvents() =>
      (super.noSuchMethod(Invocation.method(#getChatwheelEvents, []),
              returnValue: Future<_i2.ChatwheelEventResult>.value(
                  _FakeChatwheelEventResult()))
          as _i4.Future<_i2.ChatwheelEventResult>);
}
