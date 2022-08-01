import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_app/admin/about_product/list_Product.dart';
import 'package:marketplace_app/admin/about_user/user_List.dart';
import 'package:marketplace_app/admin/admin_chat/admin_chat_screen.dart';
import 'package:marketplace_app/admin/handle_ads/ads_handle.dart';
import 'package:marketplace_app/services/firebase_service.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../provider/cat_provider.dart';
import '../widget/add_images.dart';

class AdminScreen extends StatefulWidget {

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {

  bool  isShow = true;

  TextEditingController urlController = TextEditingController();

  _buildTextField(TextEditingController controller ){
    return Container(

      padding: EdgeInsets.symmetric(horizontal: 10,),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.3),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 13),
          border: InputBorder.none,
        ),
      ),
    );
  }
  FirebaseService service = FirebaseService();
  TabController controller;

  bool inService = false;

  @override
  Widget build(BuildContext context) {
    var catProvider = Provider.of<CategoryProvider>(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Theme.of(context).primaryColor == Colors.white
            ? Color(0xffF0F0F0)
            : Colors.black,
        appBar: AppBar(
          bottom:  TabBar(
            indicatorColor: Theme.of(context).splashColor,
            tabs: [
              Tab( text: 'Dashboard'),
              Tab( text: 'Manage')
            ],
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 0,
          title: Text('Admin Home'),
          centerTitle: true,
          automaticallyImplyLeading: false,
        ),
        body:  TabBarView(
          children: [
            Container(
              height: 100.h,
              width: 100.w,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap:(){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>UserList()));
                      },
                      child: Container(
                        height: 22.h,
                        width: 45.w,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor == Colors.white
                                ? Colors.grey[300]
                                : Colors.grey[900].withOpacity(1),
                            borderRadius: BorderRadius.circular(4)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Icon(Icons.person,size: 30,),
                            SizedBox(width: 4.h,),
                            Text('All Users',style: TextStyle(
                              fontSize: 16.sp
                            ),)
                          ],
                        ),

                      ),
                    ),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>ListProduct()));
                      },
                      child: Container(
                        height: 22.h,
                        width: 45.w,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor == Colors.white
                                ? Colors.grey[300]
                                : Colors.grey[900].withOpacity(1),
                            borderRadius: BorderRadius.circular(4)
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            Icon(Icons.category_outlined,size: 30,),
                            SizedBox(width: 4.h,),
                            Text('All Ads',style: TextStyle(
                                fontSize: 16.sp
                            ),)
                          ],
                        ),

                      ),
                    ),
                  ],
                ),
                    SizedBox(height: 1.h,),
                    InkWell(
                      onTap: (){
                        Navigator.push(context, MaterialPageRoute(builder: (_)=>AdminChatScreen()));
                      },
                      child: Container(
                        height: 22.h,
                        width: 45.w,
                        decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor == Colors.white
                                ? Colors.grey[300]
                                : Colors.grey[900].withOpacity(1),
                            borderRadius: BorderRadius.circular(4)
                        ),
                        child: Column(
                          children: [
                            SizedBox(height: 5.h,),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [

                                Icon(Icons.message_outlined,size: 30,),
                                SizedBox(height: 2.h,),
                                Text('Messages',style: TextStyle(
                                    fontSize: 16.sp
                                ),)
                              ],
                            ),
                          ],
                        ),

                      ),
                    )
                  ],
                ),
              )
            ),

            Container(
              height: 100.h,
              width: 100.w,
              child: Column(
                children: [
    StreamBuilder(
    stream: FirebaseFirestore.instance.collection('ads').snapshots(),
    builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
      if(snapshot.data==null){
        return Container();
      }
      return    snapshot.hasData?   Container(
      )
          :  InkWell(
        onTap:(){
          Navigator.push(context, MaterialPageRoute(builder: (_)=>HandlePost()));
        },
        child: Container(
          height: 9.h,
          width: 100.w,
          color: Theme.of(context).primaryColor == Colors.white
              ? Colors.white.withOpacity(0.7)
              : Colors.grey[900].withOpacity(0.7),
          child: Row(
            children: [
              SizedBox(
                width: 6.w,
              ),
              Container(
                height: 6.h,
                width: 6.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xff8F8E93),
                ),
                child: Image.asset(
                  'assets/more/adwords.png',
                  color: Colors.white,
                  height: 5,
                ),
              ),
              SizedBox(
                width: 8.w,
              ),
              Text(
                'Customise Add Ad',
                style: TextStyle(fontSize: 15.sp),
              )
            ],
          ),
        ),
      );

    }
    ),





                  FutureBuilder<QuerySnapshot>(
                    future: service.ads
                        .get(),
                    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                      if (snapshot.hasError) {
                        return Text('Some things wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Padding(
                            padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 40.h),
                            child: Center(child: CircularProgressIndicator())
                        );
                      }
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data.size,
                        itemBuilder: (BuildContext context , int index){
                          var data = snapshot.data.docs[index];
                         return InkWell(
                            splashColor: Color(0xff8E7FC0),
                            onTap: () {
                                urlController.text = data['url'];
                                showMaterialModalBottomSheet(
                                    backgroundColor:Color(0xff8E7FC0),
                                    shape:RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    context: context,
                                    builder: (context) {
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                                        child: ListView(
                                          children: [
                                            SizedBox(height: 2.h,),
                                            Center(child: Text('Update Product Details',
                                              style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.bold),

                                            )),
                                            SizedBox(height: 3.h,),
                                            Text('Url',style: TextStyle(fontSize: 16.sp),),
                                            SizedBox(height: 0.5.h,),
                                            _buildTextField(urlController,),


                                            Container(
                                                height: 18.h,
                                                child: AddImage()
                                            ),


                                            SizedBox(height: 1.h,),
                                            TextButton(
                                              onPressed: (){
                                                snapshot.data.docs[index].reference.update(
                                                    {
                                                      'url' : urlController.text,
                                                      if(catProvider.urlList.isNotEmpty)
                                                        'image' : catProvider.urlList,
                                                    }).whenComplete(() {
                                                  setState(() {
                                                    Navigator.pop(context);
                                                  });
                                                }
                                                );
                                              },

                                              child: Text('Update',style: TextStyle(color: Theme.of(context).primaryColor),),
                                              style: TextButton.styleFrom(
                                                  backgroundColor: Theme.of(context).splashColor
                                              ),
                                            ),
                                            SizedBox(height: 1.5.h,),
                                            TextButton(onPressed: (){
                                            deletePost( snapshot.data.docs[index].id);
                                            }, child: Text('Delete old ad Images',style: TextStyle(color: Colors.black),))
                                          ],
                                        ),
                                      );
                                    }
                                );

                            },
                            child: Container(
                              height: 9.h,
                              width: 100.w,
                              color: Theme.of(context).primaryColor == Colors.white
                                  ? Colors.white.withOpacity(0.7)
                                  : Colors.grey[900].withOpacity(0.7),
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 6.w,
                                  ),
                                  Container(
                                    height: 6.h,
                                    width: 6.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xff8F8E93),
                                    ),
                                    child: Image.asset(
                                      'assets/more/adwords.png',
                                      color: Colors.white,
                                      height: 5,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 8.w,
                                  ),
                                  Text(
                                    'Customise handle Ad',
                                    style: TextStyle(fontSize: 15.sp),
                                  )
                                ],
                              ),
                            ),
                          );
                        }


                      );
                    },
                  ),
                  // InkWell(
                  //   splashColor: Color(0xff8E7FC0),
                  //   onTap: () {
                  //     Navigator.push(context, MaterialPageRoute(builder: (_)=>HandlePost()));
                  //   },
                  //   child: Container(
                  //     height: 9.5.h,
                  //     width: 100.w,
                  //     color: Theme.of(context).primaryColor == Colors.white
                  //         ? Colors.white.withOpacity(0.8)
                  //         : Colors.grey[900].withOpacity(0.7),
                  //     child: Row(
                  //       children: [
                  //         SizedBox(
                  //           width: 6.w,
                  //         ),
                  //         Container(
                  //           height: 6.h,
                  //           width: 6.h,
                  //           decoration: BoxDecoration(
                  //             borderRadius: BorderRadius.circular(10),
                  //             color: Color(0xffA44037),
                  //           ),
                  //           child: Icon(
                  //             CupertinoIcons.plus,
                  //             color: Colors.white,
                  //           ),
                  //         ),
                  //         SizedBox(
                  //           width: 8.w,
                  //         ),
                  //         Text(
                  //          'Add Ads',
                  //           style: TextStyle(fontSize: 15.sp),
                  //         )
                  //       ],
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            )
          ],
        ),


      ),
    );
  }
  Future<void> deletePost(String postId) async {
    try {
      FirebaseFirestore.instance.collection('ads').doc(postId).delete();
    } catch (e) {
      print(e.toString());
    }
  }
}
