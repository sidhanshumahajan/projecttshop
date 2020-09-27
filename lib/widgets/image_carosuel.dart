import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget imageCarosuel = new Container(
  height: 200.0,
  child: Carousel(
    boxFit: BoxFit.cover,
    images: [
      AssetImage('images/image2.jpeg'),
      AssetImage('images/image3.jpg'),
      AssetImage('images/image4.jpeg'),
      AssetImage('images/image1.jpg'),
      AssetImage('images/image5.jpeg'),
      AssetImage('images/image6.jpeg'),
    ],
    autoplay: false,
    dotSize: 4.0,
    indicatorBgPadding: 14,
    overlayShadowSize: 0.3,
    dotBgColor: Colors.transparent,
    animationCurve: Curves.fastOutSlowIn,
    animationDuration: Duration(milliseconds: 1000),
  ),
);
