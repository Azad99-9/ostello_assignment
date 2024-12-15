import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeService {
  static const Color primaryColor = Color(0xff7D23E0);
  static const Color secondaryColor = Color(0xff292D32);
  static const Color primaryAccent = Color(0xffD8B4FF);
  static const Color secondaryAccent = Color(0xffF5F5F5);
  static const Color surfaceColor = Colors.white;

  static final TextStyle titleLarge = GoogleFonts.aDLaMDisplay(
    fontSize: 18.0,
    fontWeight: FontWeight.w400, // Equivalent to font-weight: 400
    height: 20 / 16, // Line height as a multiple of font size
    textBaseline: TextBaseline.alphabetic,
    decorationStyle: TextDecorationStyle.solid,
    // decorationSkipInk: false, // Explicitly state skipping ink is disabled
  );

  static final TextStyle titleMedium = GoogleFonts.roboto(
    fontSize: 14.0,
    fontWeight: FontWeight.w400, // Equivalent to font-weight: 400
    height: 21 / 12, // Line height as a multiple of font size
    textBaseline: TextBaseline.alphabetic,
    decorationStyle: TextDecorationStyle.solid,
  );

  static final TextStyle bodyMedium = GoogleFonts.afacad(
    fontSize: 14.0,
    fontWeight: FontWeight.w500, // Equivalent to font-weight: 500
    height: 20 / 12, // Line height as a multiple of font size
    textBaseline: TextBaseline.alphabetic,
    decorationStyle: TextDecorationStyle.solid,
  );

  static final TextStyle bodySmall = GoogleFonts.roboto(
    fontSize: 12.0,
    fontWeight: FontWeight.w500, // Equivalent to font-weight: 500
    height: 14.01 / 10, // Line height as a multiple of font size
    textBaseline: TextBaseline.alphabetic,
    decorationStyle: TextDecorationStyle.solid,
  );
  
  static final TextStyle labelMedium = GoogleFonts.aBeeZee(
    fontSize: 16.0,
    fontWeight: FontWeight.w400, // Equivalent to font-weight: 400
    height: 16.55 / 14, // Line height as a multiple of font size
    textBaseline: TextBaseline.alphabetic,
    decorationStyle: TextDecorationStyle.solid,
  );

}
