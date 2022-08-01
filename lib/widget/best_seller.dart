import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BestSeller extends StatefulWidget {
  String text;
  int price;
  String image;
  BestSeller({@required this.text, @required this.price, @required this.image});

  @override
  _BestSellerState createState() => _BestSellerState();
}

class _BestSellerState extends State<BestSeller> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.all(6.0),
      height: 26.h,
      width: 44.5.w,

      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        children: [
          Container(
              height: 13.h,
              width: 44.5.w,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(45),
                    bottomLeft: Radius.circular(45),
                    topRight: Radius.circular(10),
                    topLeft: Radius.circular(10),
                  )),
              child: Image.asset(widget.image)),
          SizedBox(
            height: 4.h,
          ),
          Text(
            widget.text,
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.white, fontSize: 12.sp),
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            "${widget.price}",
            style: TextStyle(
                color: Colors.white,
                fontSize: 17.sp,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
