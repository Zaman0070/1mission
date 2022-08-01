import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:marketplace_app/home.dart';
import 'package:marketplace_app/navigation/navigation_add_data.dart';
import 'package:marketplace_app/pages/city.dart';
import 'package:marketplace_app/pages/more2.dart';
import 'package:marketplace_app/provider/cat_provider.dart';
import 'package:marketplace_app/provider/product_provider.dart';
import 'package:marketplace_app/widget/custom_page_transition_animation.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../navigation/navigation_profile.dart';
import '../services/firebase_service.dart';
import 'more.dart';

class MainScreen extends StatefulWidget {
  static const String id = 'main-Screen';

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Widget currentScreen = Home();

  int index = 0;

  final PageStorageBucket _bucket = PageStorageBucket();

  FirebaseService service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    var catProvider = Provider.of<CategoryProvider>(context);

    Color color = Theme.of(context).splashColor;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: WillPopScope(
        onWillPop: (){
          return Future.value(false);
        },
        child: ScrollConfiguration(
          behavior: ScrollBehavior(),
          child: GlowingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            color: Color(0xff675492),
            child: PageStorage(
              child: currentScreen,
              bucket: _bucket,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).canvasColor,
        shape: CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 9.h,
          width: 100.w,
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0,right: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  minWidth: 35,
                  onPressed: () {
                    setState(() {
                      index = 0;
                      currentScreen = Home();
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        index == 0 ? Icons.home : Icons.home_outlined,
                        color: index == 0 ? color : Colors.grey,
                      ),
                      Text(
                        translate('home'),
                        style: TextStyle(
                          color: index == 0 ? color : Colors.grey,
                          fontWeight: index == 0
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: 35,
                  onPressed: () {
                    setState(() {
                      index = 1;
                      currentScreen = City();
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        index == 1
                            ? MdiIcons.cityVariant
                            : MdiIcons.cityVariantOutline,
                        color: index == 1 ? color : Colors.grey,
                      ),
                      Text(
                        translate('city'),
                        style: TextStyle(
                          color: index == 1 ? color : Colors.grey,
                          fontWeight: index == 1
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                 Column(
                   children: [
                     InkWell(
                     onTap: () {
                      /// this button add for seller product
                      Navigator.of(context).push(
                        MyCustomAnimatedRoute(
                          enterWidget: NavigationAddData(),
                        ),
                      );
                    },
                       child: CircleAvatar(
                         backgroundColor: Theme.of(context).shadowColor,
                         radius: 25,
                         child: Padding(
                           padding: const EdgeInsets.all(9.0),
                           child: Image.asset('assets/plus.png',color: Colors.white,),
                         ),
                       ),
                     ),
                     SizedBox(height: 0.2.h,),
                     Text('New ad',style: TextStyle(fontSize: 12,color: Colors.grey),)
                   ],
                 ),
                MaterialButton(
                  minWidth: 35,
                  onPressed: () {
                    setState(() {
                      index = 2;
                      currentScreen = NavigationProfile();
                    });
                  },
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        index == 2
                            ? CupertinoIcons.person_alt
                            : CupertinoIcons.person,
                        color: index == 2 ? color : Colors.grey,
                      ),
                      Text(
                        translate('profile'),
                        style: TextStyle(
                          color: index == 2 ? color : Colors.grey,
                          fontWeight: index == 2
                              ? FontWeight.bold
                              : FontWeight.normal,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),

               FirebaseAuth.instance.currentUser == null ?
               MaterialButton(
                 minWidth: 35,
                 onPressed: () {
                   setState(() {
                     index = 3;
                     currentScreen = MoreWithoutUser();
                   });
                 },
                 child: Column(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Icon(
                       index == 3
                           ? Icons.more_horiz
                           : Icons.more_horiz_outlined,
                       color: index == 3 ? color : Colors.grey,
                     ),
                     Text(
                       translate('more'),
                       style: TextStyle(
                         color: index == 3 ? color : Colors.grey,
                         fontWeight: index == 3
                             ? FontWeight.bold
                             : FontWeight.normal,
                         fontSize: 10,
                       ),
                     ),
                   ],
                 ),
               ):
               FutureBuilder<DocumentSnapshot>(
                 future: service.getUserData(),
                 builder: (BuildContext context,
                     AsyncSnapshot<DocumentSnapshot> snapshot) {
                   if (snapshot.data == null) {
                     return CircleAvatar();
                   }
                   if (snapshot.hasError) {
                     return Text('Something went wrong');
                   }
                   if (snapshot.hasData && !snapshot.data.exists) {
                     return Text('Document does not exist');
                   }
                   return   MaterialButton(
                     minWidth: 35,
                     onPressed: () {
                       catProvider.userGetData(snapshot.data);
                       setState(() {
                         index = 3;
                         currentScreen = More();
                       });
                     },
                     child: Column(
                       mainAxisAlignment: MainAxisAlignment.center,
                       children: [
                         Icon(
                           index == 3
                               ? Icons.more_horiz
                               : Icons.more_horiz_outlined,
                           color: index == 3 ? color : Colors.grey,
                         ),
                         Text(
                           translate('more'),
                           style: TextStyle(
                             color: index == 3 ? color : Colors.grey,
                             fontWeight: index == 3
                                 ? FontWeight.bold
                                 : FontWeight.normal,
                             fontSize: 10,
                           ),
                         ),
                       ],
                     ),
                   );
                 },
               ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
