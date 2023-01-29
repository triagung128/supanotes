import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xffFFF9F2);
Color blackColorOpacity75 = Colors.black.withOpacity(0.75);
Color whiteColorOpacity75 = Colors.white.withOpacity(0.75);

final TextStyle appBarTextStyle = GoogleFonts.encodeSans(
  fontSize: 16,
  fontWeight: FontWeight.w700,
  color: Colors.black,
);

final TextStyle labelTextStyle = GoogleFonts.encodeSans(
  fontSize: 14,
  fontWeight: FontWeight.w600,
  color: Colors.black,
  letterSpacing: 2,
);

final TextStyle hintTextStyle = GoogleFonts.encodeSans(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: blackColorOpacity75,
);

final TextStyle formFieldTextStyle = GoogleFonts.encodeSans(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: Colors.black,
);

final TextStyle buttonTextStyle = GoogleFonts.encodeSans(
  fontSize: 18,
  fontWeight: FontWeight.w700,
  color: Colors.white,
);

final TextStyle linkTextStyle = GoogleFonts.encodeSans(
  fontSize: 14,
  fontWeight: FontWeight.w700,
  decoration: TextDecoration.underline,
  color: Colors.black,
);

final TextStyle titleTextStyle = GoogleFonts.encodeSans(
  fontSize: 18,
  fontWeight: FontWeight.w700,
  color: Colors.black,
);

final TextStyle bodyTextStyle = GoogleFonts.encodeSans(
  fontSize: 14,
  fontWeight: FontWeight.w400,
  color: Colors.black,
);

final AppBarTheme appBarTheme = AppBarTheme(
  backgroundColor: primaryColor,
  elevation: 0,
  titleTextStyle: appBarTextStyle,
  foregroundColor: Colors.black,
);

final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
  border: OutlineInputBorder(
    borderSide: BorderSide(
      width: 0.5,
      color: blackColorOpacity75,
    ),
    borderRadius: BorderRadius.circular(8),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
  ),
  filled: true,
  fillColor: whiteColorOpacity75,
  hintStyle: hintTextStyle,
  labelStyle: labelTextStyle,
  suffixIconColor: blackColorOpacity75,
);

final TextSelectionThemeData textSelectionThemeData = TextSelectionThemeData(
  cursorColor: blackColorOpacity75,
);

final ElevatedButtonThemeData elevatedButtonThemeData = ElevatedButtonThemeData(
  style: ElevatedButton.styleFrom(
    backgroundColor: blackColorOpacity75,
    textStyle: buttonTextStyle,
    padding: const EdgeInsets.symmetric(vertical: 14),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(25),
    ),
  ),
);

const ProgressIndicatorThemeData progressIndicatorThemeData =
    ProgressIndicatorThemeData(color: Colors.black);

const FloatingActionButtonThemeData floatingActionButtonThemeData =
    FloatingActionButtonThemeData(backgroundColor: Colors.black);
