import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sizer/sizer.dart';


class NotificationScreen extends StatefulWidget {

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  List<Message> messagesList;

  getToken() {
    firebaseMessaging.getToken().then((deviceToken) {
      print('device Token : $deviceToken');
    });
  }

  configureFirebaseListener() {

    FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");

        if (message != null) {
          print("New Notification");
          _setMessage(message.data);
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    FirebaseMessaging.onMessage.listen(
          (RemoteMessage message) async {
        print('onMessage: $message');
        _setMessage(message.data);
      },
    );

    FirebaseMessaging.onMessageOpenedApp.listen(
          (RemoteMessage message) async {
        print('openMessage: $message');
        _setMessage(message.data);
      },
    );
    FirebaseMessaging.onBackgroundMessage(
          (RemoteMessage message) async {
        print('onResume: $message');
        _setMessage(message.data);
      },
    );
    firebaseMessaging.requestPermission(
    sound: true, badge: true, alert: true
    );
  }

  _setMessage(Map<String, dynamic> message) {
    final notification = message['notification'];
    final data = message['data'];
    final String title = message['title'];
    final String body = message['body'];
    String mMessage = message['message'];
    print("Title: $title, body: $body, message: $mMessage");
    setState(() {
      Message msg = Message(title, body, mMessage);
      messagesList.add(msg);
    });
  }

  @override
  void initState() {
    getToken();
    configureFirebaseListener();
    messagesList = List<Message>();
    // TODO: implement initState


    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme
            .of(context)
            .primaryColor
            .withOpacity(0.6),
        centerTitle: true,
        title: Text('Notifications'),
        elevation: 0,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 18.0),
            child: Center(child: Text('Edit',
              style: TextStyle(
                  fontSize: 14.sp
              ),
            )),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: null == messagesList ? 0 : messagesList.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                messagesList[index].message,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
  class Message {
  String title;
  String body;
  String message;
  Message(title, body, message) {
  this.title = title;
  this.body = body;
  this.message = message;
  }
}
