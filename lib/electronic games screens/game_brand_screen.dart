import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_options.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:marketplace_app/car%20screens/brand_box.dart';
import 'package:marketplace_app/drawre%20screens/product_cat.dart';
import 'package:marketplace_app/sell_Items/all_category.dart';
import 'package:sizer/sizer.dart';

final List<String> imgList = [
  'https://source.unsplash.com/random/1920x1920/?science',
  'https://source.unsplash.com/random/1920x1920/?computer'
];
class GameBrandScreen extends StatefulWidget {
  const GameBrandScreen({Key key}) : super(key: key);

  @override
  State<GameBrandScreen> createState() => _GameBrandScreenState();
}

class _GameBrandScreenState extends State<GameBrandScreen> {
  final List<Widget> imageSliders = imgList
      .map((item) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4.0),
    child: ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(4.0)),
      child: Image.network(
        item,
        width: double.infinity,
        fit: BoxFit.fill,
        loadingBuilder: (BuildContext ctx, Widget child,
            ImageChunkEvent loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                  loadingProgress.expectedTotalBytes
                  : null,
            ),
          );
        },
        errorBuilder: (
            BuildContext context,
            Object exception,
            StackTrace stackTrace,
            ) {
          return const Text(
            'Oops!! An error occurred. 😢',
            style: TextStyle(fontSize: 16.0),
          );
        },
      ),
    ),
  ))
      .toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        elevation: 0.0,
        centerTitle: true,
        title: Image.asset(
          'assets/icons/logo.png',
          height: 4.5.h,
          color: Theme.of(context).splashColor,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(10),
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            height: 18.h,
            child: FlutterCarousel(
                items: imageSliders,
                options: CarouselOptions(
                  height: 400.0,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1.0,
                  initialPage: 0,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: true,
                  autoPlayInterval: const Duration(seconds: 2),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: false,
                  //  onPageChanged: callbackFunction,
                  pageSnapping: true,
                  scrollDirection: Axis.horizontal,
                  pauseAutoPlayOnTouch: true,
                  pauseAutoPlayOnManualNavigate: true,
                  pauseAutoPlayInFiniteScroll: false,
                  enlargeStrategy: CenterPageEnlargeStrategy.scale,
                  disableCenter: false,
                  showIndicator: true,
                  // slideIndicator: CircularSlideIndicator(),
                )),
          ),
          SizedBox(height: 2.h,),
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>AllCategory(cat: 'Electronic Games')));
            },
            child: Container(
              alignment: Alignment.center,
              height: 5.h,
              width: 100.w,
              decoration: BoxDecoration(
                color: Theme.of(context).shadowColor,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                translate('seeAllCategories'),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          Row(
            children: [
              BrandBox(
                label: translate('pgames'),
                imageUrl: 'assets/game brands/psgames.png',
                size: 7,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Playstation Games'),
                              ));
                },
              ),
              BrandBox(
                label: translate('pdevices'),
                imageUrl: 'assets/game brands/devices.png',
                size: 7,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Playstation Devices'),
                              ));
                },
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('xgames'),
                imageUrl: 'assets/game brands/xgames.png',
                size: 7,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategoryScreen(
                                  brand: 'XBox Devices')));
                },
              ),
              BrandBox(
                label: translate('xdevices'),
                imageUrl: 'assets/game brands/xdevices.png',
                size: 7,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategoryScreen(
                                  brand: 'XBox Devices')));
                },
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('wgames'),
                imageUrl: 'assets/game brands/wgames.png',
                size: 7,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                                  ProductCategoryScreen(brand: 'Wii Games')));
                },
              ),
              BrandBox(
                label: translate('wdevices'),
                imageUrl: 'assets/game brands/wdevices.png',
                size: 7,
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(
                                  brand: 'Wii Devices')));
                },
              ),
            ],
          ),
          BrandBox(
            label: 'Other Categories Games',
            imageUrl: 'assets/game brands/xdevices.png',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  ProductCategoryScreen(
                          brand: 'other Game')));
            },
          ),
        ],
      ),
    );
  }
}
