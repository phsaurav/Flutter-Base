import 'package:flutter/material.dart';
import 'package:flutter_base/core/theme/colors.dart';
import 'package:flutter_base/utils/size_utils.dart';
import 'package:google_fonts/google_fonts.dart';

final TextTheme appTextTheme = TextTheme(
  //* Display
  displayLarge: textDisplayLarge,
  displayMedium: textDisplayMedium,
  displaySmall: textDisplaySmall,
  //* Headline
  headlineLarge: textHeadlineLarge,
  headlineMedium: textHeadlineMedium,
  headlineSmall: textHeadlineSmall,
  //* Title
  titleLarge: textTitleLarge,
  titleMedium: textTitleMedium,
  titleSmall: textTitleSmall,
  //* Label
  labelLarge: textLabelLarge,
  //Button Text
  labelMedium: textLabelMedium,
  labelSmall: textLabelSmall,
  //* Body
  bodyLarge: textBodyLarge,
  bodyMedium: textBodyMedium,
  bodySmall: textBodySmall,
  //* Other
  // button: TextStyle(fontSize: 14.wr, fontWeight: FontWeight.w500),
);

//* Text Styles out of material theme for ease of use

//* Display
TextStyle textDisplayLarge =
    GoogleFonts.openSans(fontSize: 30.wr, fontWeight: FontWeight.bold);
TextStyle textDisplayMedium =
    GoogleFonts.openSans(fontSize: 28.wr, fontWeight: FontWeight.bold);
TextStyle textDisplaySmall =
    GoogleFonts.openSans(fontSize: 26.wr, fontWeight: FontWeight.bold);

//* Headline
TextStyle textHeadlineLarge =
    GoogleFonts.openSans(fontSize: 24.wr, fontWeight: FontWeight.bold);
TextStyle textHeadlineMedium =
    GoogleFonts.openSans(fontSize: 22.wr, fontWeight: FontWeight.bold);
TextStyle textHeadlineSmall =
    GoogleFonts.openSans(fontSize: 20.wr, fontWeight: FontWeight.bold);

//* Title
TextStyle textTitleLarge =
    GoogleFonts.openSans(fontSize: 18.wr, fontWeight: FontWeight.bold);
TextStyle textTitleMedium =
    GoogleFonts.openSans(fontSize: 16.wr, fontWeight: FontWeight.bold);
TextStyle textTitleSmall =
    GoogleFonts.openSans(fontSize: 14.wr, fontWeight: FontWeight.bold);

//* Label
TextStyle textLabelLarge =
    GoogleFonts.openSans(fontSize: 16.wr, fontWeight: FontWeight.w500);
TextStyle textLabelMedium = GoogleFonts.openSans(
    fontSize: 14.wr, fontWeight: FontWeight.w500, color: colorOnPrimary);
TextStyle textLabelSmall =
    GoogleFonts.openSans(fontSize: 12.wr, fontWeight: FontWeight.w500);

//* Body
TextStyle textBodyLarge = GoogleFonts.openSans(
  fontSize: 14.wr,
);
TextStyle textBodyMedium = GoogleFonts.openSans(
  fontSize: 12.wr,
);
TextStyle textBodySmall = GoogleFonts.openSans(
  fontSize: 10.wr,
);
