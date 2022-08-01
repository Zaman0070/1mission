import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_pop_up_menu/custom_pop_up_menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:marketplace_app/Constants/Constants.dart';
import 'package:marketplace_app/model/popup_menu_model.dart';
import 'package:marketplace_app/pages/city_screen.dart';
import 'package:marketplace_app/pages/main_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

import '../Initial Screens/language_screen.dart';
import '../provider/product_provider.dart';

class FirebaseService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  CollectionReference ads =
  FirebaseFirestore.instance.collection('ads');
  CollectionReference messages =
      FirebaseFirestore.instance.collection('messages');

  CollectionReference followers =
      FirebaseFirestore.instance.collection('flowers');
  CollectionReference following =
      FirebaseFirestore.instance.collection('following');

  User user = FirebaseAuth.instance.currentUser;

  FirebaseMessaging fcm = FirebaseMessaging.instance;




  Future<void> updateUser(Map<String, dynamic> data, context, screen) {
    return users.doc(user.uid).update(data).then((value) {
      // Navigator.pushNamed(context, screen);
      Navigator.push(context, MaterialPageRoute(builder: (_) => MainScreen()));
    });
  }

  Future<DocumentSnapshot> getUserData() async {
    // final fcmToken= await fcm.getToken();
    // final tokenRef =  usersRef
    //     .doc(FirebaseAuth.instance.currentUser.uid)
    //     .collection('tokens')
    //     .doc(fcmToken);
    // await tokenRef.set(
    //   TokenModel(token: fcmToken, createdAt: FieldValue.serverTimestamp())
    //       .toJson(),
    // );

    DocumentSnapshot doc = await users.doc(user.uid).get();
    return doc;
  }


   userData() async {
    DocumentSnapshot doc = await users.doc(user.uid).get();
    return doc;
  }



  Future<DocumentSnapshot> getSellerData(id) async {
    DocumentSnapshot doc = await users.doc(id).get();
    return doc;
  }

  Future<DocumentSnapshot> getProductDetails(id) async {
    DocumentSnapshot doc = await products.doc(id).get();
    return doc;
  }

  Future<DocumentSnapshot> getAdsData(id) async {
    DocumentSnapshot doc = await ads.doc(id).get();
    return doc;
  }


  Future<String>getAddress(lnt, long)async{
    String address='';

    List<Placemark> placemarks =  await placemarkFromCoordinates(lnt,long);

    Placemark place =placemarks[0];

    address =  '${place.street},${place.locality},${place.subLocality},${place.country}';

  }

  // TODO: uncomment in future
  createChatRoom({chatData}) {
    messages.doc(chatData['chatRoomId']).set(chatData).catchError((e) {
      print(e.toString());
    });
  }

  createChat(String chatRoomId, message) {
    messages.doc(chatRoomId).collection('chats').add(message).catchError((e) {
      print(e.toString());
    });
    messages.doc(chatRoomId).update({
      'lastChat': message['message'],
      'lastChatTime': message['time'],
      'read': false,
    });
  }

  getChat(chatRoomId) async {
    return messages
        .doc(chatRoomId)
        .collection('chats')
        .orderBy('time')
        .snapshots();
  }

  // delete chat method
  deleteChat(chatRoomId) async {
    return messages.doc(chatRoomId).delete();
  }

  popupMenu(chatData, context) {
    CustomPopupMenuController _controller = CustomPopupMenuController();
    List<PopupMenueModel> menuItems = [
      PopupMenueModel('Delete Chat', Icons.delete),
      PopupMenueModel('Mark as Sold', Icons.done),
    ];
    return CustomPopupMenu(
      child: Container(
        child: Icon(
          Icons.more_vert_sharp,
        ),
        padding: EdgeInsets.all(20),
      ),
      menuBuilder: () => ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Container(
          color: Colors.white,
          child: IntrinsicWidth(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: menuItems
                  .map(
                    (item) => GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: () {
                        if (item.title == 'Delete Chat') {
                          deleteChat(chatData['chatRoomId']);
                          _controller.hideMenu();
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text('Chat Deleted.'),
                          ));
                        }
                      },
                      child: Container(
                        height: 40,
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              item.icon,
                              size: 15,
                              color: Theme.of(context).primaryColor,
                            ),
                            Expanded(
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                padding: EdgeInsets.symmetric(vertical: 10),
                                child: Text(
                                  item.title,
                                  style: TextStyle(
                                    color: Theme.of(context).splashColor,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ),
      pressType: PressType.singleClick,
      verticalMargin: -10,
      controller: _controller,
    );
  }

  /// ////////////////////////////////////

  updateFolowers(follower, productId, context) {
    if (follower) {
      products.doc(productId).update({
        'follower': FieldValue.arrayUnion([user.uid]),
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('add to favourite')));
    } else {
      products.doc(productId).update({
        'follower': FieldValue.arrayRemove([user.uid])
      });
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('remove to favourite')));
    }
  }

  Future<void> followUser(
      String uid,
      String followId
      ) async {
    try {
      DocumentSnapshot snap = await FirebaseFirestore.instance.collection('users').doc(uid).get();
      List following = (snap.data() as dynamic)['following'];

      if(following.contains(followId)) {
        await FirebaseFirestore.instance.collection('users').doc(followId).update({
          'followers': FieldValue.arrayRemove([uid])
        });

        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'following': FieldValue.arrayRemove([followId])
        });
      } else {
        await FirebaseFirestore.instance.collection('users').doc(followId).update({
          'followers': FieldValue.arrayUnion([uid])
        });

        await FirebaseFirestore.instance.collection('users').doc(uid).update({
          'following': FieldValue.arrayUnion([followId])
        });
      }

    } catch(e) {
      print(e.toString());
    }
  }



  Future<void> postView(
      String followId,
      BuildContext context,
      ) async {
    try {
      var productProvider = Provider.of<ProductProvider>(context,listen: false);
      var data = productProvider.productData;
      DocumentSnapshot snap = await FirebaseFirestore.instance.collection('products').doc(data.id).get();
      List following = (snap.data() as dynamic)['PostView'];

      if(following.contains(followId)) {

      } else {
        await FirebaseFirestore.instance.collection('products').doc(data.id).update({
          'PostView': FieldValue.arrayUnion([FirebaseAuth.instance.currentUser.uid])
        });

      }

    } catch(e) {
      print(e.toString());
    }
  }

  Future<String> likePost(String postId, String uid, BuildContext context,) async {
    var productProvider = Provider.of<ProductProvider>(context,listen: false);
    var data = productProvider.productData;
    DocumentSnapshot snap = await FirebaseFirestore.instance.collection('products').doc(data.id).get();
    List likes = (snap.data() as dynamic)['likes'];
    try {
      if (likes.contains(uid)) {
        // if the likes list contains the user uid, we need to remove it
        FirebaseFirestore.instance.collection('products').doc(postId).update({
          'likes': FieldValue.arrayRemove([uid])
        });
      } else {
        // else we need to add uid to the likes array
        FirebaseFirestore.instance.collection('products').doc(postId).update({
          'likes': FieldValue.arrayUnion([uid])
        });
      }

    } catch (err) {
       err.toString();
    }
  }
}

// 24 min (23 video)