import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_app/chat/chat_card.dart';
import 'package:marketplace_app/pages/main_screen.dart';
import 'package:marketplace_app/services/firebase_service.dart';

import '../login.dart';
import '../sell_Items/sell_category_list.dart';

class ChatScreen extends StatefulWidget {
  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  FirebaseService service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      initialIndex: 0,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text('Chats'),
          bottom: TabBar(tabs: [
            Tab(
              text: 'All',
            ),
            Tab(text: 'Buying'),
            Tab(
              text: 'Selling',
            )
          ]),
        ),
        body: TabBarView(children: [
          Container(
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
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('No chat yet start'),
                        ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => MainScreen()));
                            },
                            child: Text('Contact Seller')),
                      ],
                    );
                  }
                  return ListView(
                    children:
                    snapshot.data.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data();
                      return ChatCard(
                        chatData: data,
                      );
                    }).toList(),
                  );
                }),
          ),
          Container(
            child: StreamBuilder<QuerySnapshot>(
                stream: service.messages
                    .where('users', arrayContains: service.user.uid)
                    .where('product.seller', isNotEqualTo: service.user.uid)
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
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('No ads buying yet'),
                        ElevatedButton(
                            onPressed: () {}, child: Text('Buy Product')),
                      ],
                    );
                  }
                  return ListView(
                    children:
                    snapshot.data.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data();
                      return ChatCard(
                        chatData: data,
                      );
                    }).toList(),
                  );
                }),
          ),
          Container(
            child: StreamBuilder<QuerySnapshot>(
                stream: service.messages
                    .where('users', arrayContains: service.user.uid)
                    .where('product.seller', isEqualTo: service.user.uid)
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
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('No Product Data'),
                        ElevatedButton(
                            onPressed: () {
                              StreamBuilder(
                                stream:
                                FirebaseAuth.instance.authStateChanges(),
                                builder: (context, snapShot) {
                                  if (snapShot.hasData) {
                                    return SellCategories();
                                  }
                                  return Login();
                                },
                              );
                            },
                            child: Text('Ad Product')),
                      ],
                    );
                  }
                  return ListView(
                    children:
                    snapshot.data.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data = document.data();
                      return ChatCard(
                        chatData: data,
                      );
                    }).toList(),
                  );
                }),
          ),
        ]),
      ),
    );
  }
}