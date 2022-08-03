import 'dart:async';
import 'dart:io';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_options.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:like_button/like_button.dart';
import 'package:marketplace_app/provider/cat_provider.dart';
import 'package:marketplace_app/provider/product_provider.dart';
import 'package:marketplace_app/services/DatabaseServices.dart';
import 'package:marketplace_app/services/firebase_service.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'chat/chat_conversation_screen.dart';

import 'package:url_launcher/url_launcher.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  _ProductDetailScreenState createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  bool loading = true;
  bool follower = false;

  FirebaseService service = FirebaseService();

  @override
  void initState() {
    Timer(Duration(seconds: 2), () {
      setState(() {
        loading = false;
      });
    });
    // TODO: implement initState
    super.initState();
  }

  // FirebaseService service = FirebaseService();

  bool _isFollowing = false;
  int followers = 0;
  int following = 0;
  bool isLikeAnimating = false;

  @override
  Widget build(BuildContext context) {
    convertToAgo(DateTime input) {
      Duration diff = DateTime.now().difference(input);

      if (diff.inDays >= 1) {
        return '${diff.inDays} d(s) ago';
      } else if (diff.inHours >= 1) {
        return '${diff.inHours} h(s) ago';
      } else if (diff.inMinutes >= 1) {
        return '${diff.inMinutes} m(s) ago';
      } else if (diff.inSeconds >= 1) {
        return '${diff.inSeconds} s(s) ago';
      } else {
        return 'just now';
      }
    }

    var productProvider = Provider.of<ProductProvider>(context);
    var data = productProvider.productData;
    List likeList = data['likes'];
    var date = DateTime.fromMicrosecondsSinceEpoch(data['postedAt']);
    var formatDate = DateFormat.yMMMd().format(date);
    Future<DocumentSnapshot<Map<String, dynamic>>> snap = FirebaseFirestore
        .instance
        .collection('users')
        .doc(service.user.uid)
        .get();

    Widget comment() {
      return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('products')
              .doc(data.id)
              .collection('comments')
              .orderBy('time')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: ListView(
                  physics: ScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  reverse: false,
                  children: snapshot.data.docs.map((DocumentSnapshot document) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  NetworkImage(document['userImage']),
                              radius: 30,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Column(
                              children: [
                                Text(
                                  document['name'],
                                  style: TextStyle(fontSize: 14.sp),
                                ),
                                SizedBox(
                                  height: 1.h,
                                ),
                                Text(
                                  convertToAgo(
                                      DateTime.fromMicrosecondsSinceEpoch(
                                          document['time'])),
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 0.8.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 4.w),
                          child: Text(
                            document['comment'],
                            style: TextStyle(fontSize: 15.sp),
                          ),
                        ),
                        Divider(),
                      ],
                    );
                  }).toList(),
                ),
              );
            }
          });
    }

    openwhatsapp() async {
      var whatsapp = data['phone'];
      var whatsappURlAndroid =
          "whatsapp://send?phone=" + whatsapp + "&text=hello";
      var whatappURLIos = "https://wa.me/$whatsapp?text=${Uri.parse("hello")}";
      if (Platform.isIOS) {
        // for iOS phone only
        if (await canLaunch(whatappURLIos)) {
          await launch(whatappURLIos, forceSafariVC: false);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("whatsapp no installed")));
        }
      } else {
        // android , web
        if (await canLaunch(whatsappURlAndroid)) {
          await launch(whatsappURlAndroid);
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("whatsapp no installed")));
        }
      }
    }

// GeoPoint location = productProvider.sellerDetails['location'];

    createChatRoom(ProductProvider productProvider) {
      Map product = {
        'productId': productProvider.productData.id,
        'productImage': productProvider.productData['image'][0],
        'price': productProvider.productData['price'],
        'seller': productProvider.productData['sellerUid']
      };
      List<String> users = [
        productProvider.productData['sellerUid'],
        service.user.uid,
      ];
      String chatRoomId =
          '${productProvider.productData['sellerUid']}.${service.user.uid}.${productProvider.productData.id}';
      //String receiverId = productProvider.productData['sellerUid'];

      String receiverId = productProvider.productData['sellerUid'];
      String senderId = service.user.uid;


      Map<String, dynamic> chatData = {
        'users': users,
        'chatRoomId': chatRoomId,
        'read': false,
        'product': product,
        'lastChat': null,
        'lastChatTime': DateTime.now().microsecondsSinceEpoch,
      };
      service.createChatRoom(
        chatData: chatData,
      );
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => ConversationScreen(
                    chatRoomId: chatRoomId,
                  )));
    }

    final List<dynamic> imageList = data['image'];

    /// ///////////////////////////////////////////////
    final List<Widget> imageSliders = imageList
        .map((data) => Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(4.0)),
                child: Image.network(
                  data,
                  width: double.infinity,
                  fit: BoxFit.fill,
                  loadingBuilder: (BuildContext ctx, Widget child,
                      ImageChunkEvent loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        value: loadingProgress.expectedTotalBytes != null
                            ? loadingProgress.cumulativeBytesLoaded /
                                loadingProgress.expectedTotalBytes
                            : null,
                      ),
                    );
                  },
                  errorBuilder: (
                    BuildContext context,
                    Object exception,
                    StackTrace stackTrace,
                  ) {
                    return const Text(
                      'Oops!! An error occurred. 😢',
                      style: TextStyle(fontSize: 16.0),
                    );
                  },
                ),
              ),
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0.0,
        centerTitle: true,
        title: Image.asset(
          'assets/icons/logo.png',
          height: 4.5.h,
          color: Theme.of(context).splashColor,
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 3.0.w, left: 3.w),
            child: LikeButton(
              size: 35,
              circleColor:
                  CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
              bubblesColor: BubblesColor(
                dotPrimaryColor: Color(0xff33b5e5),
                dotSecondaryColor: Color(0xff0099cc),
              ),
              likeBuilder: (bool isLiked) {
                return IconButton(
                  icon: Icon(
                    Icons.star_border,
                    color: follower ? Colors.deepPurpleAccent : Colors.grey,
                    size: 30,
                  ),
                  onPressed: () {
                    setState(() {
                      follower = !follower;
                    });
                    service.updateFolowers(follower, data.id, context);
                  },
                );
              },
              // likeCount: 665,
              countBuilder: (int count, bool isLiked, String text) {
                var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
                Widget result;
                if (count == 0) {
                  result = Text(
                    "love",
                    style: TextStyle(color: color, fontSize: 10),
                  );
                } else {
                  result = Text(
                    text,
                    style: TextStyle(color: color, fontSize: 10),
                  );
                }
                return result;
              },
            ),
          ),
        ],
      ),
      body: ListView(children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          height: 23.h,
          child: FlutterCarousel(
              items: imageSliders,
              options: CarouselOptions(
                height: 400.0,
                aspectRatio: 16 / 9,
                viewportFraction: 1.0,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: false,
                autoPlayInterval: const Duration(seconds: 2),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: false,
                //  onPageChanged: callbackFunction,
                pageSnapping: true,
                scrollDirection: Axis.horizontal,
                pauseAutoPlayOnTouch: true,
                pauseAutoPlayOnManualNavigate: true,
                pauseAutoPlayInFiniteScroll: false,
                enlargeStrategy: CenterPageEnlargeStrategy.scale,
                disableCenter: false,
                showIndicator: true,
                // slideIndicator: CircularSlideIndicator(),
              )),
        ),
        SizedBox(
          height: 0.5.h,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(Icons.remove_red_eye_rounded),
                  SizedBox(
                    width: 1.w,
                  ),
                  Text('${data['PostView'].length}'),
                ],
              ),
              Text(convertToAgo(date)),
            ],
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.all(2.h),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                '${data['price']} QAR',
                style: TextStyle(fontSize: 17.sp),
              ),
              SizedBox(
                height: 1.h,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Theme.of(context).primaryColor == Colors.white
                      ? Colors.grey[300].withOpacity(0.8)
                      : Colors.grey[800].withOpacity(0.7),
                ),
                height: 17.5.h,
                width: 100.w,
                child: FutureBuilder<DocumentSnapshot>(
                    future: FirebaseFirestore.instance
                        .collection('users')
                        .doc(data['sellerUid'])
                        .get(),
                    builder: (BuildContext context,
                        AsyncSnapshot<DocumentSnapshot> snapshot) {
                      if (snapshot.data == null) {
                        return Container();
                      }

                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(
                              Theme.of(context).primaryColor),
                        ));
                      }
                      List followerList = snapshot.data['followers'];
                      return Row(
                        children: [
                          SizedBox(
                            width: 3.w,
                          ),
                          CircleAvatar(
                            radius: 40,
                            backgroundColor:
                                Theme.of(context).primaryColor == Colors.white
                                    ? Color(0xffF0F0F0)
                                    : Color(0xffF0F0F0),
                            backgroundImage:
                                NetworkImage(snapshot.data['imageUrl']) ??
                                    Icon(Icons.person),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(
                                height: 2.h,
                              ),
                              Text(
                                snapshot.data['name'],
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              Text(
                                'Follower ${snapshot.data['followers'].length}',
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              SizedBox(
                                height: 0.5.h,
                              ),
                              Text(
                                data['phone'],
                                style: TextStyle(fontSize: 14.sp),
                              ),
                              SizedBox(
                                height: 2.h,
                              ),
                              Row(
                                children: [
                                  followerList.contains(
                                          FirebaseAuth.instance.currentUser.uid)
                                      ? GestureDetector(
                                          onTap: () async {
                                            await service.followUser(
                                              FirebaseAuth
                                                  .instance.currentUser.uid,
                                              data['sellerUid'],
                                            );

                                            setState(() {
                                              _isFollowing = false;
                                              followers--;
                                            });
                                          },
                                          child: Container(
                                            height: 4.h,
                                            width: 24.w,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Theme.of(context)
                                                      .shadowColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            child: Center(
                                              child: Text("Unfollow"),
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () async {
                                            await service.followUser(
                                              FirebaseAuth
                                                  .instance.currentUser.uid,
                                              data['sellerUid'],
                                            );

                                            setState(() {
                                              _isFollowing = true;
                                              followers++;
                                            });
                                          },
                                          child: Container(
                                            height: 4.h,
                                            width: 24.w,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10),
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Theme.of(context)
                                                      .shadowColor,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(6)),
                                            child: Center(
                                              child: Text("Follow"),
                                            ),
                                          ),
                                        ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      await FlutterPhoneDirectCaller.callNumber(
                                          data['phone']);
                                    },
                                    child: Container(
                                      height: 4.h,
                                      width: 20.w,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                            color:
                                                Theme.of(context).shadowColor,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(6)),
                                      child: Center(child: Text('Contact')),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      );
                    }),
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 8.5.h,
                    width: 29.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor == Colors.white
                          ? Colors.grey[300].withOpacity(0.8)
                          : Colors.grey[800].withOpacity(0.7),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 3.w, right: 3.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'Category',
                            style: TextStyle(
                              fontSize: 13.5.sp,
                              color:
                                  Theme.of(context).primaryColor == Colors.white
                                      ? Colors.grey[700].withOpacity(0.8)
                                      : Colors.grey[300].withOpacity(0.7),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(data['category'])
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 8.5.h,
                    width: 29.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor == Colors.white
                          ? Colors.grey[300].withOpacity(0.8)
                          : Colors.grey[800].withOpacity(0.7),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 3.w, right: 3.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'Add Type',
                            style: TextStyle(
                              fontSize: 13.5.sp,
                              color:
                                  Theme.of(context).primaryColor == Colors.white
                                      ? Colors.grey[700].withOpacity(0.8)
                                      : Colors.grey[300].withOpacity(0.7),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(data['adsType'])
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 8.5.h,
                    width: 29.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor == Colors.white
                          ? Colors.grey[300].withOpacity(0.8)
                          : Colors.grey[800].withOpacity(0.7),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 3.w, right: 3.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'City',
                            style: TextStyle(
                              fontSize: 13.5.sp,
                              color:
                                  Theme.of(context).primaryColor == Colors.white
                                      ? Colors.grey[700].withOpacity(0.8)
                                      : Colors.grey[300].withOpacity(0.7),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(data['area'])
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 8.5.h,
                    width: 29.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor == Colors.white
                          ? Colors.grey[300].withOpacity(0.8)
                          : Colors.grey[800].withOpacity(0.7),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 3.w, right: 3.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'Model',
                            style: TextStyle(
                              fontSize: 13.5.sp,
                              color:
                                  Theme.of(context).primaryColor == Colors.white
                                      ? Colors.grey[700].withOpacity(0.8)
                                      : Colors.grey[300].withOpacity(0.7),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          if (data['brand'] == 'other')
                            Text(data['customBrand']),
                          Text(data['brand']),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 8.5.h,
                    width: 29.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor == Colors.white
                          ? Colors.grey[300].withOpacity(0.8)
                          : Colors.grey[800].withOpacity(0.7),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 3.w, right: 3.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'Color',
                            style: TextStyle(
                              fontSize: 13.5.sp,
                              color:
                                  Theme.of(context).primaryColor == Colors.white
                                      ? Colors.grey[700].withOpacity(0.8)
                                      : Colors.grey[300].withOpacity(0.7),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(data['color'])
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 8.5.h,
                    width: 29.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor == Colors.white
                          ? Colors.grey[300].withOpacity(0.8)
                          : Colors.grey[800].withOpacity(0.7),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 3.w, right: 3.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'Condition',
                            style: TextStyle(
                              fontSize: 13.5.sp,
                              color:
                                  Theme.of(context).primaryColor == Colors.white
                                      ? Colors.grey[700].withOpacity(0.8)
                                      : Colors.grey[300].withOpacity(0.7),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(data['condition'])
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 1.h,
              ),
              if (data['category'] == 'Cars')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 9.h,
                      width: 29.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor == Colors.white
                            ? Colors.grey[300].withOpacity(0.8)
                            : Colors.grey[800].withOpacity(0.7),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 3.w, right: 3.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              'Km',
                              style: TextStyle(
                                fontSize: 13.5.sp,
                                color: Theme.of(context).primaryColor ==
                                        Colors.white
                                    ? Colors.grey[700].withOpacity(0.8)
                                    : Colors.grey[300].withOpacity(0.7),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(data['kmDriver'])
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 9.h,
                      width: 29.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor == Colors.white
                            ? Colors.grey[300].withOpacity(0.8)
                            : Colors.grey[800].withOpacity(0.7),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 3.w, right: 3.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              'Gear Type',
                              style: TextStyle(
                                fontSize: 13.5.sp,
                                color: Theme.of(context).primaryColor ==
                                        Colors.white
                                    ? Colors.grey[700].withOpacity(0.8)
                                    : Colors.grey[300].withOpacity(0.7),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(data['transmission'])
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 9.h,
                      width: 29.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor == Colors.white
                            ? Colors.grey[300].withOpacity(0.8)
                            : Colors.grey[800].withOpacity(0.7),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 3.w, right: 3.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              'No. of Owner',
                              style: TextStyle(
                                fontSize: 12.5.sp,
                                overflow: TextOverflow.ellipsis,
                                color: Theme.of(context).primaryColor ==
                                        Colors.white
                                    ? Colors.grey[700].withOpacity(0.8)
                                    : Colors.grey[300].withOpacity(0.7),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(data['noOfOwners'])
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: 1.h,
              ),
              if (data['category'] == 'Mobiles')
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      height: 9.h,
                      width: 29.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor == Colors.white
                            ? Colors.grey[300].withOpacity(0.8)
                            : Colors.grey[800].withOpacity(0.7),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 3.w, right: 3.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              'Sim',
                              style: TextStyle(
                                fontSize: 13.5.sp,
                                color: Theme.of(context).primaryColor ==
                                        Colors.white
                                    ? Colors.grey[700].withOpacity(0.8)
                                    : Colors.grey[300].withOpacity(0.7),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(data['sim'])
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 9.h,
                      width: 29.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor == Colors.white
                            ? Colors.grey[300].withOpacity(0.8)
                            : Colors.grey[800].withOpacity(0.7),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 3.w, right: 3.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              'Storage',
                              style: TextStyle(
                                fontSize: 13.5.sp,
                                color: Theme.of(context).primaryColor ==
                                        Colors.white
                                    ? Colors.grey[700].withOpacity(0.8)
                                    : Colors.grey[300].withOpacity(0.7),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(data['storage'])
                          ],
                        ),
                      ),
                    ),
                    Container(
                      height: 9.h,
                      width: 29.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor == Colors.white
                            ? Colors.grey[300].withOpacity(0.8)
                            : Colors.grey[800].withOpacity(0.7),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 3.w, right: 3.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              'Camera',
                              style: TextStyle(
                                fontSize: 13.5.sp,
                                color: Theme.of(context).primaryColor ==
                                        Colors.white
                                    ? Colors.grey[700].withOpacity(0.8)
                                    : Colors.grey[300].withOpacity(0.7),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(data['camera'])
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              if (data['category'] == 'Cars')
                if (data['category'] == 'Mobiles')
                  SizedBox(
                    height: 1.h,
                  ),
              SizedBox(
                height: 1.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (data['category'] == 'Cars')
                    Container(
                      height: 8.5.h,
                      width: 29.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).primaryColor == Colors.white
                            ? Colors.grey[300].withOpacity(0.8)
                            : Colors.grey[800].withOpacity(0.7),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 3.w, right: 3.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(
                              'Fuel Type',
                              style: TextStyle(
                                fontSize: 13.5.sp,
                                color: Theme.of(context).primaryColor ==
                                        Colors.white
                                    ? Colors.grey[700].withOpacity(0.8)
                                    : Colors.grey[300].withOpacity(0.7),
                              ),
                            ),
                            SizedBox(
                              height: 1.h,
                            ),
                            Text(data['fuel'])
                          ],
                        ),
                      ),
                    ),
                  Container(
                    height: 8.5.h,
                    width: 29.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).primaryColor == Colors.white
                          ? Colors.grey[300].withOpacity(0.8)
                          : Colors.grey[800].withOpacity(0.7),
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(left: 3.w, right: 3.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(
                            'Guarantee',
                            style: TextStyle(
                              fontSize: 13.5.sp,
                              color:
                                  Theme.of(context).primaryColor == Colors.white
                                      ? Colors.grey[700].withOpacity(0.8)
                                      : Colors.grey[300].withOpacity(0.7),
                            ),
                          ),
                          SizedBox(
                            height: 1.h,
                          ),
                          Text(data['guarantee'])
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 2.h,
              ),
              Text(
                'Description',
                style: TextStyle(
                    color: Theme.of(context).primaryColor == Colors.white
                        ? Colors.grey[700].withOpacity(0.8)
                        : Colors.grey[300].withOpacity(0.7),
                    fontSize: 17.sp),
              ),
              SizedBox(
                height: 1.h,
              ),
              Text(
                data['discretion'],
                style: TextStyle(fontSize: 15.sp),
              ),
            ]),
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xff1DA1F2),
                child: Image.asset('assets/social/twitter.png', height: 3.5.h),
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xff4867AA),
                child: Image.asset('assets/social/facebook.png', height: 3.5.h),
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xff56F074),
                child: Image.asset('assets/social/whatsapp.png', height: 3.h),
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: Color(0xffD33F72),
                child: Image.asset('assets/social/instagram.png', height: 3.h),
              ),
              CircleAvatar(
                radius: 18,
                backgroundColor: Colors.grey[700],
                child: Icon(Icons.more_vert_outlined),
              ),
              Container(
                height: 3.5.h,
                width: 17.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Theme.of(context).shadowColor)),
                child: Center(
                    child: Text(
                  'Report',
                  style: TextStyle(color: Colors.grey[400]),
                )),
              ),
              likeList.contains(service.user.uid)
                  ? GestureDetector(
                      onTap: () async {
                        await service.likePost(data.id,
                            FirebaseAuth.instance.currentUser.uid, context);
                        setState(() {
                          isLikeAnimating = false;
                        });
                      },
                      child: Container(
                        height: 3.5.h,
                        width: 20.w,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).shadowColor,
                            ),
                            borderRadius: BorderRadius.circular(6)),
                        child: Center(
                          child: Text("DisLike",
                              style: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                    )
                  : GestureDetector(
                      onTap: () async {
                        await service.likePost(data.id,
                            FirebaseAuth.instance.currentUser.uid, context);

                        setState(() {
                          isLikeAnimating = true;
                        });
                      },
                      child: Container(
                        height: 3.5.h,
                        width: 20.w,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            border: Border.all(
                              color: Theme.of(context).shadowColor,
                            ),
                            borderRadius: BorderRadius.circular(6)),
                        child: Center(
                          child: Text("Like",
                              style: TextStyle(color: Colors.grey[400])),
                        ),
                      ),
                    ),
            ],
          ),
        ),
        SizedBox(
          height: 3.h,
        ),
        comment(),
        SizedBox(
          height: 1.5.h,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Column(
            children: [
              Container(
                height: 10.h,
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor == Colors.white
                      ? Colors.grey[300].withOpacity(0.8)
                      : Colors.grey[800].withOpacity(0.7),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: TextField(
                  maxLines: 2,
                  controller: commentController,
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Enter Comment here...'),
                ),
              ),
              SizedBox(
                height: 1.h,
              ),
              InkWell(
                onTap: () {
                  addComment(data.id, commentController.text);
                  commentController.clear();
                },
                child: Container(
                  height: 6.h,
                  decoration: BoxDecoration(
                    color: Theme.of(context).shadowColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Center(
                      child: Text(
                    'Comment',
                    style:
                        TextStyle(fontSize: 15.sp, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ],
          ),
        ),
      ]),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).primaryColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: productProvider.productData['sellerUid'] == service.user.uid
              ? InkWell(
                  onTap: () {
                    // Navigator.pop(context);
                  },
                  child: Container(
                    height: 5.h,
                    width: 40.w,
                    decoration: BoxDecoration(
                      color: Theme.of(context).shadowColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 4.w,
                        ),
                        Text(
                          'Edit Product',
                          style: TextStyle(fontSize: 17, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                )
              : Padding(
                  padding: EdgeInsets.symmetric(horizontal: 1.8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 9.h,
                        width: 6.5.h,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () async {
                                await FlutterPhoneDirectCaller.callNumber(
                                    data['phone']);
                              },
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).shadowColor,
                                radius: 25,
                                child: Icon(
                                  CupertinoIcons.phone,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 0.2.h,
                            ),
                            Text(
                              'Call',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13.sp),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 9.h,
                        width: 6.5.h,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                createChatRoom(productProvider);
                              },
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).shadowColor,
                                radius: 25,
                                child: Icon(
                                  CupertinoIcons.chat_bubble,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 0.2.h,
                            ),
                            Text(
                              'Chat',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13.sp),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 9.h,
                        width: 6.5.h,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                Share.share('https://pub.dev/packages/share');
                              },
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).shadowColor,
                                radius: 25,
                                child: Icon(
                                  Icons.share,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 0.2.h,
                            ),
                            Text(
                              'Share',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13.sp),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 9.h,
                        width: 9.h,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                openwhatsapp();
                              },
                              child: CircleAvatar(
                                backgroundColor: Theme.of(context).shadowColor,
                                radius: 25,
                                child: Icon(
                                  Icons.whatsapp,
                                  color: Colors.green,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 0.2.h,
                            ),
                            Text(
                              'Whatsapp',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 13.sp),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  var commentController = TextEditingController();

  bool send = false;

  Future<void> addComment(String postId, String comment) async {
    String commentId = const Uuid().v1();
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection("users")
        .where('uid', isEqualTo: service.user.uid)
        .get();
    for (var element in snapshot.docs) {
      FirebaseFirestore.instance
          .collection('products')
          .doc(postId)
          .collection('comments')
          .doc(commentId)
          .set({
        'comment': comment,
        'userUid': service.user.uid,
        'time': DateTime.now().microsecondsSinceEpoch,
        'name': element['name'],
        'userImage': element['imageUrl'],
      });
    }
  }
}
//42.31