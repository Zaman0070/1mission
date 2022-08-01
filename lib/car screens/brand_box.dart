import 'package:flutter/material.dart';
import 'package:flutter_translate/flutter_translate.dart';
import 'package:sizer/sizer.dart';

class BrandBox extends StatelessWidget {
  final String label;
  final String imageUrl;
  final Function onTap;
  final double size;
  const BrandBox({
    Key key,
    this.label,
    this.imageUrl,
    this.onTap,
    this.size = 5,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Card(
          elevation: 6,
          color: Colors.white,
          shadowColor: Theme.of(context).splashColor,
          child: SizedBox(
              height: 13.h,
              child: Stack(
                children: [
                  Positioned(
                    top: 4,
                    left: translate('ford') == 'Ford' ? 4 : 0,
                    right: translate('ford') == 'Ford' ? 0 : 4,
                    child: Text(
                      label,
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Positioned(
                    bottom: 4,
                    right: 4,
                    child: SizedBox(
                      height: size.h,
                      child: Image.asset(imageUrl, fit: BoxFit.contain),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
