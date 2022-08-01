import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_chat_bubble/bubble_type.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_2.dart';
import 'package:flutter_chat_bubble/clippers/chat_bubble_clipper_4.dart';
import 'package:sizer/sizer.dart';

import '../services/firebase_service.dart';
import 'package:intl/intl.dart';

class ChatStream extends StatefulWidget {
  final String chatRoomId;

  ChatStream({this.chatRoomId});

  @override
  State<ChatStream> createState() => _ChatStreamState();
}

class _ChatStreamState extends State<ChatStream> {
  FirebaseService service = FirebaseService();
  Stream chatMessageStream;
  DocumentSnapshot chatDoc;

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

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: StreamBuilder<QuerySnapshot>(
        stream: chatMessageStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return snapshot.hasData
              ? Column(
            children: [
              if (chatDoc != null)
                ListTile(
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                        width: 8.w,
                        height: 8.h,
                        child: Image.network(
                            chatDoc['product']['productImage'])),
                  ),
                  tileColor:
                  Theme.of(context).shadowColor.withOpacity(0.3),
                  trailing: Text('${chatDoc['product']['price']} QAR'),
                ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (BuildContext context, int index) {
                        String sentBy =
                        snapshot.data.docs[index]['sentBy'];
                        String me = service.user.uid;
                        String lastChatDate;
                        var date = DateFormat('yyyy-MM-dd').format(
                            DateTime.fromMicrosecondsSinceEpoch(
                                snapshot.data.docs[index]['time']));
                        var today = DateFormat('yyyy-MM-dd').format(
                            DateTime.fromMicrosecondsSinceEpoch(
                                DateTime.now().microsecondsSinceEpoch));
                        if (date == today) {
                          lastChatDate = DateFormat('hh:mm').format(
                              DateTime.fromMicrosecondsSinceEpoch(
                                  snapshot.data.docs[index]['time']));
                        } else {
                          lastChatDate = date.toString();
                        }
                        return Padding(
                            padding: EdgeInsets.all(8),
                            child: Column(
                              children: [
                                ChatBubble(
                                  alignment: sentBy == me
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  backGroundColor: sentBy == me
                                      ? Theme.of(context).backgroundColor
                                      : Colors.grey,
                                  child: Container(
                                    constraints:
                                    BoxConstraints(maxWidth: 85.w),
                                    child: Text(
                                      snapshot.data.docs[index]
                                      ['message'],
                                      style: TextStyle(
                                          color: sentBy == me
                                              ? Colors.white
                                              : Colors.black),
                                    ),
                                  ),
                                  clipper: ChatBubbleClipper2(
                                      type: sentBy == me
                                          ? BubbleType.sendBubble
                                          : BubbleType.receiverBubble),
                                ),
                                SizedBox(
                                  height: 0.5.h,
                                ),
                                Align(
                                  alignment: sentBy == me
                                      ? Alignment.centerRight
                                      : Alignment.centerLeft,
                                  child: Text(
                                    lastChatDate,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ),
                              ],
                            )
                          //child: Text(snapshot.data.docs[index]['message']),
                        );
                      }),
                ),
              ),
            ],
          )
              : Container();
        },
      ),
    );
  }
}