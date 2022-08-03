import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_options.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:marketplace_app/car%20screens/car_brand_screen.dart';
import 'package:marketplace_app/electronic%20games%20screens/game_brand_screen.dart';
import 'package:marketplace_app/electronics%20screens/electronicsBrandScreen.dart';
import 'package:marketplace_app/furniture%20screens/furniture_brand_screen.dart';
import 'package:marketplace_app/mobile%20screens/mobile_brand_screen.dart';
import 'package:marketplace_app/motorcycle%20screens/motorcycle_brand_screen.dart';
import 'package:marketplace_app/pages/dreawer.dart';
import 'package:marketplace_app/pages/home_screens/notification_screen.dart';
import 'package:marketplace_app/provider/product_provider.dart';
import 'package:marketplace_app/services/firebase_service.dart';
import 'package:marketplace_app/services/serach_service.dart';
import 'package:marketplace_app/widget/ad_helper.dart';
import 'package:marketplace_app/widget/home_part.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import 'package:url_launcher/url_launcher.dart';

//import '../../../../../src/flutter/.pub-cache/hosted/pub.dartlang.org/cloud_firestore-3.1.10/lib/cloud_firestore.dart';

final List<String> imgList = [
  'https://source.unsplash.com/random/1920x1920/?abstracts',
  'https://source.unsplash.com/random/1920x1920/?fruits,flowers',
  'https://source.unsplash.com/random/1920x1920/?sports',
  'https://source.unsplash.com/random/1920x1920/?nature',
  'https://source.unsplash.com/random/1920x1920/?science',
  'https://source.unsplash.com/random/1920x1920/?computer'
];

class Home extends StatefulWidget {


  @override
  State<Home> createState() => _HomeState();
}
const String testDevice = 'YOUR_DEVICE_ID';
const int maxFailedLoadAttempts = 3;

class _HomeState extends State<Home> {

   BannerAd _bannerAd;

  bool _isBannerAdReady = false;

   InterstitialAd _interstitialAd;

  bool _isInterstitialAdReady = false;

  bool _isRewardedAdReady = false;

  RewardedAd _rewardedAd;



  FirebaseService service = FirebaseService();
  SearchService searchService = SearchService();




  static List<Product> products = [];
  @override
  void initState() {
    service.products.get().then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((doc) {
        setState(() {
          products.add(
            Product(
                documentSnapshot: doc,
               // brand: doc['brand'],
                category: doc['category'],
                description: doc['discretion'],
                postDate: doc['postedAt'],
                price: doc['price'],
                image: doc['image'][0]),
          );
        });
      });
    });
    // TODO: implement initState
    // _bannerAd = BannerAd(
    //   // Change Banner Size According to Ur Need
    //     size: AdSize.mediumRectangle,
    //     adUnitId: AdHelper.bannerAdUnitId,
    //     listener: BannerAdListener(onAdLoaded: (_) {
    //       setState(() {
    //         _isBannerAdReady = true;
    //       });
    //     }, onAdFailedToLoad: (ad, LoadAdError error) {
    //       print("Failed to Load A Banner Ad${error.message}");
    //       _isBannerAdReady = false;
    //       ad.dispose();
    //     }),
    //     request: AdRequest())
    //   ..load();
    // //Interstitial Ads
    // InterstitialAd.load(
    //     adUnitId: AdHelper.interstitialAdUnitId,
    //     request: AdRequest(),
    //     adLoadCallback: InterstitialAdLoadCallback(onAdLoaded: (ad) {
    //       this._interstitialAd = ad;
    //       _isInterstitialAdReady = true;
    //     }, onAdFailedToLoad: (LoadAdError error) {
    //       print("failed to Load Interstitial Ad ${error.message}");
    //     }));
    //
    // _loadRewardedAd();
    super.initState();
  }

   // void _loadRewardedAd() {
   //   RewardedAd.load(
   //     adUnitId: AdHelper.rewardedAdUnitId,
   //     request: AdRequest(),
   //     rewardedAdLoadCallback: RewardedAdLoadCallback(onAdLoaded: (ad) {
   //       this._rewardedAd = ad;
   //       ad.fullScreenContentCallback =
   //           FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
   //             setState(() {
   //               _isRewardedAdReady = false;
   //             });
   //             _loadRewardedAd();
   //           });
   //       setState(() {
   //         _isRewardedAdReady = true;
   //       });
   //     }, onAdFailedToLoad: (error) {
   //       print('Failed to load a rewarded ad: ${error.message}');
   //       setState(() {
   //         _isRewardedAdReady = false;
   //       });
   //     }),
   //   );
   // }

   // @override
   // void dispose() {
   //   super.dispose();
   //   _bannerAd.dispose();
   //   _interstitialAd.dispose();
   // }


  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductProvider>(context, listen: false);
    bool check = Theme.of(context).primaryColor == Colors.white ? true : false;

    return Scaffold(
      resizeToAvoidBottomInset: true,

      drawer: MyDrawer(),

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
          IconButton(
              onPressed: () {
                setState(() {
                  searchService.search(
                      context: context,
                      productList: products,
                      provider: provider);
                });
              },
              icon: Icon(CupertinoIcons.search)),
          IconButton(onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (_)=>NotificationScreen()));
          }, icon: Icon(CupertinoIcons.bell)),
        ],
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        scrollDirection: Axis.vertical,
        children: <Widget>[
          SizedBox(
            height: 1.h,
          ),
          HomeAds(),

          SizedBox(height: 15),
          Container(
            height: 6.h,
            //alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(2.w),
                color: Color(0xffCCC6DA),
                boxShadow: [
                  BoxShadow(
                    color: check ? Colors.grey : Colors.transparent,
                    blurRadius: 10.0, // soften the shadow
                    spreadRadius: 0.0, //extend the shadow
                    offset: Offset(
                      0.0, // Move to right 10  horizontally
                      5.0, // Move to bottom 10 Vertically
                    ),
                  )
                ]),
            child: InkWell(
              splashColor: Color(0xff8E7FC0),
              onTap: () {
                setState(() {
                  searchService.search(context: context, productList: products);
                });
              },
              child: TextField(
                style: TextStyle(color: Colors.black),
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  enabled: false,
                  hintText: translate('searchHint'),
                  hintStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search, color: Colors.black),
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                translate('estate'),
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => FurnitureBrandScreen()));
            },
            child: Container(
              padding: EdgeInsets.only(left: 6.0, top: 6),
              height: 150,
              decoration: BoxDecoration(
                color: Color(0xffFD4D4D).withOpacity(0.3),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(translate('furniture')),
                    ],
                  ),
                  Image.asset(
                    'assets/images/sofa.png',
                    height: 13.h,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Center(
            child: Text(
              'Paid ads',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
          // if (_isBannerAdReady)
          //   Container(
          //     height: 15.h,
          //    width: 100.w,
          //    decoration: BoxDecoration(
          //      color: Colors.grey[200],
          //      borderRadius: BorderRadius.circular(6),
          //    ),
          //     child: AdWidget(ad: _bannerAd),
          //   ),
          // SizedBox(height: 6),
          SizedBox(height: 6),
          Container(
            clipBehavior: Clip.antiAlias,
            height: 15.h,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.network(
              'https://source.unsplash.com/random/1920x1920/?nature',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                translate('vehicles'),
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Row(
            children: [
              InkWell(
                splashColor: Color(0xff8E7FC0),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CarBrandScreen()));
                },
                child: Container(
                  padding: EdgeInsets.only(left: 6, top: 6),
                  height: 18.h,
                  width: 44.w,
                  decoration: BoxDecoration(
                    color: Color(0xffBEBEBE).withOpacity(0.93),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(translate('cars')),
                        ],
                      ),
                      Image.asset('assets/images/car.png'),
                    ],
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              InkWell(
                splashColor: Color(0xff8E7FC0),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => MotorcycleBrandScreen()));

                },

                child: Container(
                  padding: EdgeInsets.only(
                    left: 6.0,
                    top: 6,
                  ),
                  height: 18.h,
                  width: 44.w,
                  decoration: BoxDecoration(
                    color: Color(0xffFDD29e).withOpacity(0.92),

                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(translate('motorcycles')),
                      Padding(
                        padding: EdgeInsets.only(left: 4.h),
                        child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(10),
                            ),
                            child: Image.asset(
                              'assets/images/bike.png',
                              height: 10.h,
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          Center(
            child: Text(
              'Paid ads',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(height: 6),
          Container(
            clipBehavior: Clip.antiAlias,
            height: 15.h,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.network(
              'https://source.unsplash.com/random/1920x1920/?fruits,flowers',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                translate('mobiles'),
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          InkWell(
            splashColor: Colors.purple,
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MobileBrandScreen()));
            },
            child: Container(
              padding: EdgeInsets.only(left: 6, top: 6),
              height: 18.h,
              decoration: BoxDecoration(
                color: Color(0xff5ECA63).withOpacity(0.9),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(translate('mobiles')),
                    ],
                  ),
                  Image.asset(
                    'assets/mobile brands/phone.png',
                    height: 14.h,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),

          /// electronic
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                translate('electronics'),
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          InkWell(
            splashColor: Color(0xff8E7FC0),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ElectronicsBrandScreen()));
            },
            child: Container(
              padding: EdgeInsets.only(left: 6, top: 6),
              height: 18.h,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(translate('electronics')),
                    ],
                  ),
                  Image.asset(
                    'assets/images/electronics.png',
                    height: 14.h,
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                translate('electronicGames'),
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
            ],
          ),
          SizedBox(height: 15),
          InkWell(
            splashColor: Color(0xff8E7FC0),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => GameBrandScreen()));
            },
            child: Container(
              padding: EdgeInsets.only(
                left: 6.0,
                top: 6,
              ),
              height: 18.h,
              decoration: BoxDecoration(
                color: Color(0xff555555).withOpacity(0.9),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(translate('electronicGames')),
                  Padding(
                    padding: EdgeInsets.only(left: 4.h),
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/game brands/game.png',
                            height: 14.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 15),
          Center(
            child: Text(
              'Paid ads',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12,
              ),
            ),
          ),
          SizedBox(height: 6),
          Container(
            clipBehavior: Clip.antiAlias,
            height: 15.h,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.network(
              'https://source.unsplash.com/random/1920x1920/?nature',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(height: 15),
        ],
      ),
    );
  }

  displayToastMessage(String message, BuildContext context) {
    Fluttertoast.showToast(msg: message);
  }
}
