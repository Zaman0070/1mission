import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

PreferredSizeWidget buildAppBar(BuildContext context) => AppBar(
      backgroundColor: Theme.of(context).canvasColor,
      elevation: 0.0,
      centerTitle: true,
      title: Image.asset(
        'assets/icons/logo.png',
        height: 4.5.h,
        color: Theme.of(context).splashColor,
      ),
      actions: [
        IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.search)),
        IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.bell)),
      ],
    );
