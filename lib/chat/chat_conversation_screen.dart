import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_app/chat/chat_stream.dart';
import 'package:sizer/sizer.dart';

import '../services/firebase_service.dart';

class ConversationScreen extends StatefulWidget {
  final String chatRoomId;
  ConversationScreen({this.chatRoomId});
  @override
  _ConversationScreenState createState() => _ConversationScreenState();
}

class _ConversationScreenState extends State<ConversationScreen> {
  FirebaseService service = FirebaseService();
  Stream chatMessageStream;
  DocumentSnapshot chatDoc;
  var chatMessageController = TextEditingController();

  bool send = false;
  @override
  void initState() {
    // TODO: implement initState
    service.getChat(widget.chatRoomId).then((value) {
      setState(() {
        chatMessageStream = value;
      });
    });
    service.messages.doc(widget.chatRoomId).get().then((value) {
      setState(() {
        chatDoc = value;
      });
    });
    super.initState();
  }


   sendMessage() {

    if (chatMessageController.text.isNotEmpty) {
      FocusScope.of(context).unfocus();
      if(FirebaseAuth.instance.currentUser.uid!=chatDoc['product']['seller']){
        Map<String, dynamic> message = {
          'message': chatMessageController.text,
          'sentBy': chatDoc['users'][1],
          'time': DateTime.now().microsecondsSinceEpoch,
          'receiverId':chatDoc['product']['seller'],
        };
        service.createChat(widget.chatRoomId, message);
        chatMessageController.clear();
      }
      else{
        Map<String, dynamic> message = {
          'message': chatMessageController.text,
          'sentBy':chatDoc['product']['seller'],
          'time': DateTime.now().microsecondsSinceEpoch,
          'receiverId': chatDoc['users'][1],
        };
        service.createChat(widget.chatRoomId, message);
        chatMessageController.clear();
      }

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
            Container(
              height: 81.h,
              child: ChatStream(
                chatRoomId: widget.chatRoomId,
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
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
