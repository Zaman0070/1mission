import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:marketplace_app/product_details.dart';
import 'package:marketplace_app/provider/cat_provider.dart';
import 'package:marketplace_app/provider/product_provider.dart';
import 'package:marketplace_app/services/firebase_service.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../pages/other_user_ perfolie_screen.dart';

class FollowingScreen extends StatefulWidget {
  @override
  _FollowingScreenState createState() => _FollowingScreenState();
}

class _FollowingScreenState extends State<FollowingScreen> {
  FirebaseService service = FirebaseService();
  int followers = 0;
  bool _isFollowing = false;



  @override
  Widget build(BuildContext context) {

    var catProvider = Provider.of<CategoryProvider>(context);
    var dataa= catProvider.userDetails;
    List followerList = dataa['followers'];

    return  Scaffold(
      appBar: AppBar(
        title: Text('Following'),
        centerTitle: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 100.w,
          child: ListView.builder
            (
              itemCount: dataa['following'].length,
              itemBuilder: (BuildContext ctxt, int index) {
                return FutureBuilder<QuerySnapshot>(
                  future: service.users
                      .where('uid', isEqualTo: dataa['following'][index])
                      .get(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Some things wronge');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Padding(
                          padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 40.h),
                          child: Center(child: CircularProgressIndicator(color: Theme.of(context).scaffoldBackgroundColor))
                      );
                    }

                    return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data.size,
                        itemBuilder: (BuildContext contexy, int index) {
                          var data = snapshot.data.docs[index];
                          return  ListTile(
                            onTap: () {
                              catProvider.userGetData(data);
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (_) => OtherUserProfile()));
                            },
                            leading: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                    height: 6.h,
                                    width: 6.h,
                                    child: Image.network(
                                      data['imageUrl'],
                                      fit: BoxFit.cover,
                                    ))),
                            title: Text(data['mobile']),
                            trailing: followerList.contains( FirebaseAuth.instance.currentUser.uid)
                                ?
                            GestureDetector(
                              onTap: () async {
                                await service
                                    .followUser(
                                  FirebaseAuth.instance.currentUser.uid,
                                  data['uid'],
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
                                      color:
                                      Theme.of(context).shadowColor,
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(6)),
                                child: Center(
                                  child: Text(
                                      "Unfollow"
                                  ),
                                ),
                              ),
                            ):GestureDetector(
                              onTap: () async {
                                await service
                                    .followUser(
                                  FirebaseAuth.instance.currentUser.uid,
                                  data['uid'],
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
                                      color:
                                      Theme.of(context).shadowColor,
                                    ),
                                    borderRadius:
                                    BorderRadius.circular(6)),
                                child: Center(
                                  child: Text(
                                      "Follow"
                                  ),
                                ),
                              ),
                            ),


                          );



                          //  InkWell(
                          //   onTap: (){
                          //     catProvider.userGetData(data);
                          //     Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //             builder: (_) => OtherUserProfile()));
                          //   },
                          //   child: Padding(
                          //     padding: const EdgeInsets.only(left: 15,right: 12,top: 10,),
                          //     child: Column(
                          //       crossAxisAlignment: CrossAxisAlignment.start,
                          //       children: [
                          //         Row(
                          //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          //           children: [
                          //             CircleAvatar(
                          //               radius: 35,
                          //               backgroundImage: NetworkImage(data['imageUrl']),
                          //             ),
                          //             Text(data['name'],style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
                          //             SizedBox(width: 12.w,),
                          //
                          //
                          //             followerList.contains( FirebaseAuth.instance.currentUser.uid)
                          //                 ?
                          //             GestureDetector(
                          //               onTap: () async {
                          //                 await service
                          //                     .followUser(
                          //                   FirebaseAuth.instance.currentUser.uid,
                          //                   data['uid'],
                          //                 );
                          //
                          //                 setState(() {
                          //                   _isFollowing = false;
                          //                   followers--;
                          //
                          //                 });
                          //               },
                          //               child: Container(
                          //                 height: 4.h,
                          //                 width: 24.w,
                          //                 padding: EdgeInsets.symmetric(
                          //                     horizontal: 10),
                          //                 decoration: BoxDecoration(
                          //                     border: Border.all(
                          //                       color:
                          //                       Theme.of(context).shadowColor,
                          //                     ),
                          //                     borderRadius:
                          //                     BorderRadius.circular(6)),
                          //                 child: Center(
                          //                   child: Text(
                          //                       "Unfollow"
                          //                   ),
                          //                 ),
                          //               ),
                          //             ):GestureDetector(
                          //               onTap: () async {
                          //                 await service
                          //                     .followUser(
                          //                   FirebaseAuth.instance.currentUser.uid,
                          //                   data['uid'],
                          //                 );
                          //
                          //                 setState(() {
                          //                   _isFollowing = true;
                          //                   followers++;
                          //
                          //                 });
                          //               },
                          //               child: Container(
                          //                 height: 4.h,
                          //                 width: 24.w,
                          //                 padding: EdgeInsets.symmetric(
                          //                     horizontal: 10),
                          //                 decoration: BoxDecoration(
                          //                     border: Border.all(
                          //                       color:
                          //                       Theme.of(context).shadowColor,
                          //                     ),
                          //                     borderRadius:
                          //                     BorderRadius.circular(6)),
                          //                 child: Center(
                          //                   child: Text(
                          //                       "Follow"
                          //                   ),
                          //                 ),
                          //               ),
                          //             ),
                          //           ],
                          //         ),
                          //
                          //       ],
                          //     ),
                          //   ),
                          // );
                        });
                  },
                );
              }
          ),

        ),
      ),
    );
  }
}
