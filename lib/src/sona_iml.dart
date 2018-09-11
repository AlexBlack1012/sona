import 'dart:async';

import 'package:flutter/services.dart';

import 'register_model.dart';

final MethodChannel _channel = const MethodChannel('com.jarvanmo/sona')
  ..setMethodCallHandler(_handler);

Future<Map<String, dynamic>> register(RegisterGetuiPushModel model) async {
  return await _channel.invokeMethod("register", model.params);
}

Future<String> clientID() async {
  return await _channel.invokeMethod("clientID");
}

Future turnOnPush() async{
  return await _channel.invokeMethod("turnOnPush",null);
}
Future turnOffPush() async{
  return await _channel.invokeMethod("turnOffPush",null);
}
StreamController<String> _receivedClientIDController =
    new StreamController.broadcast();

Stream<String> get receivedClientID => _receivedClientIDController.stream;

StreamController<Map<String, dynamic>> _receivedMessageDataController =
    new StreamController.broadcast();

/// listen data from getui
Stream<Map<String, dynamic>> get receivedMessageData =>
    _receivedMessageDataController.stream;

StreamController<bool> _receivedOnlineStateController =
    new StreamController.broadcast();

Stream<bool> get _receivedOnlineState => _receivedOnlineStateController.stream;

Future<dynamic> _handler(MethodCall methodCall) {
  if ("onReceiveMessageData" == methodCall.method) {
    _receivedMessageDataController.add(methodCall.arguments);
  } else if ("onReceiveClientId" == methodCall.method) {
    _receivedClientIDController.add(methodCall.arguments);
  } else if ("onReceiveOnlineState" == methodCall.arguments) {
    _receivedOnlineStateController.add(methodCall.arguments);
  }

  return Future.value(true);
}
