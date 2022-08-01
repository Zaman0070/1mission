import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:galleryimage/galleryimage.dart';
import 'package:marketplace_app/sell_Items/sell_category_list.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../pages/main_screen.dart';
import '../provider/cat_provider.dart';
import '../services/firebase_service.dart';
import '../widget/add_images.dart';

class FurnitureForm extends StatefulWidget {
  @override
  _FurnitureFormState createState() => _FurnitureFormState();
}

class _FurnitureFormState extends State<FurnitureForm> with TickerProviderStateMixin {
  bool isShow = false;
  AnimationController animationController;
  Animation<double> animationText;

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
  }

  @override
  void dispose() {
    controllerToIncreasingCurve.dispose();
    controllerToDecreasingCurve.dispose();
    animationController.dispose();
    super.dispose();
  }




  final formKey = GlobalKey<FormState>();
  bool loading = false;
  int followers = 0;

  /// firebase service

  FirebaseService service = FirebaseService();

  /// textEditing controller
  TextEditingController brandController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController descController = TextEditingController();
  TextEditingController conditionController = TextEditingController();
  TextEditingController guarntController = TextEditingController();
  TextEditingController areaController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController addTypeController = TextEditingController();
  TextEditingController customBrandController = TextEditingController();

  int pageIndex;
  int screenIndex = 0;
  PageController _pageController = PageController(initialPage: 0);
  int langIndex = 0;
  String a, s, sc, t, ti, con, gur, col, k, c;
  valid() {
    if (a.isEmpty ||
        t.isEmpty ||
        con.isEmpty ||
        gur.isEmpty ||
        col.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('All feilds must be required!')));
    } else {
      upDAteView();
    }
  }

  Future<void> updateUser(provider, context) {
    saveProductToDb(provider, context);
    //Navigator.push(context, MaterialPageRoute(builder: (_)=>HomeScreen()));
  }

  Future<void> saveProductToDb(CategoryProvider provider, context) {
    return service.products.add(provider.dataToFireStore).then((value) {
      provider.clearData();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'We have received your products and will be notified to get approved'),
        ),
      );
      //Navigator.pushReplacementNamed(context, MainScreen.id);
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
          'category': provider.selectedCategory,
          // 'subCategory': provider.selectedSubCategory,
          'brand': brandController.text,
          'customBrand': customBrandController.text,
          'price': priceController.text,
          'condition': conditionController.text,
          'discretion': descController.text,
          'sellerUid': service.user?.uid,
          'phone': service.user.phoneNumber,
          'image': provider.urlList,
          'area': areaController.text,
          'adsType': addTypeController.text,
          'guarantee': guarntController.text,
          'color': colorController.text,
          'postedAt': DateTime.now().microsecondsSinceEpoch,
          'PostView': [],
          'follower':[],
          'likes':[],
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

  List<String> condition(BuildContext context) => [
        translate('usedPerfect'),
        translate('usedGood'),
        translate('usedNotWorking'),
      ];
  List<String> guarantee(BuildContext context) => [
        translate('yes'),
        translate('no'),
      ];
  List<String> colorList(BuildContext context) => [
        'White',
        'Black',
        'Gray',
        'Silver',
        'Red',
        'Blue',
        'Brown',
        'Green',
        'Beige',
        'Orange',
        'Gold',
        'Yellow',
        'Purple',
      ];
  List<String> addType(BuildContext context) => [
    'Sale',
    'Rent',
  ];
  List<String> area(BuildContext context) =>
      ["Sana'a", 'Aden', 'Ibb', 'Taizz', 'Marib', 'Hadramont'];
  List<String> gurantee(BuildContext context) => [
        translate('yes'),
        translate('no'),
      ];

  @override
  void didChangeDependencies() {
    /// you get context did change dependency
    var catProvider = Provider.of<CategoryProvider>(context);
    setState(() {
      brandController.text = catProvider.dataToFireStore.isEmpty
          ? null
          : catProvider.dataToFireStore['brand'];
      //noOfOwnerController.text = catProvider.dataToFireStore.isEmpty ? "" : catProvider.dataToFireStore['NoOfOwner'];
      descController.text = catProvider.dataToFireStore.isEmpty
          ? null
          : catProvider.dataToFireStore['description'];
      conditionController.text = catProvider.dataToFireStore.isEmpty
          ? null
          : catProvider.dataToFireStore['condition'];
      areaController.text = catProvider.dataToFireStore.isEmpty
          ? null
          : catProvider.dataToFireStore['area'];
      guarntController.text = catProvider.dataToFireStore.isEmpty
          ? null
          : catProvider.dataToFireStore['guarantee'];
      colorController.text = catProvider.dataToFireStore.isEmpty
          ? null
          : catProvider.dataToFireStore['color'];
      addTypeController.text = catProvider.dataToFireStore.isEmpty
          ? null
          : catProvider.dataToFireStore['adsType'];
      customBrandController.text = catProvider.dataToFireStore.isEmpty
          ? null
          : catProvider.dataToFireStore['customBrand'];
    });

    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    var catProvider = Provider.of<CategoryProvider>(context);

    // void showConfirmDialog() {
    //   showDialog(
    //       context: context,
    //       builder: (BuildContext context) {
    //         return Dialog(
    //           child: Padding(
    //             padding: const EdgeInsets.all(20.0),
    //             child: Column(
    //               crossAxisAlignment: CrossAxisAlignment.start,
    //               mainAxisSize: MainAxisSize.min,
    //               children: [
    //                 Text(
    //                   translate('confirm'),
    //                   style:
    //                       TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //                 ),
    //                 SizedBox(
    //                   height: 10,
    //                 ),
    //                 Text(translate('sure')),
    //                 SizedBox(
    //                   height: 10,
    //                 ),
    //                 ListTile(
    //                   leading: Image.network(
    //                       catProvider.dataToFireStore['image'][0]),
    //                   title: Text(
    //                     catProvider.dataToFireStore['discretion'],
    //                     maxLines: 1,
    //                   ),
    //                   subtitle: Text(catProvider.dataToFireStore['price']),
    //                 ),
    //                 SizedBox(
    //                   height: 20,
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.end,
    //                   children: [
    //                     MaterialButton(
    //                       shape: Border.all(
    //                         color: Colors.black,
    //                       ),
    //                       color: Theme.of(context).primaryColor,
    //                       onPressed: () {
    //                         setState(() {
    //                           loading = false;
    //                         });
    //                         Navigator.pop(context);
    //                       },
    //                       child: Text(translate('cancel')),
    //                     ),
    //                     SizedBox(
    //                       width: 10,
    //                     ),
    //                     MaterialButton(
    //                       color: Theme.of(context).primaryColor,
    //                       onPressed: () {
    //                         updateUser(catProvider, context);
    //                       },
    //                       child: Text(
    //                         translate('confirm'),
    //                         style: TextStyle(color: Colors.white),
    //                       ),
    //                     ),
    //                   ],
    //                 ),
    //                 SizedBox(
    //                   height: 20,
    //                 ),
    //                 if (loading)
    //                   Center(
    //                       child: CircularProgressIndicator(
    //                     valueColor: AlwaysStoppedAnimation(
    //                         Theme.of(context).primaryColor),
    //                   )),
    //               ],
    //             ),
    //           ),
    //         );
    //       });
    // }

    Widget _appBar( fieldValue) {
      return AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor:Theme.of(context).primaryColor == Colors.white
            ? Colors.white.withOpacity(0.8)
            : Colors.black,
        automaticallyImplyLeading: false,
        //centerTitle: true,
        title: Text(
          fieldValue,
          style: TextStyle(fontSize: 15.sp),
        ),
        leading:   IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Icon(Icons.arrow_back_ios)),
      );
    }

    Widget brandList(){
      showMaterialModalBottomSheet(
          backgroundColor: Theme.of(context).primaryColor == Colors.white
              ? Colors.white
              : Colors.black,
          shape:RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          context: context,
          builder: (context) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _appBar( 'Choose Categories'),
                Expanded(
                  child: ListView.builder(
                      itemCount: catProvider.doc['models'].length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: ListTile(
                            onTap: () {
                              setState(() {
                                brandController.text =
                                catProvider.doc['models'][index];
                              });
                              Navigator.pop(context);
                            },
                            title: Row(
                              children: [
                                CircleAvatar(
                                  radius: 7,
                                  backgroundColor: Colors.grey[700].withOpacity(0.6),
                                ),
                                SizedBox(width: 4.w,),
                                Text(
                                  catProvider.doc['models'][index],
                                ),
                              ],
                            ),
                          ),
                        );
                      }),
                ),
              ],
            );
          }
      );
    }
    Widget smalBottomSheet({ list, textController}){
      showMaterialModalBottomSheet(
        backgroundColor: Theme.of(context).primaryColor == Colors.white
            ? Colors.white
            : Colors.black,
        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        context: context,
        builder: (context) {
          return  ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: list.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ListTile(
                    onTap: () {
                      /// return back
                      Navigator.pop(context);
                      textController.text = list[index];
                    },
                    title: Row(
                      children: [
                        CircleAvatar(
                          radius: 7,
                          backgroundColor: Colors.grey[700].withOpacity(0.6),

                        ),
                        SizedBox(width: 3.w,),
                        Text(list[index]),
                      ],
                    ),
                  ),
                );
              });
        },
      );
    }

    Widget bottomSheet({fieldValue, list, textController}){
      showMaterialModalBottomSheet(


        shape:RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        context: context,
        builder: (context) {
          return Scaffold(
            backgroundColor: Theme.of(context).primaryColor == Colors.white
                ? Colors.white
                : Colors.black,
            appBar: _appBar(fieldValue),
            body: ListView.builder(
                scrollDirection: Axis.vertical,
                itemCount: list.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: ListTile(
                      onTap: () {
                        /// return back
                        Navigator.pop(context);
                        textController.text = list[index];
                      },
                      title: Row(
                        children: [
                          CircleAvatar(
                            radius: 7,
                            backgroundColor: Colors.grey[700].withOpacity(0.6),

                          ),
                          SizedBox(width: 3.w,),
                          Text(list[index]),
                        ],
                      ),
                    ),
                  );
                }),
          );
        },
      );
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
          resizeToAvoidBottomInset: false,
          body: Form(
            key: formKey,
            child:  AnimatedBuilder(
                animation: animationController,
              builder: (context, _) {
                return Stack(
                  children: [
                    AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        width: 88.w,
                        height: 100.h,
                        left: isShow ? -76.w : 0,
                        child: Container(
                          color: Color(0xff8E7FC0),
                          child: Padding(
                            padding: EdgeInsets.all(20.0),
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Area',
                                            style: TextStyle(fontSize: 13.sp),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              smalBottomSheet(
                                               // fieldValue: 'Choose the Area',
                                                list: area(context),
                                                textController: areaController,
                                              );
                                            },
                                            child: Container(
                                              height: 6.h,
                                              width: 30.w,
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.3),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: TextFormField(
                                                enabled: false,
                                                controller: areaController,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return translate('required');
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  EdgeInsets.symmetric(horizontal: 8),
                                                  hintText: 'Choose Area',
                                                  hintStyle: TextStyle(color: Colors.black),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 2.h,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Condition',
                                            style: TextStyle(fontSize: 13.sp),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              smalBottomSheet(
                                             //   fieldValue: 'Choose Condition',
                                                list: condition(context),
                                                textController: conditionController,
                                              );

                                            },
                                            child: Container(
                                              height: 6.h,
                                              width: 37.5.w,
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.3),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: TextFormField(
                                                enabled: false,
                                                controller: conditionController,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return translate('required');
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  EdgeInsets.symmetric(horizontal: 8),
                                                  hintText: 'Condition',
                                                  hintStyle: TextStyle(color: Colors.black),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Furniture Type',
                                        style: TextStyle(fontSize: 13.sp),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      InkWell(
                                        onTap: () {

                                          brandList();
                                        },
                                        child: Container(
                                          height: 6.h,
                                          width: 72.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.3),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: TextFormField(
                                            enabled: false,
                                            controller: brandController,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return translate('required');
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              contentPadding:
                                              EdgeInsets.symmetric(horizontal: 8),
                                              hintText: 'Choose Furniture type',
                                              hintStyle: TextStyle(color: Colors.black),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  if(brandController.text == 'other Furniture')
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Furniture Type',
                                          style: TextStyle(fontSize: 13.sp),
                                        ),
                                        SizedBox(
                                          height: 1.h,
                                        ),
                                        Container(
                                          height: 6.h,
                                          width: 72.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.3),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: TextFormField(
                                            controller: customBrandController,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return translate('required');
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              contentPadding:
                                              EdgeInsets.symmetric(horizontal: 8),
                                              hintText: 'Furniture type',
                                              hintStyle: TextStyle(color: Colors.black),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Ad Type',
                                            style: TextStyle(fontSize: 13.sp),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              smalBottomSheet(
                                              //  fieldValue: 'Choose Ad type',
                                                list: addType(context),
                                                textController: addTypeController,
                                              );

                                            },
                                            child: Container(
                                              height: 6.h,
                                              width: 36.w,
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.3),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: TextFormField(
                                                enabled: false,
                                                controller: addTypeController,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return translate('required');
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  EdgeInsets.symmetric(horizontal: 8),
                                                  hintText: 'Choose ad type',
                                                  hintStyle: TextStyle(color: Colors.black),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(width: 2.w,),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Guarantee',
                                            style: TextStyle(fontSize: 13.sp),
                                          ),
                                          SizedBox(
                                            height: 1.h,
                                          ),
                                          InkWell(
                                            onTap: () {
                                              smalBottomSheet(
                                              //  fieldValue: 'Choose Guarantee',
                                                list: gurantee(context),
                                                textController: guarntController,
                                              );
                                            },
                                            child: Container(
                                              height: 6.h,
                                              width: 33.5.w,
                                              decoration: BoxDecoration(
                                                color: Colors.white.withOpacity(0.3),
                                                borderRadius: BorderRadius.circular(6),
                                              ),
                                              child: TextFormField(
                                                enabled: false,
                                                controller: guarntController,
                                                validator: (value) {
                                                  if (value.isEmpty) {
                                                    return translate('required');
                                                  }
                                                  return null;
                                                },
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                  EdgeInsets.symmetric(horizontal: 8),
                                                  hintText: 'Guarantee',
                                                  hintStyle: TextStyle(color: Colors.black),
                                                  border: InputBorder.none,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),

                                    ],
                                  ),

                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Color',
                                        style: TextStyle(fontSize: 13.sp),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          bottomSheet(
                                            fieldValue: 'Choose Color',
                                            list: colorList(context),
                                            textController: colorController,
                                          );

                                        },
                                        child: Container(
                                          height: 6.h,
                                          width: 72.w,
                                          decoration: BoxDecoration(
                                            color: Colors.white.withOpacity(0.3),
                                            borderRadius: BorderRadius.circular(6),
                                          ),
                                          child: TextFormField(
                                            enabled: false,
                                            controller: colorController,
                                            validator: (value) {
                                              if (value.isEmpty) {
                                                return translate('required');
                                              }
                                              return null;
                                            },
                                            decoration: InputDecoration(
                                              contentPadding:
                                              EdgeInsets.symmetric(horizontal: 8),
                                              hintText: 'Choose Colors',
                                              hintStyle: TextStyle(color: Colors.black),
                                              border: InputBorder.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 25.h),

                                ],
                              ),
                            ),
                          ),
                        )
                    ),
                    AnimatedPositioned(
                        duration: Duration(milliseconds: 300),
                        width: 88.w,
                        height: 100.h,
                        left: isShow ? 12.w : 88.w,
                        child: Container(
                          color:Color(0xff38205A) ,
                          child:Padding(
                            padding:  EdgeInsets.only(left: 8.w),
                            child: ListView(
                              padding: EdgeInsets.only(left: 20,right: 15,top: 10),
                              children: [
                                Text('Add Photos',style: TextStyle(fontSize: 15.sp,fontWeight: FontWeight.bold),),

                                Container(

                                    height: 18.h,
                                    child: AddImage()),

                                SizedBox(
                                  height: 0.5.h,
                                ),
                                //Price
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      translate('price'),
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
                                        controller: priceController,
                                        keyboardType: TextInputType.number,
                                        validator: (value) {
                                          if (value.isEmpty) {
                                            return translate('required');
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          prefixText: 'QR ',
                                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                                          hintText: translate('price'),
                                          hintStyle: TextStyle(color: Colors.black),
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 0.5.h,
                                ),
                                //Description Box
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      translate('description'),
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
                                        maxLength: 400,
                                        minLines: 1,
                                        maxLines: 10,
                                        controller: descController,
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.symmetric(horizontal: 8),
                                          hintText: translate('description'),
                                          hintStyle: TextStyle(color: Colors.black),
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
                                      //showConfirmDialog();
                                      updateUser(catProvider, context);
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
                        )
                    ),
                    AnimatedPositioned(
                        bottom: isShow?48.h:20.h,
                        left:isShow ? -65 :  16.w,
                        duration: Duration(milliseconds: 300),
                        child: AnimatedDefaultTextStyle(
                          duration: Duration(milliseconds: 300),
                          textAlign:TextAlign.center,
                          style: TextStyle(fontSize: isShow? 14.sp : 22.sp,fontWeight: FontWeight.bold),
                          child: Transform.rotate(
                            angle: -animationText.value*pi /180,
                            alignment: Alignment.center,
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  a = areaController.text;
                                  t = brandController.text;
                                  con = conditionController.text;
                                  gur = guarntController.text;
                                  col = colorController.text;
                                });
                                await valid();

                              },
                              child: Container(
                                height: isShow? 3.h : 6.h,
                                width: 50.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color:isShow ? null : Color(0xff38205A),
                                ),
                                child: Center(
                                  child: Text(isShow? "previous".toUpperCase(): 'Next'.toUpperCase(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                    ),
                    AnimatedPositioned(
                        bottom:! isShow?55.h:8.h,
                        right: 37,
                        // right:isShow ? -50 :  16.w,
                        duration: Duration(milliseconds: 100),
                        child: AnimatedDefaultTextStyle(
                          duration: Duration(milliseconds: 100),
                          textAlign:TextAlign.center,
                          style: TextStyle(fontSize: !isShow? 14.sp : 22.sp,fontWeight: FontWeight.bold),
                          child: Transform.rotate(
                            angle: 80.1-(animationText.value)*pi /180,
                            alignment: Alignment.topRight,
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  a = areaController.text;
                                  t = brandController.text;
                                  con = conditionController.text;
                                  gur = guarntController.text;
                                  col = colorController.text;
                                });
                                await valid();

                              },
                              child: Container(
                                height: !isShow? 3.h : 3.h,
                                width: 30.w,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(6),
                                  color:isShow ? null : Color(0xff38205A),
                                ),
                                child: Center(
                                  child: Text(isShow? "".toUpperCase(): 'show more'.toUpperCase(),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                    ),
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
