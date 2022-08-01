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

class MotorcycleBrandScreen extends StatefulWidget {
  const MotorcycleBrandScreen({Key key}) : super(key: key);

  @override
  State<MotorcycleBrandScreen> createState() => _MotorcycleBrandScreenState();
}

class _MotorcycleBrandScreenState extends State<MotorcycleBrandScreen> {
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
                      builder: (context) =>  AllCategory(cat: 'Motorcycles')));
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
                label: translate('buggy'),
                imageUrl: 'assets/motorcycle brands/buggy.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Buggy')));
                },
              ),
              BrandBox(
                label: translate('polaris'),
                imageUrl: 'assets/motorcycle brands/polaris.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Polaris')));
                },
              ),
              BrandBox(
                label: translate('suzuki'),
                imageUrl: 'assets/motorcycle brands/suzuki.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategoryScreen(brand: 'Suzuki')));
                },
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('yamaha'),
                imageUrl: 'assets/motorcycle brands/yamaha.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Yamaha')));
                },
                size: 2.5,
              ),
              BrandBox(
                label: translate('harley'),
                imageUrl: 'assets/motorcycle brands/harley.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(
                                  brand: 'Harley Davidson')));
                },
              ),
              BrandBox(
                label: translate('honda'),
                imageUrl: 'assets/motorcycle brands/honda.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Honda')));
                },
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('bmw'),
                imageUrl: 'assets/motorcycle brands/bmw.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategoryScreen(brand: 'BMW')));
                },
              ),
              BrandBox(
                label: translate('ktm'),
                imageUrl: 'assets/motorcycle brands/ktm.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategoryScreen(brand: 'KTM')));
                },
                size: 4,
              ),
              BrandBox(
                label: translate('kawasaki'),
                imageUrl: 'assets/motorcycle brands/kawasaki.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                                  ProductCategoryScreen(brand: 'Kawasaki')));
                },
                size: 4,
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('ducatti'),
                imageUrl: 'assets/motorcycle brands/ducati.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Ducatti')));
                },
              ),
              BrandBox(
                label: translate('canam'),
                imageUrl: 'assets/motorcycle brands/canam.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Can-am')));
                },
              ),
              BrandBox(
                label: translate('cat'),
                imageUrl: 'assets/motorcycle brands/cat.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                                  ProductCategoryScreen(brand: 'Arctic Cat')));
                },
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('mv'),
                imageUrl: 'assets/motorcycle brands/mv.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                                  ProductCategoryScreen(brand: 'MV Agusta')));
                },
              ),
              BrandBox(
                label: translate('bajaj'),
                imageUrl: 'assets/motorcycle brands/bajaj.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategoryScreen(brand: 'Bajaj')));
                },
              ),
              BrandBox(
                label: translate('beta'),
                imageUrl: 'assets/motorcycle brands/beta.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Beta')));
                },
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('gilera'),
                imageUrl: 'assets/motorcycle brands/gilera.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategoryScreen(brand: 'Gilera')));
                },
              ),
              BrandBox(
                label: translate('piaggio'),
                imageUrl: 'assets/motorcycle brands/piagio.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategoryScreen(brand: 'Piaggio')));
                },
                size: 3,
              ),
              BrandBox(
                label: translate('royal'),
                imageUrl: 'assets/motorcycle brands/beta.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategoryScreen(
                                  brand: 'Royal Enfield')));
                },
                size: 4,
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('triumph'),
                imageUrl: 'assets/motorcycle brands/triumph.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategoryScreen(brand: 'Triumph')));
                },
              ),
              BrandBox(
                label: translate('tvs'),
                imageUrl: 'assets/motorcycle brands/tvs.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'TVS')));
                },
                size: 3,
              ),
              BrandBox(
                label: translate('vespa'),
                imageUrl: 'assets/motorcycle brands/vespa.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Vespa')));
                },
              ),
            ],
          ),
          BrandBox(
            label: 'Other Categories Bike',
            imageUrl: 'assets/motorcycle brands/ducati.png',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  ProductCategoryScreen(
                          brand: 'other Bick')));
            },
          ),
        ],
      ),
    );
  }
}
