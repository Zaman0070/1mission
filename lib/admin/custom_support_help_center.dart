import 'package:adobe_xd/pinned.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_app/admin/admin_chat/admin_conersation.dart';
import 'package:provider/provider.dart';

import 'package:sizer/sizer.dart';

import '../chat/chat_conversation_screen.dart';
import '../provider/cat_provider.dart';
import '../provider/product_provider.dart';
import '../services/firebase_service.dart';

class CustomSupportHelpCenter extends StatefulWidget {

  @override
  State<CustomSupportHelpCenter> createState() => _CustomSupportHelpCenterState();
}

class _CustomSupportHelpCenterState extends State<CustomSupportHelpCenter> {

  FirebaseService service = FirebaseService();




  



  @override
  Widget build(BuildContext context) {




    var catProvider = Provider.of<CategoryProvider>(context);
    createChatRoom(CategoryProvider catProvider) {
      Map admin = {
        'adminId':catProvider.userDetails.id,
        'aminImage':catProvider.userDetails['imageUrl'],
        'adminUid': catProvider.userDetails['uid']
      };
      List<String> users = [
        catProvider.userDetails['uid'],
        service.user.uid,
      ];
      String chatRoomId =
          '${ catProvider.userDetails['uid']}.${service.user.uid}.${ catProvider.userDetails.id}';
      Map<String, dynamic> chatData = {
        'users': users,
        'chatRoomId': chatRoomId,
        'read': false,
        'Admin': admin,
        'lastChat': null,
        'lastChatTime': DateTime.now().microsecondsSinceEpoch,
      };
      service.createChatRoom(
        chatData: chatData,
      );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => AdminChatConversation(
                chatRoomId: chatRoomId,
              )));
    }
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body:ListView(
          children: [
          Container(
          height: 24.h,
          width: 100.w,
          decoration: BoxDecoration(),
          child: Stack(
            children: [
              Pinned.fromPins(
                Pin(size: 180, end: 140.0),
                Pin(size: 100.0, middle: 0.65),
                child: Text(
                  'One Mission',
                  style: TextStyle(
                    fontSize: 24.sp
                  ),
                ),

              ),
              Pinned.fromPins(
                Pin(size: 250, start: 40.0),
                Pin(size: 100.0, middle: 1.2),
                child: Text(
                     "We're always glade to receive all of your question and feedback here ",

                ),

              ),
              Pinned.fromPins(
                  Pin(size: 4.h, end: 289.0), Pin(size: 30.0, middle: 0.1),
                  // Adobe XD layer: 'Ellipse 20' (shape)
                child: Container(
                    height: 5.h,
                    width: 5.h,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/icons/logo.png',)
                    ),
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(6),
                  ),
                   ),


              ),
              Pinned.fromPins(
                Pin(size: 3.5.h, end: 20.0), Pin(size: 30.0, middle: 0.05),
                // Adobe XD layer: 'Ellipse 20' (shape)
                child: Container(
                  height: 5.h,
                  width: 5.h,
                  child: IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.cancel_outlined,color: Colors.white,),
                  ),
                ),


              ),
              Pinned.fromPins(
                Pin(size: 35.0, end: 50.0),
                Pin(size: 35.0, middle: 0.2497),
                child:
                // Adobe XD layer: 'Ellipse 20' (shape)
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                    border: Border.all(
                      width: 6.0,
                      color: Theme.of(context).shadowColor,
                    ),
                  ),
                ),
              ),
              Pinned.fromPins(
                Pin(size: 28.0, end: 200.0),
                Pin(size: 28.0, middle: 0.2497),
                child:
                // Adobe XD layer: 'Ellipse 20' (shape)
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                    border: Border.all(
                      width: 4.0,
                      color: Theme.of(context).shadowColor.withOpacity(0.3),
                    ),
                  ),
                ),
              ),
              Pinned.fromPins(
                Pin(size: 27.0, middle: 0.23),
                Pin(size: 27.0, start: 26.0),
                child:
                // Adobe XD layer: 'Ellipse 21' (shape)
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                    border: Border.all(
                        width: 6.0, color: Theme.of(context).shadowColor),
                  ),
                ),
              ),
              Pinned.fromPins(
                Pin(size: 35.0, end: 100.0),
                Pin(size: 35.0, middle: 0.5),
                child:
                // Adobe XD layer: 'Ellipse 20' (shape)
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                    border: Border.all(
                        width: 6.0, color: Theme.of(context).shadowColor),
                  ),
                ),
              ),
              Pinned.fromPins(
                Pin(size: 20.0, middle: 0.90),
                Pin(size: 20.0, start: 160.0),
                child:
                // Adobe XD layer: 'Ellipse 21' (shape)
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                    border: Border.all(
                        width: 3.0, color: Theme.of(context).shadowColor),
                  ),
                ),
              ),
              Pinned.fromPins(
                Pin(size: 15.0, middle: 0.1),
                Pin(size: 15.0, start: 140.0),
                child:
                // Adobe XD layer: 'Ellipse 21' (shape)
                Container(
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.all(Radius.elliptical(9999.0, 9999.0)),
                    border: Border.all(
                        width: 3.0, color: Theme.of(context).shadowColor),
                  ),
                ),
              ),
            ],
          ),
        ),
            Container(
              height: 75.h,
              width: 100.w,
              decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(40),
                  topLeft: Radius.circular(40),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(30.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Start Conversation',
                      style: TextStyle(color: Colors.black,fontSize: 15.sp,fontWeight: FontWeight.w500),),
                    SizedBox(height: 5.h,),
                    Row(
                      children: [
                        Container(
                          height: 10.h,
                          width: 15.h,
                          child: Stack(
                            children: [
                              Pinned.fromPins(
                                Pin(size: 8.5.h, end: 289.0), Pin(size: 70.0, middle: 0.0),
                                // Adobe XD layer: 'Ellipse 20' (shape)
                                child:CircleAvatar(
                                  backgroundColor: Colors.amberAccent,
                                )

                              ),
                              Pinned.fromPins(
                                  Pin(size: 8.5.h, start: 50.0), Pin(size: 70.0, middle: 0.0),
                                  // Adobe XD layer: 'Ellipse 20' (shape)
                                  child:CircleAvatar(
                                    backgroundColor: Colors.red,
                                  )

                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 3.w,),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Our usual reply time',
                              style: TextStyle(color: Colors.grey,fontWeight: FontWeight.w500),),
                            SizedBox(height: 0.6.h,),
                            Row(
                              children: [
                                Icon(Icons.timer),
                                SizedBox(width: 2.w,),
                                Text('A few minutes',
                                  style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500),),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 4.h,),
                    InkWell(
                      onTap: (){
                        createChatRoom(catProvider);
                      },
                      child: Container(
                        height: 6.h,
                        width: 65.w,
                       decoration: BoxDecoration(
                         color: Theme.of(context).backgroundColor,
                         borderRadius: BorderRadius.circular(30),
                       ),
                        child: Padding(
                          padding:  EdgeInsets.symmetric(horizontal: 8.w),
                          child: Row(
                            children: [
                              Icon(Icons.send_outlined,color: Colors.white,),
                              SizedBox(width: 1.5.w,),
                              Text('Send us a message',
                              style: TextStyle(
                                fontSize: 13.sp,
                              ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),

                  ],
                ),
              ),// This trailing comma makes auto-formatting nicer for build methods.
            ),

  ]
      ) ,
    );
  }
}
