import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ShopCategoryBox extends StatelessWidget {
  final String label;
  final String imageUrl;
  const ShopCategoryBox({
    Key key,
    @required this.label,
    @required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Image.asset(imageUrl, fit: BoxFit.contain, height: 8.h),
          ),
          SizedBox(height: 5),
          Text(
            label,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          )
        ],
      ),
    );
  }
}
