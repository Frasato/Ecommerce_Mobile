import 'package:ecommerce_app/constants/custom_colors.dart';
import 'package:ecommerce_app/services/websocket_service.dart';
import 'package:ecommerce_app/styles/chat_button_style.dart';
import 'package:ecommerce_app/widgets/custom_drawer_navigation.dart';
import 'package:ecommerce_app/widgets/header.dart';
import 'package:flutter/material.dart';

class SupportPage extends StatefulWidget{
  const SupportPage({super.key});

  @override
  State<StatefulWidget> createState() => _SupportePageState();
}

class _SupportePageState extends State<SupportPage>{
  final TextEditingController _controller = TextEditingController();
  final List<_ChatMessage> messages = [];

  late WebsocketService _websocketService;

  @override
  void initState() {
    super.initState();
    
    _websocketService = WebsocketService(
      onMessageReceived: (data){
        setState(() {
          messages.add(_ChatMessage(
            message: data['content'],
            isSentByUser: data['author'] == 'USER'
          ));
        });
      }
    );

    _websocketService.connect();
  }

  void sendMessage(){
    final text = _controller.text.trim();
    if(text.isEmpty) return;

    _websocketService.sendMessage(text);

    setState(() {
      messages.add(_ChatMessage(message: text, isSentByUser: true));
      _controller.clear();
    });
  }

  @override
  void dispose() {
    _websocketService.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    drawer: CustomDrawerNavigation(),
    appBar: AppBar(
      backgroundColor: customBlue,
      iconTheme: IconThemeData(
        color: customLightGrey
      ),
    ),
    body: Column(
      children: [
        Header(),
        Expanded(
          child: ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, index){
              final msg = messages[messages.length - 1 - index];
              return Align(
                alignment: msg.isSentByUser? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  padding: EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: msg.isSentByUser? customBlue : customLightGrey,
                    borderRadius: BorderRadius.circular(12)
                  ),
                  child: msg.isSentByUser? Text(msg.message, style: TextStyle(color: customLightGrey),) : Text(msg.message),
                ),
              );
            }
          )
        ),
        Padding(
          padding: EdgeInsets.all(8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    isDense: true,
                    hintText: 'Digite sua mensagem...',
                    hintStyle: TextStyle(fontSize: 14, color: customTextGrey),
                    fillColor: customGrey,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none
                    ),
                    errorStyle: TextStyle(
                      color: Colors.amber,
                      fontSize: 14
                    )
                  ),
                )
              ),
              SizedBox(width: 8),
              ElevatedButton(
                style: chatButtonStyle,
                onPressed: sendMessage, 
                child: Icon(Icons.send)
              )
            ],
          ),
        ),
        SizedBox(height: 20)
      ],
    ),
  );
}

class _ChatMessage{
  final String message;
  final bool isSentByUser;

  _ChatMessage({required this.message, required this.isSentByUser});
}