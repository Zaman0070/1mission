import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_app/admin/admin_chat/asmin_chat_card.dart';

import '../../pages/main_screen.dart';
import '../../services/firebase_service.dart';

class AdminChatScreen extends StatefulWidget {

  @override
  State<AdminChatScreen> createState() => _AdminChatScreenState();
}

class _AdminChatScreenState extends State<AdminChatScreen> {
  FirebaseService service = FirebaseService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('CustomSupport Chat'),
      ),
      body: Container(
        child: StreamBuilder<QuerySnapshot>(
            stream: service.messages
                .where('users', arrayContains: service.user.uid)
                .snapshots(),
            builder: (BuildContext context,
                AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Something went wrong');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              if (snapshot.data.docs.isEmpty) {
                return Center(child: Text('no chat data'));
              }
              return ListView(
                children:
                snapshot.data.docs.map((DocumentSnapshot document) {
                  Map<String, dynamic> data = document.data();
                  return AdminChatCard(
                    chatData: data,
                  );
                }).toList(),
              );
            }),
      ),
    );
  }
}
