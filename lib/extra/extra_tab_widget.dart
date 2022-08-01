import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_app/provider/theme_provider.dart';
import 'package:marketplace_app/widget/best_seller.dart';
import 'package:marketplace_app/widget/recently_added_widget.dart';
import 'package:marketplace_app/widget/row_widget.dart';
import 'package:marketplace_app/widget/search_box_widget.dart';
import 'package:marketplace_app/widget/shop_category_widget.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import '../widget/box_widget.dart';

class Shop extends StatefulWidget {
  @override
  _ShopState createState() => _ShopState();
}

class _ShopState extends State<Shop> {
  @override
  Widget build(BuildContext context) {
    bool check = Theme.of(context).primaryColor == Colors.white ? true : false;
    return Scaffold(
      floatingActionButton: Container(
        height: 8.h,
        width: 6.5.h,
        decoration: BoxDecoration(
            color: Color(0xff90315F),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  blurRadius: 8,
                  spreadRadius: 1,
                  offset: Offset(-0, 2),
                  color: Colors.grey.shade600)
            ]),
        child: Column(
          children: [
            SizedBox(
              height: 1.h,
            ),
            Text(
              'Help',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              height: 0.8.h,
            ),
            Icon(
              CupertinoIcons.chat_bubble_2,
              color: Colors.white,
              size: 28,
            )
          ],
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text('Shop'),
        actions: [
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {},
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          children: [
            SearchBox(
              hintText: 'Search',
            ),
            SizedBox(height: 10),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  SizedBox(height: 15),
                  Stack(
                    children: [
                      Container(
                        clipBehavior: Clip.antiAlias,
                        height: 18.h,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Image.asset('assets/images/plant.jpg',
                            fit: BoxFit.cover),
                      ),
                      Positioned(
                        top: 4.h,
                        left: 3.w,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Gardening\nand\nplant care',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 8),
                            InkWell(
                              onTap: () {},
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 6.0, horizontal: 10.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: Text(
                                  'Shop now',
                                  style: TextStyle(color: Colors.black),
                                ),
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 15),
                  Container(
                    // padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Shop by category',
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                        SizedBox(width: 5),
                        Text(
                          'New guaranteed original products at your doorstep!',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: const [
                            ShopCategoryBox(
                              label: 'Appliances',
                              imageUrl: 'assets/images/washing_machine.png',
                            ),
                            SizedBox(width: 10),
                            ShopCategoryBox(
                              label: 'Home Essential',
                              imageUrl: 'assets/images/bed.png',
                            ),
                            SizedBox(width: 10),
                            ShopCategoryBox(
                              label: 'Electronics',
                              imageUrl: 'assets/images/lcd.png',
                            ),
                            SizedBox(width: 10),
                            ShopCategoryBox(
                              label: 'Car',
                              imageUrl: 'assets/images/jeep.png',
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: const [
                            ShopCategoryBox(
                              label: 'Mobile & Tablets',
                              imageUrl: 'assets/images/iphone.png',
                            ),
                            SizedBox(width: 10),
                            ShopCategoryBox(
                              label: 'Mobile & Tablets',
                              imageUrl: 'assets/images/bicycle.png',
                            ),
                            SizedBox(width: 10),
                            ShopCategoryBox(
                              label: 'Kids',
                              imageUrl: 'assets/images/teddy-bear.png',
                            ),
                            SizedBox(width: 10),
                            ShopCategoryBox(
                              label: 'Stationary',
                              imageUrl: 'assets/images/book.png',
                            ),
                          ],
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: const [
                            ShopCategoryBox(
                              label: 'Health & Beauty',
                              imageUrl: 'assets/images/health.png',
                            ),
                            SizedBox(width: 10),
                            ShopCategoryBox(
                              label: 'Pets',
                              imageUrl: 'assets/images/camel.png',
                            ),
                            SizedBox(width: 10),
                            ShopCategoryBox(
                              label: 'Fashion',
                              imageUrl: 'assets/images/watch.png',
                            ),
                            SizedBox(width: 10),
                            ShopCategoryBox(
                              label: 'Foods',
                              imageUrl: 'assets/images/honey.png',
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  RowWidget(
                    title: 'Best Sellers',
                    btnLabel: 'See all',
                    onTap: () {},
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    children: [
                      BestSeller(
                        text: 'Adjustable height and balance sport',
                        image: 'assets/images/bed.png',
                        price: 305,
                      ),
                      SizedBox(width: 10),
                      BestSeller(
                        text: 'Adjustable height and balance sport',
                        image: 'assets/images/mobile.png',
                        price: 305,
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    children: [
                      BestSeller(
                        text: 'Adjustable height and balance sport',
                        image: 'assets/images/plane.png',
                        price: 305,
                      ),
                      SizedBox(width: 10),
                      BestSeller(
                        text: 'Adjustable height and balance sport',
                        image: 'assets/images/sofa.png',
                        price: 305,
                      ),
                    ],
                  ),
                  SizedBox(height: 15.0),
                  Row(
                    children: [
                      BestSeller(
                        text: 'Adjustable height and balance sport',
                        image: 'assets/images/game.png',
                        price: 305,
                      ),
                      SizedBox(width: 10),
                      BestSeller(
                        text: 'Adjustable height and balance sport',
                        image: 'assets/images/bus.png',
                        price: 305,
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  RowWidget(
                    title: 'Recently Added',
                    btnLabel: 'See all',
                    onTap: () {},
                  ),
                  SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      RecentlyAddedBox(
                        label: 'Motocycle Tank Bag Waterproof',
                        imageUrl: 'assets/images/tank_bag.png',
                        qr: 89,
                      ),
                      SizedBox(width: 10),
                      RecentlyAddedBox(
                        label: 'Voda Challenge Beauty',
                        qr: 23,
                        imageUrl: 'assets/images/voda.png',
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      RecentlyAddedBox(
                        label: 'Pierre Roche Espera Eau De Perfume',
                        qr: 135,
                        imageUrl: 'assets/images/perfume.png',
                      ),
                      SizedBox(width: 10),
                      RecentlyAddedBox(
                        label: 'Cotton Masks - Kids Whale Design',
                        qr: 30,
                        imageUrl: 'assets/images/mask.png',
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  RowWidget(
                    title: 'Luxury looks for special ones',
                    btnLabel: 'See all',
                    onTap: () {},
                  ),
                  SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      RecentlyAddedBox(
                        label: 'Seiko Men\'s SNKP21J1Q Seiko 5',
                        qr: 426,
                        imageUrl: 'assets/images/seiko_watch.png',
                      ),
                      SizedBox(width: 10),
                      RecentlyAddedBox(
                        label: 'Locs Super Dark Gloss Sunglasses',
                        qr: 60,
                        imageUrl: 'assets/images/glasses.png',
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      RecentlyAddedBox(
                        label: 'Fendi Paradeyes Gray Mirror Cat Eye',
                        qr: 1649,
                        imageUrl: 'assets/images/tank_bag.png',
                      ),
                      SizedBox(width: 10),
                      RecentlyAddedBox(
                        label: 'Chanel Chance Eau',
                        qr: 629,
                        imageUrl: 'assets/images/tank_bag.png',
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
