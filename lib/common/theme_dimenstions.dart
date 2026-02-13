import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppBorderRadius {
  static final circleBorder4 = BorderRadius.circular(4);
  static final circleBorder5 = BorderRadius.circular(5);
  static final circleBorder10 = BorderRadius.circular(10);
  static final circleBorder40 = BorderRadius.circular(40);
  static final circleBorder50 = BorderRadius.circular(50);
  static final circleBorder13 = BorderRadius.circular(13);
  static final circleBorder20 = BorderRadius.circular(20);
  static const singleSideRadius80 = Radius.circular(80);
  static const singleSideRadius20 = Radius.circular(20);
  static const singleSideRadius8 = Radius.circular(8);
  static const singleSideRadius22 = Radius.circular(22);
  static const singleSideRadius10 = Radius.circular(10);
  static const singleSideRadius100 = Radius.circular(100);
  static const singleSideRadius23 = Radius.circular(23);
  static const singleSideRadius24 = Radius.circular(24);
  static const singleSideRadius25 = Radius.circular(25);
}

class AppEdgeInsetsGeometry {
  ///Padding/Margin All 40
  static const a40 = EdgeInsets.all(40);

  ///Padding/Margin left 20, right 20, top 60
  static const l20r20t60 = EdgeInsets.only(left: 20, right: 20, top: 60);
  static const h5v10 = EdgeInsets.symmetric(horizontal: 5, vertical: 10);
  static const l33r10 = EdgeInsets.only(left: 33, right: 10);
  static const b25 =  EdgeInsets.only(bottom: 25);
  static const h20v20 = EdgeInsets.symmetric(horizontal: 20, vertical: 20);
  static const h2 = EdgeInsets.symmetric(horizontal: 2);
  static const a16 = EdgeInsets.all(16);
  static const h10 =  EdgeInsets.symmetric(horizontal: 10);
  static const h20 = EdgeInsets.symmetric(horizontal: 20);
  static const v8 = EdgeInsets.symmetric(vertical: 8);
  static const a20 = EdgeInsets.all(20);
  static const l25r15 = EdgeInsets.only(left: 25, right: 15);
  static const l8r30t8b8 =
      EdgeInsets.only(left: 8, right: 30, top: 8, bottom: 8);
  static const b11 = EdgeInsets.only(bottom: 11);
}

class NoDotInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.contains('.') || newValue.text.contains(',')) {
      return oldValue;
    }
    return newValue;
  }
}

class AppBorderRadiusGeometry {
  ///BorderRadius Circular 4
  static final c4 = BorderRadius.circular(4);

  ///BorderRadius Circular 10
  static final c10 = BorderRadius.circular(10);

  ///BorderRadius Circular 20
  static final c20 = BorderRadius.circular(20);

  ///BorderRadius Circular 10
  static final c50 = BorderRadius.circular(50);
}