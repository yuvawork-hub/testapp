import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextStyle {
  static textStyle({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    String? fontFamily,
  }) =>
      TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        height: height,
        fontFamily: fontFamily,
      );

  static poppinsTextStyle({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? height,
  }) =>
      GoogleFonts.poppins(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        height: height,
      );

  static interTextStyle({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? height,
  }) =>
      GoogleFonts.inter(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        height: height,
      );
  static inderTextStyle({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? height,
  }) =>
      GoogleFonts.inder(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        height: height,
      );

  static eczarTextStyle({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? height,
  }) =>
      GoogleFonts.eczar(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        height: height,
      );

  static asapTextStyle({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? height,
  }) =>
      GoogleFonts.asap(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        height: height,
      );
  static outfitTextStyle({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? height,
    List<Shadow>? shadows,
    TextDecoration? decoration,
  }) =>
      GoogleFonts.outfit(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        height: height,
        shadows: shadows,
        decoration: decoration,
      );
  static neutonTextStyle({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? height,
  }) =>
      GoogleFonts.neuton(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        height: height,
      );

  static podkovaTextStyle({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? height,
  }) =>
      GoogleFonts.podkova(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        height: height,
      );

  static epilogueTextStyle({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? height,
  }) =>
      GoogleFonts.epilogue(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        height: height,
      );
  static petronaTextStyle({
    double? fontSize,
    Color? color,
    FontWeight? fontWeight,
    double? height,
  }) =>
      GoogleFonts.petrona(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
        height: height,
      );
}