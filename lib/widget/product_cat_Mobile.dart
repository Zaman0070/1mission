import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../navigation/navigation_productdetail.dart';
import '../provider/product_provider.dart';
import '../services/firebase_service.dart';


class ProductCategoryMobile extends StatefulWidget {
  String brand;
  ProductCategoryMobile({this.brand});

  @override
  State<ProductCategoryMobile> createState() => _ProductCategoryMobileState();
}

class _ProductCategoryMobileState extends State<ProductCategoryMobile> {
  FirebaseService service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<ProductProvider>(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).backgroundColor,
            bottom: TabBar(
              padding: EdgeInsets.all(10),
              indicator: BoxDecoration(
                color: Theme.of(context).shadowColor,
                borderRadius: BorderRadius.circular(15),
              ),
              tabs: const [
                Tab(
                  text: 'Sale',
                ),
                Tab(
                  text: 'Rent',
                ),
                Tab(
                  text: 'Accessories',
                ),
              ],
            ),
          ),
          body: TabBarView(
              children: [
                ListView(
                  children: [
                    SizedBox(
                      width: 100.w,
                      //  color: Colors.white,
                      child: FutureBuilder<QuerySnapshot>(
                        future: service.products.where('brand', isEqualTo: widget.brand ).where('adsType',isEqualTo: 'Sale').get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Some things wrong');
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Padding(
                              padding: EdgeInsets.only(left: 20.w, right: 20.w),
                              child: LinearProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor),
                                backgroundColor: Colors.grey[400],
                              ),
                            );
                          }
                          if (snapshot.data.docs.isEmpty) {
                            return SizedBox(
                                height: 100.h,
                                child:
                                Center(child: Text('No Product add this category')));
                          }
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: snapshot.data.size,
                              itemBuilder: (BuildContext contexy, int index) {
                                var data = snapshot.data.docs[index];
                                return InkWell(
                                  onTap: () {
                                    provider.getProductDetails(data);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => NavigationProductDetails()));
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          SizedBox(
                                            height: 18.h,
                                            width: 18.h,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: Image.network(
                                                  data['image'][0],
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          SizedBox(
                                              height: 17.h,
                                              width: 20.h,
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(data['title'],
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold)),
                                                  Text(data['discretion'],
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w300,
                                                          fontSize: 11.sp)),
                                                  Text(
                                                    data['brand'],
                                                  ),
                                                  Text('${data['price']} QAR'),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 10.h),
                                                    child: LikeButton(
                                                      size: 12,
                                                      circleColor: CircleColor(
                                                          start: Color(0xff00ddff),
                                                          end: Color(0xff0099cc)),
                                                      bubblesColor: BubblesColor(
                                                        dotPrimaryColor:
                                                        Color(0xff33b5e5),
                                                        dotSecondaryColor:
                                                        Color(0xff0099cc),
                                                      ),
                                                      likeBuilder: (bool isLiked) {
                                                        return Icon(
                                                          Icons.thumb_up,
                                                          color: isLiked
                                                              ? Colors
                                                              .deepPurpleAccent
                                                              : Colors.grey,
                                                          size: 12,
                                                        );
                                                      },
                                                      likeCount: 0,
                                                      countBuilder: (int count,
                                                          bool isLiked, String text) {
                                                        var color = isLiked
                                                            ? Colors.deepPurpleAccent
                                                            : Colors.grey;
                                                        Widget result;
                                                        if (count == 0) {
                                                          result = Text(
                                                            "",
                                                            style: TextStyle(
                                                                color: color,
                                                                fontSize: 10),
                                                          );
                                                        } else {
                                                          result = Text(
                                                            text,
                                                            style: TextStyle(
                                                                color: color,
                                                                fontSize: 10),
                                                          );
                                                        }
                                                        return result;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Divider(
                                        thickness: 0.2.h,
                                        height: 0.3.h,
                                        color:
                                        Theme.of(context).primaryColor == Colors.white
                                            ? Color(0xffF0F0F0)
                                            : Color(0xffF0F0F0),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                  ],
                ),
                ListView(
                  children: [
                    SizedBox(
                      width: 100.w,
                      //  color: Colors.white,
                      child: FutureBuilder<QuerySnapshot>(
                        future: service.products.where('brand', isEqualTo: widget.brand ).where('adsType',isEqualTo: 'Rent').get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Some things wrong');
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Padding(
                              padding: EdgeInsets.only(left: 20.w, right: 20.w),
                              child: LinearProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor),
                                backgroundColor: Colors.grey[400],
                              ),
                            );
                          }
                          if (snapshot.data.docs.isEmpty) {
                            return SizedBox(
                                height: 100.h,
                                child:
                                Center(child: Text('No Product add this category')));
                          }
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: snapshot.data.size,
                              itemBuilder: (BuildContext contexy, int index) {
                                var data = snapshot.data.docs[index];
                                return InkWell(
                                  onTap: () {
                                    provider.getProductDetails(data);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => NavigationProductDetails()));
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          SizedBox(
                                            height: 18.h,
                                            width: 18.h,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: Image.network(
                                                  data['image'][0],
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          SizedBox(
                                              height: 17.h,
                                              width: 20.h,
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(data['title'],
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold)),
                                                  Text(data['discretion'],
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w300,
                                                          fontSize: 11.sp)),
                                                  Text(
                                                    data['brand'],
                                                  ),
                                                  Text('${data['price']} QAR'),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 10.h),
                                                    child: Row(
                                                      children: [
                                                        LikeButton(
                                                          size: 12,
                                                          circleColor: CircleColor(
                                                              start: Color(0xff00ddff),
                                                              end: Color(0xff0099cc)),
                                                          bubblesColor: BubblesColor(
                                                            dotPrimaryColor:
                                                            Color(0xff33b5e5),
                                                            dotSecondaryColor:
                                                            Color(0xff0099cc),
                                                          ),
                                                          likeBuilder: (bool isLiked) {
                                                            return Icon(
                                                              CupertinoIcons
                                                                  .chat_bubble_fill,
                                                              color: isLiked
                                                                  ? Colors
                                                                  .deepPurpleAccent
                                                                  : Colors.grey,
                                                              size: 12,
                                                            );
                                                          },
                                                          likeCount: 665,
                                                          countBuilder: (int count,
                                                              bool isLiked, String text) {
                                                            var color = isLiked
                                                                ? Colors.deepPurpleAccent
                                                                : Colors.grey;
                                                            Widget result;
                                                            if (count == 0) {
                                                              result = Text(
                                                                "love",
                                                                style: TextStyle(
                                                                    color: color,
                                                                    fontSize: 10),
                                                              );
                                                            } else {
                                                              result = Text(
                                                                text,
                                                                style: TextStyle(
                                                                    color: color,
                                                                    fontSize: 10),
                                                              );
                                                            }
                                                            return result;
                                                          },
                                                        ),
                                                        SizedBox(
                                                          width: 2.w,
                                                        ),
                                                        LikeButton(
                                                          size: 12,
                                                          circleColor: CircleColor(
                                                              start: Color(0xff00ddff),
                                                              end: Color(0xff0099cc)),
                                                          bubblesColor: BubblesColor(
                                                            dotPrimaryColor:
                                                            Color(0xff33b5e5),
                                                            dotSecondaryColor:
                                                            Color(0xff0099cc),
                                                          ),
                                                          likeBuilder: (bool isLiked) {
                                                            return Icon(
                                                              Icons.thumb_up,
                                                              color: isLiked
                                                                  ? Colors
                                                                  .deepPurpleAccent
                                                                  : Colors.grey,
                                                              size: 12,
                                                            );
                                                          },
                                                          likeCount: 665,
                                                          countBuilder: (int count,
                                                              bool isLiked, String text) {
                                                            var color = isLiked
                                                                ? Colors.deepPurpleAccent
                                                                : Colors.grey;
                                                            Widget result;
                                                            if (count == 0) {
                                                              result = Text(
                                                                "love",
                                                                style: TextStyle(
                                                                    color: color,
                                                                    fontSize: 10),
                                                              );
                                                            } else {
                                                              result = Text(
                                                                text,
                                                                style: TextStyle(
                                                                    color: color,
                                                                    fontSize: 10),
                                                              );
                                                            }
                                                            return result;
                                                          },
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Divider(
                                        thickness: 0.2.h,
                                        height: 0.3.h,
                                        color:
                                        Theme.of(context).primaryColor == Colors.white
                                            ? Color(0xffF0F0F0)
                                            : Color(0xffF0F0F0),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                  ],
                ),
                ListView(
                  children: [
                    SizedBox(
                      width: 100.w,
                      //  color: Colors.white,
                      child: FutureBuilder<QuerySnapshot>(
                        future: service.products.where('brand', isEqualTo: 'Accessories').get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text('Some things wrong');
                          }
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return Padding(
                              padding: EdgeInsets.only(left: 20.w, right: 20.w),
                              child: LinearProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Theme.of(context).primaryColor),
                                backgroundColor: Colors.grey[400],
                              ),
                            );
                          }
                          if (snapshot.data.docs.isEmpty) {
                            return SizedBox(
                                height: 100.h,
                                child:
                                Center(child: Text('No Product add this category')));
                          }
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: ScrollPhysics(),
                              itemCount: snapshot.data.size,
                              itemBuilder: (BuildContext contexy, int index) {
                                var data = snapshot.data.docs[index];
                                return InkWell(
                                  onTap: () {
                                    provider.getProductDetails(data);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => NavigationProductDetails()));
                                  },
                                  child: Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          SizedBox(
                                            height: 18.h,
                                            width: 18.h,
                                            child: ClipRRect(
                                                borderRadius: BorderRadius.circular(8),
                                                child: Image.network(
                                                  data['image'][0],
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                          SizedBox(
                                            width: 4.w,
                                          ),
                                          SizedBox(
                                              height: 17.h,
                                              width: 20.h,
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(data['title'],
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.bold)),
                                                  Text(data['discretion'],
                                                      style: TextStyle(
                                                          fontWeight: FontWeight.w300,
                                                          fontSize: 11.sp)),
                                                  Text(
                                                    data['brand'],
                                                  ),
                                                  Text('${data['price']} QAR'),
                                                  Padding(
                                                    padding: EdgeInsets.only(left: 10.h),
                                                    child: LikeButton(
                                                      size: 12,
                                                      circleColor: CircleColor(
                                                          start: Color(0xff00ddff),
                                                          end: Color(0xff0099cc)),
                                                      bubblesColor: BubblesColor(
                                                        dotPrimaryColor:
                                                        Color(0xff33b5e5),
                                                        dotSecondaryColor:
                                                        Color(0xff0099cc),
                                                      ),
                                                      likeBuilder: (bool isLiked) {
                                                        return Icon(
                                                          Icons.thumb_up,
                                                          color: isLiked
                                                              ? Colors
                                                              .deepPurpleAccent
                                                              : Colors.grey,
                                                          size: 12,
                                                        );
                                                      },
                                                      likeCount: 0,
                                                      countBuilder: (int count,
                                                          bool isLiked, String text) {
                                                        var color = isLiked
                                                            ? Colors.deepPurpleAccent
                                                            : Colors.grey;
                                                        Widget result;
                                                        if (count == 0) {
                                                          result = Text(
                                                            "",
                                                            style: TextStyle(
                                                                color: color,
                                                                fontSize: 10),
                                                          );
                                                        } else {
                                                          result = Text(
                                                            text,
                                                            style: TextStyle(
                                                                color: color,
                                                                fontSize: 10),
                                                          );
                                                        }
                                                        return result;
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              )),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                      Divider(
                                        thickness: 0.2.h,
                                        height: 0.3.h,
                                        color:
                                        Theme.of(context).primaryColor == Colors.white
                                            ? Color(0xffF0F0F0)
                                            : Color(0xffF0F0F0),
                                      ),
                                      SizedBox(
                                        height: 1.h,
                                      ),
                                    ],
                                  ),
                                );
                              });
                        },
                      ),
                    ),
                  ],
                ),
              ]
          )

      ),
    );
  }
}
