import 'dart:convert';

import 'package:ecommerce_app/services/api.dart';
import 'package:ecommerce_app/services/user_service.dart';
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:stomp_dart_client/stomp_dart_client.dart';

typedef OnMessageReceived = void Function(Map<String, dynamic> message);

class WebsocketService {

  late StompClient _stompClient;
  bool _isConnected = false;
  final OnMessageReceived onMessageReceived;

  WebsocketService({
    required this.onMessageReceived
  });

  void connect() async{
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    _stompClient = StompClient(
      config: StompConfig.sockJS(
        url: '$apiUrl/sw',
        onConnect: _onConnect,
        onWebSocketError: (dynamic error){
          debugPrint('Error Websocket: $error');
        },
        stompConnectHeaders: {'Authorization': 'Bearer $token'},
        webSocketConnectHeaders: {'Authorization': 'Bearer $token'}
      )
    );

    _isConnected = true;
    _stompClient.activate();
  }

  void _onConnect(StompFrame frame) async{
    final prefs = await SharedPreferences.getInstance();
    final chatId = prefs.getString('chatId');

    _stompClient.subscribe(
      destination: '/topic/chat/$chatId',
      callback: (frame){
        final Map<String, dynamic> data = jsonDecode(frame.body!);
        onMessageReceived(data);
      }
    );
  }

  void sendMessage(String content) async{
    final prefs = await SharedPreferences.getInstance();
    final chatId = prefs.getString('chatId');

    final data = await UserService().getSingleUser();

    final msg = {
      'chatId': chatId,
      'author': data['name'],
      'content': content,
      'timestamp': DateTime.now().toIso8601String()
    };

    _stompClient.send(
      destination: '/app/user/chat',
      body: jsonEncode(msg)
    );
  }

  void disconnect(){
    _isConnected = false;
    _stompClient.deactivate();
  }
}