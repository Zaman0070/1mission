import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CarShopBox extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20.h,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          SizedBox(height: 5),
          Text('Full Service'),
          SizedBox(height: 5),
          Text(
            '100 QAR',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 5),
          Row(
            children: const [
              Icon(
                Icons.comment,
                size: 15,
              ),
              Text(
                ' 0',
                style: TextStyle(fontSize: 12),
              )
            ],
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}

List<CarShopBox> cars = [
  CarShopBox(),
  CarShopBox(),
  CarShopBox(),
  CarShopBox(),
  CarShopBox(),
  CarShopBox(),
  CarShopBox(),
  CarShopBox(),
  CarShopBox(),
  CarShopBox(),
  CarShopBox(),
];
