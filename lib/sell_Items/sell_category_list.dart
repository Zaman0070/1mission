import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:marketplace_app/forms/electronic_games.dart';
import 'package:marketplace_app/forms/electronics_form.dart';
import 'package:marketplace_app/forms/furniture_form.dart';
import 'package:marketplace_app/forms/mobile_form.dart';
import 'package:marketplace_app/forms/motorcycles_form.dart';
import 'package:marketplace_app/forms/seller_car_forms.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../provider/cat_provider.dart';
import '../services/firebase_service.dart';

class SellCategories extends StatefulWidget {
  static const String id = 'sell-category-list-screen';

  @override
  State<SellCategories> createState() => _SellCategoriesState();
}

class _SellCategoriesState extends State<SellCategories>
    with TickerProviderStateMixin {
  bool backPressed = false;

  AnimationController controllerToIncreasingCurve;

  AnimationController controllerToDecreasingCurve;

  Animation<double> animationToIncreasingCurve;

  Animation<double> animationToDecreasingCurve;

  @override
  void initState() {
    controllerToIncreasingCurve = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
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

    super.initState();
  }

  @override
  void dispose() {
    controllerToIncreasingCurve.dispose();
    controllerToDecreasingCurve.dispose();
    super.dispose();
  }

  int pageIndex;
  int screenIndex = 0;
  final PageController _pageController = PageController(initialPage: 0);
  int langIndex = 0;

  @override
  Widget build(BuildContext context) {
    int _index = Theme.of(context).primaryColor == Colors.black ? 1 : 0;

    // update();
    List<Widget> screens = [
      SellerCarForms(),
      MobileForm(),
      ElectronicsForm(),
      FurnitureForm(),
      MotorcyclesForms(),
      ElectronicGamesForm(),
    ];

    FirebaseService service = FirebaseService();

    var catProvider = Provider.of<CategoryProvider>(context);

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
          backgroundColor: Color(0xff8E7FC0),
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            toolbarHeight: 45,
            elevation: 0.0,
            backgroundColor: Color(0xff8E7FC0),
            automaticallyImplyLeading: false,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_sharp),
              onPressed: () {
                if (_pageController.page == 0) {
                  Navigator.pop(context);
                }
                _pageController.previousPage(
                  duration: Duration(microseconds: 100),
                  curve: Curves.ease,
                );
              },
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.cancel),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          body: PageView(
            reverse: true,
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            children: <Widget>[
              SizedBox(
                height: 100.h,
                width: 100.w,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 10.h,
                      ),
                      Padding(
                        padding:  EdgeInsets.only(left: 8.0),
                        child: Text(
                          translate('chooseLang',),
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 22.sp),
                        ),
                      ),
                      SizedBox(
                        height: 18.h,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CircleAvatar(
                            radius: 9.7.h,
                            backgroundColor: langIndex == 2
                                ? Theme.of(context).cardColor
                                : Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  changeLocale(context, 'en');
                                  langIndex = 2;
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).primaryColor ==
                                            Colors.white
                                        ? Color(0xffF0F0F0)
                                        : Colors.white,
                                radius: 9.h,
                                child: Text(
                                  'English',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          CircleAvatar(
                            radius: 9.7.h,
                            backgroundColor: langIndex == 3
                                ? Theme.of(context).cardColor
                                : Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  changeLocale(context, 'ar');
                                  langIndex = 3;
                                });
                              },
                              child: CircleAvatar(
                                backgroundColor:
                                    Theme.of(context).primaryColor ==
                                            Colors.white
                                        ? Color(0xffF0F0F0)
                                        : Colors.white,
                                radius: 9.h,
                                child: Text(
                                  'العربية',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Spacer(),
                      InkWell(
                        onTap: () {
                          if (langIndex > 0) {
                            _pageController.nextPage(
                              duration: Duration(microseconds: 100),
                              curve: Curves.ease,
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text(translate('chooseLang'))));
                          }
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: 100.w,
                          height: 7.5.h,
                          decoration: BoxDecoration(
                            color: Color(0xff38205A),
                            borderRadius: BorderRadius.circular(2.w),
                          ),
                          child: Text(
                            translate('continue'),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 1.5.h),
                    ],
                  ),
                ),
              ),
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 70.h,
                      child: FutureBuilder<QuerySnapshot>(
                        future: service.categories
                            .orderBy('sortId', descending: false)
                            .get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Container();
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          return Container(
                            child: ListView.builder(
                                itemCount: snapshot.data.docs.length,
                                itemBuilder: (BuildContext context, int index) {
                                  // screenIndex = index;
                                  var doc = snapshot.data.docs[index];
                                  return Padding(
                                    padding: EdgeInsets.all(8),
                                    child: ListTile(
                                      onTap: () {
                                        _pageController.nextPage(
                                          duration:
                                              Duration(milliseconds: 1000),
                                          curve: Curves.ease,
                                        );
                                        setState(() {
                                          screens[index];
                                          screenIndex = index;
                                        });

                                        catProvider.getCategory(doc['catName']);
                                        catProvider.getCatSnapshot(doc);
                                      },
                                      title: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 7.5,
                                            backgroundColor:
                                                Colors.white.withOpacity(0.3),
                                          ),
                                          SizedBox(
                                            width: 3.w,
                                          ),
                                          Text(
                                            doc['catName'],
                                            style: TextStyle(fontSize: 14.5.sp),
                                          ),
                                        ],
                                      ),
                                      trailing: Image.network(doc['icon'],height: 4.h,color:Colors.white,),
                                    ),
                                  );
                                }),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              ListView(
                children: [
                  SizedBox(height: 90.h, child: screens[screenIndex]),
                ],
              ),
            ],
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
          ),
        ),
      ),
    );
  }
}

class ProgressPageIndicator extends AnimatedWidget {
  final PageController pageController;

  final int pageCount;

  final Color primaryColor;

  final Color secondaryColor;

  final num height;

  const ProgressPageIndicator({
    @required this.pageController,
    @required this.pageCount,
    @required this.primaryColor,
    @required this.secondaryColor,
    this.height = 2.0,
  }) : super(listenable: pageController);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: LinearProgressIndicator(
        backgroundColor: secondaryColor,
        valueColor: Tween(begin: primaryColor, end: primaryColor)
            .animate(kAlwaysCompleteAnimation),
        value: (pageController.page ?? pageController.initialPage) /
            (pageCount - 1),
      ),
    );
  }
}

class GradientPageIndicator extends AnimatedWidget {
  final PageController pageController;

  final int pageCount;

  final Color primaryColor;

  final Color secondaryColor;

  final num height;

  const GradientPageIndicator({
    @required this.pageController,
    @required this.pageCount,
    @required this.primaryColor,
    @required this.secondaryColor,
    this.height = 2.0,
  }) : super(listenable: pageController);

  @override
  Widget build(BuildContext context) {
    double pagePosition =
        (pageController.page ?? pageController.initialPage) / (pageCount - 1);
    double alignPosition = pagePosition * 2 - 1;

    print("PagePosition: $pagePosition, alignPosition: $alignPosition");

    return Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [primaryColor, secondaryColor],
          begin: Alignment(alignPosition - 0.0001, 0),
          end: Alignment(alignPosition + 0.0001, 0),
        ),
      ),
    );
  }
}
