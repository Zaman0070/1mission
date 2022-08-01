import 'package:flutter/material.dart';

class RowWidget extends StatelessWidget {
  final String title;
  final String btnLabel;
  final void Function() onTap;
  const RowWidget({
    Key key,
    @required this.title,
    @required this.btnLabel,
    @required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
          ),
        ),
        InkWell(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
            decoration: BoxDecoration(
              color: Color(0xff90315F),
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
            ),
            child: Text(
              btnLabel,
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}
