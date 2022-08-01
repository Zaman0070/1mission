import 'package:flutter/material.dart';
import 'package:flutter_carousel_widget/flutter_carousel_options.dart';
import 'package:flutter_carousel_widget/flutter_carousel_widget.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:marketplace_app/car%20screens/brand_box.dart';
import 'package:marketplace_app/drawre%20screens/product_cat.dart';
import 'package:marketplace_app/sell_Items/all_category.dart';
import 'package:sizer/sizer.dart';

final List<String> imgList = [
  'https://source.unsplash.com/random/1920x1920/?abstracts',
  'https://source.unsplash.com/random/1920x1920/?fruits,flowers',
];

class CarBrandScreen extends StatefulWidget {
  const CarBrandScreen({Key key}) : super(key: key);

  @override
  State<CarBrandScreen> createState() => _CarBrandScreenState();
}

class _CarBrandScreenState extends State<CarBrandScreen> {
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
                      builder: (context) =>
                         AllCategory(cat: 'Cars')));
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
                label: translate('toyota'),
                imageUrl: 'assets/brands/toyota.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Toyota'),
                              ));
                },
              ),
              BrandBox(
                label: translate('nissan'),
                imageUrl: 'assets/brands/nissan.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Nissan'),
                              ));
                },
              ),
              BrandBox(
                label: translate('chevrolet'),
                imageUrl: 'assets/brands/chevrolet.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                                  ProductCategoryScreen(brand: 'Chevrolet')));
                },
                size: 3,
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('kia'),
                imageUrl: 'assets/brands/kia.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Kia')));
                },
              ),
              BrandBox(
                label: translate('honda'),
                imageUrl: 'assets/brands/honda.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Honda')));
                },
              ),
              BrandBox(
                label: translate('ford'),
                imageUrl: 'assets/brands/ford.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Ford')));
                },
                size: 4,
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('mercedes'),
                imageUrl: 'assets/brands/mercedes.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(
                                  brand: 'Mercedes Benz')));
                },
              ),
              BrandBox(
                label: translate('lexus'),
                imageUrl: 'assets/brands/lexus.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Lexus')));
                },
              ),
              BrandBox(
                label: translate('bmw'),
                imageUrl: 'assets/brands/bmw.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'BMW')));
                },
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('wolkswagen'),
                imageUrl: 'assets/brands/wolkswagen.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                                  ProductCategoryScreen(brand: 'Wolkswagen')));
                },
              ),
              BrandBox(
                label: translate('landRover'),
                imageUrl: 'assets/brands/rover.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                                  ProductCategoryScreen(brand: 'Land Rover')));
                },
              ),
              BrandBox(
                label: translate('mitsubishi'),
                imageUrl: 'assets/brands/mtsubishi.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                                  ProductCategoryScreen(brand: 'Mitsubishi')));
                },
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('dodge'),
                imageUrl: 'assets/brands/dodge.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Dodge')));
                },
              ),
              BrandBox(
                label: translate('jeep'),
                imageUrl: 'assets/brands/jeep.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Jeep')));
                },
              ),
              BrandBox(
                label: translate('suzuki'),
                imageUrl: 'assets/brands/suzuki.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Suzuki')));
                },
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('porsche'),
                imageUrl: 'assets/brands/porsche.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Porsche')));
                },
              ),
              BrandBox(
                label: translate('hyundai'),
                imageUrl: 'assets/brands/hyundai.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategoryScreen(brand: 'Hyundai')));
                },
              ),
              BrandBox(
                label: translate('cadillac'),
                imageUrl: 'assets/brands/cadillac.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                                  ProductCategoryScreen(brand: 'Cadillac')));
                },
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('audi'),
                imageUrl: 'assets/brands/audi.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategoryScreen(brand: 'Audi')));
                },
              ),
              BrandBox(
                label: translate('renault'),
                imageUrl: 'assets/brands/renault.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Renault')));
                },
              ),
              BrandBox(
                label: translate('infinity'),
                imageUrl: 'assets/brands/infinity.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                                  ProductCategoryScreen(brand: 'Infinity')));
                },
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('mazda'),
                imageUrl: 'assets/brands/mazda.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategoryScreen(brand: 'Mazda')));
                },
              ),
              BrandBox(
                label: translate('mini'),
                imageUrl: 'assets/brands/mini.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Mini')));
                },
                size: 4,
              ),
              BrandBox(
                label: translate('skoda'),
                imageUrl: 'assets/brands/skoda.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Skoda')));
                },
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('jaguar'),
                imageUrl: 'assets/brands/jaguar.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Jaguar')));
                },
              ),
              BrandBox(
                label: translate('aston'),
                imageUrl: 'assets/brands/martin.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategoryScreen(
                                  brand: 'Aston Martin')));
                },
                size: 4,
              ),
              BrandBox(
                label: translate('subaru'),
                imageUrl: 'assets/brands/subaru.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Subaru')));
                },
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('peugeot'),
                imageUrl: 'assets/brands/peugeot.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Peugeot')));
                },
              ),
              BrandBox(
                label: translate('chrysler'),
                imageUrl: 'assets/brands/chrysler.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                                  ProductCategoryScreen(brand: 'Chrysler')));
                },
                size: 2,
              ),
              BrandBox(
                label: translate('bentley'),
                imageUrl: 'assets/brands/bentley.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Bentley')));
                },
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('volvo'),
                imageUrl: 'assets/brands/volvo.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategoryScreen(brand: 'Volvo')));
                },
              ),
              BrandBox(
                label: translate('seat'),
                imageUrl: 'assets/brands/seat.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Seat')));
                },
                size: 6,
              ),
              BrandBox(
                label: translate('citroen'),
                imageUrl: 'assets/brands/citroen.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategoryScreen(brand: 'Citroen')));
                },
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('maserati'),
                imageUrl: 'assets/brands/maserati.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                                  ProductCategoryScreen(brand: 'Maserati')));
                },
                size: 6,
              ),
              BrandBox(
                label: translate('tata'),
                imageUrl: 'assets/brands/tata.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'TATA')));
                },
                size: 6,
              ),
              BrandBox(
                label: translate('gmc'),
                imageUrl: 'assets/brands/gmc.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'GMC')));
                },
                size: 2,
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('fiat'),
                imageUrl: 'assets/brands/fiat.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Fiat')));
                },
              ),
              BrandBox(
                label: translate('ferrari'),
                imageUrl: 'assets/brands/ferrari.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Ferrari')));
                },
                size: 6,
              ),
              BrandBox(
                label: translate('rolls'),
                imageUrl: 'assets/brands/rolls.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(
                                  brand: 'Rolls Royce')));
                },
                size: 6,
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('buick'),
                imageUrl: 'assets/brands/buick.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Buick')));
                },
              ),
              BrandBox(
                label: translate('chery'),
                imageUrl: 'assets/brands/chery.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategoryScreen(brand: 'Chery')));
                },
              ),
              BrandBox(
                label: translate('great'),
                imageUrl: 'assets/brands/wall.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                                  ProductCategoryScreen(brand: 'Great Wall')));
                },
                size: 6,
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('opel'),
                imageUrl: 'assets/brands/opel.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Opel')));
                },
              ),
              BrandBox(
                label: translate('romeo'),
                imageUrl: 'assets/brands/romeo.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                                  ProductCategoryScreen(brand: 'Alfa Romeo')));
                },
              ),
              BrandBox(
                label: translate('lambo'),
                imageUrl: 'assets/brands/lambor.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategoryScreen(
                                  brand: 'Lamborghini')));
                },
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('bugatti'),
                imageUrl: 'assets/brands/bugatti.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Bugatti')));
                },
              ),
              BrandBox(
                label: translate('mclaren'),
                imageUrl: 'assets/brands/mclaren.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'McLaren')));
                },
                size: 2,
              ),
              BrandBox(
                label: translate('maybach'),
                imageUrl: 'assets/brands/maybach.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'MayBach')));
                },
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('daewoo'),
                imageUrl: 'assets/brands/daewoo.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Daewoo')));
                },
              ),
              BrandBox(
                label: translate('datsun'),
                imageUrl: 'assets/brands/datsun.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Datsun')));
                },
              ),
              BrandBox(
                label: translate('mg'),
                imageUrl: 'assets/brands/mg.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ProductCategoryScreen(brand: 'MG')));
                },
                size: 6,
              ),
            ],
          ),
          Row(
            children: [
              BrandBox(
                label: translate('borg'),
                imageUrl: 'assets/brands/borg.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                                  ProductCategoryScreen(brand: 'Borgward')));
                },
              ),
              BrandBox(
                label: translate('tesla'),
                imageUrl: 'assets/brands/tesla.png',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Tesla')));
                },
              ),
              BrandBox(
                label: translate('pontiac'),
                imageUrl: 'assets/brands/pontiac.jpg',
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>  ProductCategoryScreen(brand: 'Pontiac')));
                },
                size: 7,
              ),
            ],
          ),
          BrandBox(
            label: 'Other Categories Cars',
            imageUrl: 'assets/brands/lambor.png',
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>  ProductCategoryScreen(
                          brand: 'other Cars')));
            },
          ),
        ],
      ),
    );
  }
}
