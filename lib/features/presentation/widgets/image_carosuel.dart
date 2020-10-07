import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget imageCarosuel = new Container(
  height: 200.0,
  child: Carousel(
    boxFit: BoxFit.cover,
    images: [
      NetworkImage(
          'https://firebasestorage.googleapis.com/v0/b/ktlabs-9aed7.appspot.com/o/image2.jpeg?alt=media&token=082d90bf-51c7-43ec-9b62-7d5426e8e02a'),
      NetworkImage(
          'https://firebasestorage.googleapis.com/v0/b/ktlabs-9aed7.appspot.com/o/image4.jpeg?alt=media&token=29eec3be-66ec-463a-925a-2ab218f8ea08'),
      NetworkImage(
          'https://firebasestorage.googleapis.com/v0/b/ktlabs-9aed7.appspot.com/o/image3.jpg?alt=media&token=fc39f359-99d1-4a17-bac9-968329aca203'),
      NetworkImage(
          'https://firebasestorage.googleapis.com/v0/b/ktlabs-9aed7.appspot.com/o/image5.jpeg?alt=media&token=1783cdcf-46f1-49be-b7ee-3538829b4e43'),
      NetworkImage(
          'https://firebasestorage.googleapis.com/v0/b/ktlabs-9aed7.appspot.com/o/image1.jpg?alt=media&token=18352ace-ba18-456f-8b04-7295019d1dc6'),
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
