import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../change_mode.dart';
import '../navigation/navigation_add_data.dart';
import '../navigation/navigation_address.dart';
import '../navigation/navigation_chat.dart';
import '../navigation/navigation_myads.dart';
import '../provider/cat_provider.dart';
import '../services/firebase_service.dart';
import '../widget/select_language.dart';
import 'main_screen.dart';

class MoreWithoutUser extends StatefulWidget {

  @override
  State<MoreWithoutUser> createState() => _MoreWithoutUserState();
}

class _MoreWithoutUserState extends State<MoreWithoutUser> {
  FirebaseService service = FirebaseService();
  @override
  Widget build(BuildContext context) {
    var catProvider = Provider.of<CategoryProvider>(context);
    var userData = catProvider.userDetails;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor == Colors.white
          ? Color(0xffF0F0F0)
          : Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        toolbarHeight: 9.h,
        // backgroundColor: Theme.of(context).primaryColor == Colors.white ? Color(0xffF0F0F0) : Colors.black ,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 0.0,
        title: Text(
          translate('more'),
          style: TextStyle(fontWeight: FontWeight.w300),
        ),
        actions: [
          IconButton(
              onPressed: () {
              },
              icon: Icon(
                CupertinoIcons.bell,
                color: Colors.grey,
              )),
        ],
      ),
      body: ListView(
        children: [

          InkWell(
            splashColor: Color(0xff8E7FC0),
            onTap: () {

              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => NavigationAddData()));
            },
            child: Container(
              height: 9.5.h,
              width: 100.w,
              color: Theme.of(context).primaryColor == Colors.white
                  ? Colors.white.withOpacity(0.8)
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
                      color: Color(0xffA44037),
                    ),
                    child: Icon(
                      CupertinoIcons.plus,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    translate('addAdv'),
                    style: TextStyle(fontSize: 15.sp),
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 0.3.h,
            color: Theme.of(context).primaryColor == Colors.white
                ? Color(0xffF0F0F0)
                : Color(0xffF0F0F0),
          ),
          InkWell(
            splashColor: Color(0xff8E7FC0),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => NavigationMyAdd()));
            },
            child: Container(
              height: 9.h,
              width: 100.w,
              color: Theme.of(context).primaryColor == Colors.white
                  ? Colors.white.withOpacity(0.8)
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
                      color: Color(0xffF1961D),
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
                    translate('myAds'),
                    style: TextStyle(fontSize: 15.sp),
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 0.3.h,
            color: Theme.of(context).primaryColor == Colors.white
                ? Color(0xffF0F0F0)
                : Color(0xffF0F0F0),
          ),
          InkWell(
            splashColor: Color(0xff8E7FC0),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (_) => NavigationChat()));
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
                      color: Color(0xff026007),
                    ),
                    child: Icon(
                      CupertinoIcons.chat_bubble_text,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    translate('chat'),
                    style: TextStyle(fontSize: 15.sp),
                  )
                ],
              ),
            ),
          ),
          Divider(
            thickness: 2.h,
            height: 2.h,
            color: Theme.of(context).primaryColor == Colors.white
                ? Color(0xffF0F0F0)
                : Colors.black,
          ),
          InkWell(
            splashColor: Color(0xff8E7FC0),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => NavigationAddress()));
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
                      color: Color(0xffD376E4),
                    ),
                    child: Icon(
                      CupertinoIcons.globe,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    translate('address'),
                    style: TextStyle(fontSize: 15.sp),
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 0.3.h,
            color: Theme.of(context).primaryColor == Colors.white
                ? Color(0xffF0F0F0).withOpacity(0.7)
                : Color(0xffF0F0F0),
          ),
          // userData['mobile']=='+923177253921'?
          // InkWell(
          //   onTap: (){
          //       Navigator.push(context,
          //           MaterialPageRoute(builder: (_) => AdminScreen()));
          //   },
          //   child: Container(
          //     height: 9.h,
          //     width: 100.w,
          //     color: Theme.of(context).primaryColor == Colors.white
          //         ? Colors.white.withOpacity(0.7)
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
          //             color: Color(0xff8F8E93),
          //           ),
          //           child: Icon(
          //             CupertinoIcons.chat_bubble_2,
          //             color: Colors.white,
          //           ),
          //         ),
          //         SizedBox(
          //           width: 8.w,
          //         ),
          //         Text(
          //           translate('support'),
          //           style: TextStyle(fontSize: 15.sp),
          //         )
          //       ],
          //     ),
          //   ),
          // )
          //     :
          // FutureBuilder<QuerySnapshot>(
          //   future: service.users.where('mobile',isEqualTo: '+97466836772')
          //       .get(),
          //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //     if (snapshot.hasError) {
          //       return Text('Some things wronge');
          //     }
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return Padding(
          //           padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 40.h),
          //           child: Center(child: CircularProgressIndicator())
          //       );
          //     }
          //     return ListView.builder(
          //         shrinkWrap: true,
          //         physics: ScrollPhysics(),
          //         itemCount: snapshot.data.size,
          //         itemBuilder: (BuildContext context, int index) {
          //           var data = snapshot.data.docs[index];
          //
          //           return InkWell(
          //             onTap: (){
          //                 catProvider.userGetData(data);
          //                 Navigator.push(context,
          //                     MaterialPageRoute(builder: (_) => CustomSupportHelpCenter()));
          //             },
          //             child: Container(
          //               height: 9.h,
          //               width: 100.w,
          //               color: Theme.of(context).primaryColor == Colors.white
          //                   ? Colors.white.withOpacity(0.7)
          //                   : Colors.grey[900].withOpacity(0.7),
          //               child: Row(
          //                 children: [
          //                   SizedBox(
          //                     width: 6.w,
          //                   ),
          //                   Container(
          //                     height: 6.h,
          //                     width: 6.h,
          //                     decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(10),
          //                       color: Color(0xff8F8E93),
          //                     ),
          //                     child: Icon(
          //                       CupertinoIcons.chat_bubble_2,
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     width: 8.w,
          //                   ),
          //                   Text(
          //                     translate('support'),
          //                     style: TextStyle(fontSize: 15.sp),
          //                   )
          //                 ],
          //               ),
          //             ),
          //           );
          //         });
          //   },
          // ),





          // FutureBuilder<QuerySnapshot>(
          //   future: service.users.where('mobile',isEqualTo: '+923055510008')
          //       .get(),
          //   builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          //     if (snapshot.hasError) {
          //       return Text('Some things wronge');
          //     }
          //     if (snapshot.connectionState == ConnectionState.waiting) {
          //       return Padding(
          //           padding: EdgeInsets.only(left: 20.w, right: 20.w, bottom: 40.h),
          //           child: Center(child: CircularProgressIndicator())
          //       );
          //     }
          //     return ListView.builder(
          //         shrinkWrap: true,
          //         physics: ScrollPhysics(),
          //         itemCount: snapshot.data.size,
          //         itemBuilder: (BuildContext context, int index) {
          //           var data = snapshot.data.docs[index];
          //
          //           return InkWell(
          //             onTap: (){
          //               if(userData['mobile']=='+923177257921'){
          //                 Navigator.push(context,
          //                     MaterialPageRoute(builder: (_) => AdminScreen()));
          //               }
          //               else{
          //
          //                 catProvider.userGetData(data);
          //                 Navigator.push(context,
          //                     MaterialPageRoute(builder: (_) => CustomSupportHelpCenter()));
          //               }
          //             },
          //             child: Container(
          //               height: 9.h,
          //               width: 100.w,
          //               color: Theme.of(context).primaryColor == Colors.white
          //                   ? Colors.white.withOpacity(0.7)
          //                   : Colors.grey[900].withOpacity(0.7),
          //               child: Row(
          //                 children: [
          //                   SizedBox(
          //                     width: 6.w,
          //                   ),
          //                   Container(
          //                     height: 6.h,
          //                     width: 6.h,
          //                     decoration: BoxDecoration(
          //                       borderRadius: BorderRadius.circular(10),
          //                       color: Color(0xff8F8E93),
          //                     ),
          //                     child: Icon(
          //                       CupertinoIcons.chat_bubble_2,
          //                       color: Colors.white,
          //                     ),
          //                   ),
          //                   SizedBox(
          //                     width: 8.w,
          //                   ),
          //                   Text(
          //                     translate('support'),
          //                     style: TextStyle(fontSize: 15.sp),
          //                   )
          //                 ],
          //               ),
          //             ),
          //           );
          //         });
          //   },
          // ),

          Divider(
            thickness: 2.h,
            height: 2.h,
            color: Theme.of(context).primaryColor == Colors.white
                ? Color(0xffF0F0F0)
                : Colors.black,
          ),
          InkWell(
            splashColor: Color(0xff8E7FC0),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => SelectLanguage(),
                  ));
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
                      color: Color(0xffD376E4),
                    ),
                    child: Image.asset(
                      'assets/more/language.png',
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    translate('lang'),
                    style: TextStyle(fontSize: 15.sp),
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 0.3.h,
            color: Theme.of(context).primaryColor == Colors.white
                ? Color(0xffF0F0F0)
                : Color(0xffF0F0F0),
          ),
          InkWell(
            splashColor: Color(0xff8E7FC0),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ChangeMode()));
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
                      color: Color(0xff2FABDC),
                    ),
                    child: Image.asset(
                      'assets/more/mode.png',
                      color: Colors.white,
                      height: 5,
                    ),
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  Text(
                    translate('mode'),
                    style: TextStyle(fontSize: 15.sp),
                  )
                ],
              ),
            ),
          ),
          Divider(
            height: 0.3.h,
            color: Theme.of(context).primaryColor == Colors.white
                ? Color(0xffF0F0F0)
                : Color(0xffF0F0F0),
          ),
          Container(
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
                    color: Color(0xffF7030A),
                  ),
                  child: Image.asset(
                    'assets/more/shutdown.png',
                    color: Colors.white,
                    height: 5,
                  ),
                ),
                SizedBox(
                  width: 8.w,
                ),
                Text(
                  translate('Log in'),
                  style: TextStyle(fontSize: 15.sp),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
