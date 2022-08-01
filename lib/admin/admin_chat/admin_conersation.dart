import 'package:flutter/material.dart';

import '../../services/firebase_service.dart';
import 'admin_chat_stream.dart';

class AdminChatConversation extends StatefulWidget {
  final String chatRoomId;
  AdminChatConversation({this.chatRoomId});

  @override
  State<AdminChatConversation> createState() => _AdminChatConversationState();
}

class _AdminChatConversationState extends State<AdminChatConversation> {

  FirebaseService service = FirebaseService();
  Stream chatMessageStream;
  var chatMessageController = TextEditingController();

  bool send = false;

  sendMessage() {
    if (chatMessageController.text.isNotEmpty) {
      FocusScope.of(context).unfocus();
      Map<String, dynamic> message = {
        'message': chatMessageController.text,
        'sentBy': service.user.uid,
        'time': DateTime.now().microsecondsSinceEpoch,
      };
      service.createChat(widget.chatRoomId, message);
      chatMessageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        elevation: 0,
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.call)),
          service.popupMenu(widget.chatRoomId, context),
        ],
        shape: Border(bottom: BorderSide(color: Colors.white)),
      ),
      body: Container(
        child: Stack(
          children: [
            AdminChatStream(
              chatRoomId: widget.chatRoomId,
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  border: Border(top: BorderSide(color: Colors.grey.shade800)),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: chatMessageController,
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.only(left: 20.0),
                            hintText: '    Type Message',
                            hintStyle: TextStyle(color: Colors.grey),
                            border: InputBorder.none,
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              setState(() {
                                send = true;
                              });
                            } else {
                              setState(() {
                                send = false;
                              });
                            }
                          },
                          onSubmitted: (value) {
                            if (value.isNotEmpty) {
                              sendMessage();
                            }
                          },
                        ),
                      ),
                      //TODO: uncomment in future
                      Visibility(
                        visible: send,
                        child: IconButton(
                          icon: Icon(Icons.send),
                          onPressed: sendMessage,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
