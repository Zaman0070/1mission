import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SearchBox extends StatelessWidget {
  final String hintText;
  const SearchBox({Key key, @required this.hintText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool check = Theme.of(context).primaryColor == Colors.white ? true : false;
    return Container(
      height: 6.h,
      //alignment: Alignment.center,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2.w),
          color: Color(0xffCCC6DA),
          boxShadow: [
            BoxShadow(
              color: check ? Colors.grey : Colors.transparent,
              blurRadius: 10.0, // soften the shadow
              spreadRadius: 0.0, //extend the shadow
              offset: Offset(
                0.0, // Move to right 10  horizontally
                5.0, // Move to bottom 10 Vertically
              ),
            )
          ]),
      child: TextField(
        style: TextStyle(color: Colors.black),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.black,
            fontSize: 20,
          ),
          border: InputBorder.none,
          prefixIcon: Icon(Icons.search, color: Colors.black),
        ),
      ),
    );
  }
}
