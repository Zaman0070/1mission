import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class RecentlyAddedBox extends StatelessWidget {
  final String imageUrl;
  final String label;
  final int qr;
  const RecentlyAddedBox({
    Key key,
    @required this.imageUrl,
    @required this.label,
    @required this.qr,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 15.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image.asset(imageUrl),
          ),
          SizedBox(height: 5.0),
          Text(
            label,
          ),
          Text(
            qr.toString() + ' QR',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
