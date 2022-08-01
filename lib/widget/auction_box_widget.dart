import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:sizer/sizer.dart';

class AuctionBox extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(right: 10.0),
            height: 20.h,
            width: 20.h,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              '12345',
              style: TextStyle(fontSize: 20),
            ),
          ),
          SizedBox(height: 5.0),
          Text(
            'Car Plate 42523',
          ),
          Row(
            children: const [
              Icon(Icons.history, color: Colors.red),
              Text(
                '2d 22h 42m 23s',
                style: TextStyle(
                  color: Colors.red,
                ),
              )
            ],
          ),
          Row(
            children: const [
              Icon(MdiIcons.hammer, color: Colors.grey),
              Text(
                '5',
                style: TextStyle(
                  color: Colors.grey,
                ),
              )
            ],
          ),
          Text(
            '400 QAR',
            style: TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
