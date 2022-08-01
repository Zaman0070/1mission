import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:marketplace_app/drawre%20screens/product_cat.dart';
import 'package:marketplace_app/provider/cat_provider.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';
import '../services/firebase_service.dart';
import '../widget/change_theme_button_widget.dart';

class MyDrawer extends StatefulWidget {
  @override
  _MyDrawerState createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  FirebaseService service = FirebaseService();

  @override
  Widget build(BuildContext context) {
    DocumentSnapshot args = ModalRoute.of(context).settings.arguments;
    var catProvider = Provider.of<CategoryProvider>(context);
    var data = catProvider.selectedCategory;
    return Container(
      width: 75.w,
      height: 100.h,
      color: Theme.of(context).primaryColor == Colors.white
          ? Colors.white
          : Colors.grey[900],
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 2.h),
        child: ListView(
          children: [
            SizedBox(
              height: 2.5.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  translate('ctegories'),
                  // 'Categories',
                  style: TextStyle(fontSize: 20.sp),
                ),
                Image.asset(
                  'assets/icons/category.png',
                  height: 3.5.h,
                  color: Theme.of(context).splashColor,
                ),
              ],
            ),
            ChangeThemeButtonWidget(),
            SizedBox(
              height: 1.5.h,
            ),
            Divider(),
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: Text(
                translate('cars'),
                style: TextStyle(fontSize: 16.sp),
              ),
              trailing: Image.asset(
                'assets/icons/car.png',
                height: 3.5.h,
                color: Theme.of(context).splashColor,
              ),
              children: [
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Toyota',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('toyota'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Nissan',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('nissan'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Chevrolet',

                                )));
                  },
                  title: Text(
                    translate('chevrolet'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Kia',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('kia'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Honda',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('honda'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Ford',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('ford'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Mercedes Benz',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('mercedes'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Lexus',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('lexus'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'BMW',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('bmw'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Wolkswagen',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('wolkswagen'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Land Rover',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('landRover'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Mitsubishi',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('mitsubishi'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>ProductCategoryScreen(
                                    brand: 'Dodge',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('dodge'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Jeep',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('jeep'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Suzuki',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('suzuki'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Porsche',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('porsche'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Hyundai',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('hyundai'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Cadillac',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('cadillac'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Audi',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('audi'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Renault',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('renault'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Infinity',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('infinity'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Mazda',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('mazda'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Mini',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('mini'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Skoda',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('skoda'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Jaguar',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('jaguar'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Aston Martin',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('aston'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Subaru',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('subaru'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Peugeot',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('peugeot'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Chrysler',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('chrysler'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Bentley',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('bentley'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Volvo',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('volvo'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Seat',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('seat'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>ProductCategoryScreen(
                                    brand: 'Citroen',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('citroen'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Maserati',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('maserati'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'TATA',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('tata'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Fiat',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('fiat'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>ProductCategoryScreen(
                                    brand: 'Ferrari',
                                  ),
                        ));
                  },
                  title: Text(
                    translate('ferrari'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Rolls Royce',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('rolls'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Buick',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('buick'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Chery',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('chery'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Great Wall',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('great'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>ProductCategoryScreen(
                                    brand: 'Pontiac',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('pontiac'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Opel',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('opel'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Alfa Romeo',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('romeo'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Lamborghini',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('lambo'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Bugatti',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('bugatti'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'McLaren',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('mclaren'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'MayBach',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('maybach'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Daewoo',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('daewoo'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Datsun',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('datsun'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'MG',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('mg'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Borgward',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('borg'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Tesla',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('tesla'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'GMC',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('gmc'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ],
            ),
            Divider(),
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: Text(
                translate('mobiles'),
                style: TextStyle(fontSize: 16.sp),
              ),
              trailing: Image.asset(
                'assets/icons/smartphone.png',
                height: 3.5.h,
                color: Theme.of(context).splashColor,
              ),
              children: [
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'iPhone',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('iphone'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'iPad',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('ipad'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Android Phones',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('androidPhone'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Android Tablets',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('androidTab'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Windows Tablets',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('windowsTab'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Wearables',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('wearables'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Bluetooth Earbuds',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('earbuds'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ],
            ),
            Divider(),
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: Text(
                translate('electronics'),
                style: TextStyle(fontSize: 16.sp),
              ),
              trailing: Image.asset(
                'assets/icons/plug.png',
                height: 3.5.h,
                color: Theme.of(context).splashColor,
              ),
              children: [
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Drones',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('drones'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Laptops',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('laptops'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Tv Receiver',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('receiver'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Computers',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('comp'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Televisions',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('tv'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Computer Accessories',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('accessories'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Cookers & Ovens',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('oven'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Printers & Ink',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('printer'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Fridges',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('fridges'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Washing Machines',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('machine'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'GPS Devices',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('gps'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Projectors',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('projectors'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Water Coolers',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('cooler'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Laser',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('laser'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Water Heaters',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('heater'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ],
            ),
            Divider(),
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: Text(
                translate('furniture'),
                style: TextStyle(fontSize: 16.sp),
              ),
              trailing: Image.asset(
                'assets/icons/furniture.png',
                height: 3.5.h,
                color: Theme.of(context).splashColor,
              ),
              children: [
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Sofas',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('sofas'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Beds & Mattresses',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('beds'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Tables desks & Chairs',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('tables'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Kitchen Stuff',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('kitchen'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Rugs & Carpet',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('rugs'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Crafts',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('crafts'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ],
            ),
            Divider(),
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: Text(
                translate('motorcycles'),
                style: TextStyle(fontSize: 16.sp),
              ),
              trailing: Image.asset(
                'assets/icons/motorcycle.png',
                height: 3.5.h,
                color: Theme.of(context).splashColor,
              ),
              children: [
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Buggy',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('buggy'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Polaris',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('polaris'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Suzuki',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('suzuki'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Yamaha',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('yamaha'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Harley Davidson',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('harley'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Honda',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('honda'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'BMW',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('bmw'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Kawasaki',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('kawasaki'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'KTM',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('ktm'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Ducatti',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('ducatti'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Can-am',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('canam'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Arctic Cat',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('cat'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'MV Agusta',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('mv'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Bajaj',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('bajaj'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Beta',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('beta'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Gilera',
                                  ),
                        ));
                  },
                  title: Text(
                    translate('gilera'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Piaggio',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('piaggio'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Royal Enfield',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('royal'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Triumph',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('triumph'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'TVS',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('tvs'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Vespa',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('vespa'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ],
            ),
            Divider(),
            ExpansionTile(
              tilePadding: EdgeInsets.zero,
              title: Text(
                translate('electronicGames'),
                style: TextStyle(fontSize: 16.sp),
              ),
              trailing: Image.asset(
                'assets/icons/game.png',
                height: 3.5.h,
                color: Theme.of(context).splashColor,
              ),
              children: [
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Playstation Games',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('pgames'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'Playstation Devices',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('pdevices'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProductCategoryScreen(
                                    brand: 'XBox Games',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('xgames'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'XBox Devices',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('xdevices'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Wii Games',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('wgames'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>  ProductCategoryScreen(
                                    brand: 'Wii Devices',
                                  ),
                                ));
                  },
                  title: Text(
                    translate('wdevices'),
                    style: TextStyle(fontSize: 12.sp),
                  ),
                ),
              ],
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}
