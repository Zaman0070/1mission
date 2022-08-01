import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:sizer/sizer.dart';

import '../product_details.dart';
import '../provider/cat_provider.dart';
import '../provider/product_provider.dart';
import '../services/firebase_service.dart';

class OtherUserProfile extends StatefulWidget {


  @override
  State<OtherUserProfile> createState() => _OtherUserProfileState();
}

class _OtherUserProfileState extends State<OtherUserProfile> {
  FirebaseService service = FirebaseService();
  bool _isFollowing = false;
  int followers = 0;
  int view = 0;
  bool isFollowing = false;







  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductProvider>(context, listen: false);
    var catProvider = Provider.of<CategoryProvider>(context);
    var dataa= catProvider.userDetails;
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        centerTitle: true,
        backgroundColor:  Theme.of(context).backgroundColor,
        elevation: 0,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),


      body: ListView(
        children: [
          Container(
            height: 24.h,
            width: 100.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              color: Theme.of(context).backgroundColor,
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 35,
                        backgroundImage: NetworkImage(dataa['imageUrl']),
                      ),
                      SizedBox(width: 4.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Text(
                            translate('followers'),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 0.7.h,
                          ),
                          Text(
                            '${ dataa['followers'].length}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(width: 4.w,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Text(
                            translate('following'),
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 0.7.h,
                          ),
                          Text(
                            '${dataa['following'].length}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 1.h),
                  Padding(
                    padding:  EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(dataa['name'],style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),
                  ),
                  SizedBox(height: 1.h),
                  Text(dataa['mobile'],style: TextStyle(fontSize: 14.sp),),

                  SizedBox(height: 1.5.h,),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: ()  {
                          Share.share('https://pub.dev/packages/share');
                        },
                        child: Container(
                          height: 5.h,
                          width: 18.w,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                Theme.of(context).shadowColor,
                              ),
                              borderRadius:
                              BorderRadius.circular(12)),
                          child: Center(
                            child: Icon(
                              Icons.share,
                              size: 27,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 3.w,),
                      GestureDetector(
                        onTap: () async {
                          await FlutterPhoneDirectCaller.callNumber(
                              dataa['phone']);
                        },
                        child: Container(
                          height: 5.h,
                          width: 18.w,
                          padding: EdgeInsets.symmetric(
                              horizontal: 10),
                          decoration: BoxDecoration(
                              border: Border.all(
                                color:
                                Theme.of(context).shadowColor,
                              ),
                              borderRadius:
                              BorderRadius.circular(12)),
                          child: Center(
                            child: Icon(
                              Icons.call,
                              size: 27,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 3.w,),
                      StreamBuilder(
                        stream: FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser.uid).snapshots(),
                        builder: (context,snapshot){
                          if (snapshot.hasError) {
                            return Text('Some things wronge');
                          }


                          List followerList =  snapshot.data['following'];
                          return   followerList.contains(dataa['uid'])
                              ?
                          GestureDetector(
                            onTap: () async {
                              await service
                                  .followUser(
                                  FirebaseAuth.instance.currentUser.uid,
                                  dataa['uid']
                              );

                              setState(() {
                                _isFollowing = false;
                                followers--;


                              });
                            },
                            child: Container(
                              height: 5.h,
                              width: 24.w,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                    Theme.of(context).shadowColor,
                                  ),
                                  borderRadius:
                                  BorderRadius.circular(12)),
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
                                dataa['uid'],
                              );

                              setState(() {
                                _isFollowing = true;
                                followers++;
                              });
                            },
                            child: Container(
                              height: 5.h,
                              width: 24.w,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                    Theme.of(context).shadowColor,
                                  ),
                                  borderRadius:
                                  BorderRadius.circular(12)),
                              child: Center(
                                child: Text(
                                    "Follow"
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          FutureBuilder<QuerySnapshot>(
            future: service.products
                .where('sellerUid', isEqualTo: dataa['uid'])
                .orderBy('postedAt')
                .get(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasError) {
                return Text('Some things wronge');
              }
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                    padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 40.h),
                    child: Center(child: CircularProgressIndicator())
                );
              }
              return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 300,
                      childAspectRatio: 2.3 / 1.8,
                      crossAxisSpacing: 0,
                      mainAxisSpacing: 10),

                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  itemCount: snapshot.data.size,
                  itemBuilder: (BuildContext context, int index) {
                    var data = snapshot.data.docs[index];
                    return InkWell(
                      onTap: () async {
                        await service
                            .postView(
                          FirebaseAuth.instance.currentUser.uid,
                          context,
                        );
                        setState(() {
                          isFollowing = true;
                          view++;
                        });
                        provider.getProductDetails(data);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) => ProductDetailScreen()));
                      },
                      child: Padding(
                        padding:  EdgeInsets.symmetric(horizontal: 3.w),
                        child: Column(
                          children: [
                            SizedBox(height: 1.h,),
                          Container(
                          height: 9.h,
                          width: 18.h,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.network(
                                data['image'][0],
                                fit: BoxFit.cover,
                              )),
                          ),
                            Text(data['brand'],
                                style: TextStyle(
                                    fontWeight: FontWeight.bold)),
                            Text(data['discretion'],
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,

                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 11.sp)),
                          ],
                        ),
                      ),
                    );
                    // return Column(
                    //   children: [
                    //     InkWell(

                    //       child: Column(
                    //         children: [

                    //           ),


                    //         ],
                    //       ),
                    //     ),
                    //   ],
                    // );
                  });
            },
          ),


        ],
      ),
    );
  }
}
