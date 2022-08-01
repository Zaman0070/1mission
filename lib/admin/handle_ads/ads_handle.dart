import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:marketplace_app/admin/admin_screen.dart';
import 'package:marketplace_app/pages/main_screen.dart';
import 'package:marketplace_app/sell_Items/sell_category_list.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../../provider/cat_provider.dart';
import '../../services/firebase_service.dart';
import '../../widget/add_images.dart';


class HandlePost extends StatefulWidget {
  @override
  _HandlePostState createState() => _HandlePostState();
}

class _HandlePostState extends State<HandlePost> with TickerProviderStateMixin {

  AnimationController animationController;
  Animation<double> animationText;
  FocusNode myFocusNode;


  void setUpAnimation(){
    animationController = AnimationController(vsync: this,duration: Duration(milliseconds: 300));
    animationText = Tween<double>(begin: 0,end: 90).animate(animationController);
  }

  void upDAteView(){
    setState(() {
      isShow = !isShow;
    });
   isShow ? animationController.forward() : animationController.reverse();
  }

  /// ////////////////////////////////
  bool backPressed = false;

  AnimationController controllerToIncreasingCurve;

  AnimationController controllerToDecreasingCurve;

  Animation<double> animationToIncreasingCurve;

  Animation<double> animationToDecreasingCurve;

  @override
  void initState() {
    controllerToIncreasingCurve = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    controllerToDecreasingCurve = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    );

    animationToIncreasingCurve = Tween<double>(begin: 500, end: 0).animate(
      CurvedAnimation(
        parent: controllerToIncreasingCurve,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    )..addListener(() {
      setState(() {});
    });

    animationToDecreasingCurve = Tween<double>(begin: 0, end: 200).animate(
      CurvedAnimation(
        parent: controllerToDecreasingCurve,
        curve: Curves.fastLinearToSlowEaseIn,
      ),
    )..addListener(() {
      setState(() {});
    });

    controllerToIncreasingCurve.forward();

    setUpAnimation();
    super.initState();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    controllerToIncreasingCurve.dispose();
    controllerToDecreasingCurve.dispose();
    animationController.dispose();
    super.dispose();
    myFocusNode.dispose();
  }


  final formKey = GlobalKey<FormState>();
  bool loading = false;
  int followers = 0;

  var type ;

  /// firebase service

  FirebaseService service = FirebaseService();

  /// textEditing controller
  TextEditingController urlController = TextEditingController();

  int pageIndex;
  int screenIndex = 0;
 // PageController _pageController = PageController(initialPage: 0);
  int langIndex = 0;
  String url;
  valid() {
    if (
        url.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('All fields must be required!')));
    } else {
      upDAteView();
    }
  }



  Future<void> updateUser(provider, context) {
    saveProductToDb(provider, context);
    //Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
  }

  Future<void> saveProductToDb(CategoryProvider provider, context) {
    return service.ads.add(provider.dataToFireStore).then((value) {
      provider.clearData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Success'),
        ),
      );
      Navigator.push(context, MaterialPageRoute(builder: (_) => MainScreen()));
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update location'),
        ),
      );
    });
  }


  validate(CategoryProvider provider) {
    if (formKey.currentState.validate()) {
      if (provider.urlList.isNotEmpty) {
        provider.dataToFireStore.addAll({
          'url':urlController.text,
          'image': provider.urlList,

        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Image not uploaded')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(translate('required'))),
      );
    }
  }

  @override
  void didChangeDependencies() {
    /// you get context did change dependency
    var catProvider = Provider.of<CategoryProvider>(context);
    setState(() {

      urlController.text = catProvider.dataToFireStore.isEmpty
          ? null
          : catProvider.dataToFireStore['url'];
    });

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  bool isShow = false;


  @override
  Widget build(BuildContext context) {
    var catProvider = Provider.of<CategoryProvider>(context);
    void showConfirmDialog() {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return Dialog(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      translate('confirm'),
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(translate('required')),
                    SizedBox(
                      height: 10,
                    ),
                    ListTile(
                      leading: Image.network(
                          catProvider.dataToFireStore['image'][0]),
                      title: Text(
                        catProvider.dataToFireStore['url'],
                        maxLines: 1,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        MaterialButton(
                          shape: Border.all(
                            color: Colors.black,
                          ),
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            setState(() {
                              loading = false;
                            });
                            Navigator.pop(context);
                          },
                          child: Text(translate('Cancel')),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        MaterialButton(
                          color: Theme.of(context).primaryColor,
                          onPressed: () {
                            updateUser(catProvider, context);
                          },
                          child: Text(
                            translate('confirm'),
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if (loading)
                      Center(
                          child: CircularProgressIndicator(
                        valueColor: AlwaysStoppedAnimation(
                            Theme.of(context).primaryColor),
                      )),
                  ],
                ),
              ),
            );
          });
    }



    return WillPopScope(
      onWillPop: () async {
        backPressed = true;
        controllerToDecreasingCurve.forward();
        return true;
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
          backPressed == false
              ? animationToIncreasingCurve.value
              : animationToDecreasingCurve.value,
        ),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            title: Text('Handle customise Ad'),
          ),
          resizeToAvoidBottomInset: false,
          body: Form(
            key: formKey,
            child: ListView(
              padding: EdgeInsets.only(left: 20,right: 15,top: 10),
              children: [
                SizedBox(
                  height: 5.5.h,
                ),
                Text('Add Photos',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),

                Container(

                    height: 22.h,
                    child: AddImage()),
                //Name
                SizedBox(
                  height: 0.5.h,
                ),
                //Price
                //Description Box
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      translate('Image Url'),
                      style: TextStyle(fontSize: 13.sp),
                    ),
                    SizedBox(
                      height: 0.5.h,
                    ),
                    Container(
                      height: 5.6.h,
                      width: 100.w,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.4),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        minLines: 1,
                        maxLines: 10,
                        controller: urlController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                          hintText:'Enter url',
                          hintStyle: TextStyle(color: Colors.white),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                InkWell(
                  onTap: () {
                    validate(catProvider);
                    if (catProvider.dataToFireStore.isNotEmpty) {
                      showConfirmDialog();
                    } else {
                      print('null');
                    }
                    print(catProvider.dataToFireStore);
                  },
                  child: Container(
                    height: 6.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Color(0xff8E7FC0),
                        borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text(
                        translate('publish'),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
