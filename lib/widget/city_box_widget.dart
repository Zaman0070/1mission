import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class CityBox extends StatelessWidget {
  final void Function() onTap;
  final String imageUrl;
  final Color color;
  final String label;
  const CityBox({
    Key key,
    @required this.onTap,
    @required this.imageUrl,
    @required this.color,
    @required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool check = Theme.of(context).splashColor == Colors.white ? true : false;
    return Expanded(
      child: InkWell(
        splashColor: Color(0xff8E7FC0),
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShaderMask(
              shaderCallback: (bounds) {
                return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.grey.shade600,
                      Colors.grey.shade800
                    ]
                ).createShader(bounds);
              },
              child: Container(
                alignment: Alignment.bottomCenter,
                clipBehavior: Clip.antiAlias,
                height: 20.h,
                decoration: BoxDecoration(
                  // color: check ? Color(0xff8E7FC0) : Color(0xff38205A),
                  color: color,
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0.0,
                      child: Image.asset(
                        imageUrl,
                        //fit: BoxFit.cover,
                        height: 11.h,
                      ),
                    ),
                    Positioned(
                      top: 10.0,
                      left: 10.0,
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
