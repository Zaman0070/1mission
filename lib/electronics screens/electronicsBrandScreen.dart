import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_options.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:marketplace_app/car%20screens/brand_box.dart';
import 'package:marketplace_app/drawre%20screens/product_cat.dart';
import 'package:marketplace_app/sell_Items/all_category.dart';
import 'package:sizer/sizer.dart';

final List<String> imgList = [
  'https://source.unsplash.com/random/1920x1920/?sports',
  'https://source.unsplash.com/random/1920x1920/?nature',
];

class ElectronicsBrandScreen extends StatefulWidget {
  const ElectronicsBrandScreen({Key key}) : super(key: key);

  @override
  State<ElectronicsBrandScreen> createState() => _ElectronicsBrandScreenState();
}

class _ElectronicsBrandScreenState extends State<ElectronicsBrandScreen> {
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
                      builder: (context) => AllCategory(cat: 'Electronics')));
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
                label: translate('drones'),
                imageUrl: 'assets/electronics brands/drones.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategoryScreen(brand: 'Drones')));
                },
              ),
              BrandBox(
                label: translate('laptops'),
                imageUrl: 'assets/electronics brands/laptops.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Laptops')));
                },
              ),
              BrandBox(
                label: translate('receiver'),
                imageUrl: 'assets/electronics brands/receiver.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(
                                  brand: 'TV Receiver')));
                },
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('comp'),
                imageUrl: 'assets/electronics brands/computers.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                                  ProductCategoryScreen(brand: 'Computers')));
                },
              ),
              BrandBox(
                label: translate('tv'),
                imageUrl: 'assets/electronics brands/tv.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(
                                  brand: 'Televisions')));
                },
              ),
              BrandBox(
                label: translate('accessories'),
                imageUrl: 'assets/electronics brands/accessories.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategoryScreen(
                                    brand: 'Computer Accessories'),
                              ));
                },
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('oven'),
                imageUrl: 'assets/electronics brands/oven.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(
                                  brand: 'Cookers & Ovens')));
                },
              ),
              BrandBox(
                label: translate('printer'),
                imageUrl: 'assets/electronics brands/printer.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(
                                  brand: 'Printers & Ink')));
                },
              ),
              BrandBox(
                label: translate('fridges'),
                imageUrl: 'assets/electronics brands/fridge.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>ProductCategoryScreen(brand: 'Fridges')));
                },
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('machine'),
                imageUrl: 'assets/electronics brands/machine.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategoryScreen(
                                    brand: 'Washing Machines'),
                              ));
                },
              ),
              BrandBox(
                label: translate('gps'),
                imageUrl: 'assets/electronics brands/gps.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategoryScreen(
                                  brand: 'GPS Devices')));
                },
              ),
              BrandBox(
                label: translate('projectors'),
                imageUrl: 'assets/electronics brands/projector.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                                  ProductCategoryScreen(brand: 'Projectors')));
                },
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('cooler'),
                imageUrl: 'assets/electronics brands/cooler.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(
                                  brand: 'Water Coolers')));
                },
              ),
              BrandBox(
                label: translate('laser'),
                imageUrl: 'assets/electronics brands/laser.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Laser')));
                },
              ),
              BrandBox(
                label: translate('heater'),
                imageUrl: 'assets/electronics brands/heater.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(
                                  brand: 'Water Heaters')));
                },
              ),
            ],
          ),
          BrandBox(
            label: 'Other Categories Electronic',
            imageUrl: 'assets/electronics brands/fridge.png',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  ProductCategoryScreen(
                          brand: 'other Electronics')));
            },
          ),
        ],
      ),
    );
  }
}
