import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_app/admin/admin_chat/admin_conersation.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import '../../services/firebase_service.dart';

class AdminChatCard extends StatefulWidget {
  final Map<String, dynamic> chatData;
  AdminChatCard({this.chatData});

  @override
  State<AdminChatCard> createState() => _AdminChatCardState();
}

class _AdminChatCardState extends State<AdminChatCard> {

  FirebaseService service = FirebaseService();
  DocumentSnapshot doc;
  String lastChatDate = '';

  @override
  void initState() {
    getProductDetail();
    getChatTime();
    // TODO: implement initState
    super.initState();
  }

  getProductDetail(){
    service.getSellerData(service.user.uid).then((value) {
      setState(() {
        doc =value;
      });
    });
  }

  getChatTime(){
    var today = DateFormat.yMMMd().format(DateTime.fromMicrosecondsSinceEpoch(widget.chatData['lastChatTime']));
    var date = DateFormat.yMMMd().format(DateTime.fromMicrosecondsSinceEpoch(DateTime.now().microsecondsSinceEpoch));
    if(date==today){
      setState(() {
        lastChatDate = 'Today';
      });
    }else{
      setState(() {
        lastChatDate= date.toString();
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return  doc==null? Container() : Container(
      child: Stack(
        children: [
          ListTile(
            onTap: (){
              service.messages.doc(widget.chatData['chatRoomId']).update({
                'read' : 'true',
              });
              Navigator.push(context, MaterialPageRoute(builder: (_)=>AdminChatConversation(
                chatRoomId: widget.chatData['chatRoomId'],
              )));
            },
            leading: ClipRRect(
                borderRadius: BorderRadius.circular(6),
                child: Container(
                    height: 7.h,
                    width: 6.h,
                    child: Image.network(doc['imageUrl']))),
             title: Text(doc['name'],style: TextStyle(fontWeight: widget.chatData['read']== false ? FontWeight.bold: FontWeight.normal),),
             subtitle: Text(doc['mobile']),
            //trailing: service.popupMenu(widget.chatData, context),
          ),
          Positioned(
              right: 10,
              top: 5,
              child: Text(lastChatDate,style: TextStyle(fontSize: 10),))
        ],
      ),
      decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Theme.of(context).splashColor))
      ),
    );
  }
}
