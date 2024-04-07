import 'package:flutter/material.dart';

//* Primary Swatch

//* Primary
const Color colorOnPrimary = Color(0xffffffff);
const Color colorPrimaryLight = Color(0xff77C4FC);
const Color colorPrimary = Color(0xff1696FA);
// Color colorPrimary2 = createGradient(const Color.fromARGB(204, 19, 212, 255),
//     const Color.fromARGB(204, 15, 64, 189));
const Color colorPrimaryDeep = Color(0xff1F538C);

//* Secondary
// const Color colorOnSecondary = Color(0xffffffff);
// const Color colorSecondary = Color(0xFF4E416D);
// const Color colorSecondaryDark = Color(0xFFB21A75);
// const Color colorSecondaryLight = Color(0xFF9382BA);
// const Color colorSecondaryLightFade = Color.fromARGB(255, 229, 225, 238);

//* Accent
const Color colorAccent = Color(0xffFFC009);
const Color colorAccentLight = Color(0xff7965D2);
const Color colorAccentDeep = Color(0xff321B96);

//* Background
const Color colorBg = Colors.white;
const Color colorBgLight = Color(0xffEAEAEA);
const Color colorBgDeep = Color(0xffEAEAEA);
const Color colorBgDeeper = Color(0xffD3D3D3);
const Color colorBgPrimaryFade = Color(0xffF5F8FF);
const Color colorBgPrimaryLight = Color(0xff77C4FC);
const Color colorBgSkeleton = Color(0xFFE2E3E5);

//* Error
const Color colorError = Color(0xffFC0013);
const Color colorWarningDeep = Color(0xffFD603C);
const Color colorWarning = Color(0xffFD8F40);
const Color colorWarningLight = Color(0xffFFBE33);
const Color colorErrorLight = Color(0xffFF6166);

//* Text
const Color colorTextMain = Colors.black;
const Color colorTextLight = Colors.white;
const Color colorTextGray = Color(0xff747474);
const Color colorTextInactive = Color(0xff848484);
//* Not Set Yet ->
const Color colorTextDeepGray = Color(0xff515151);
const Color colorTextLightGray = Color(0xff8c8c8c);
//* <- Not Set Yet

//* Good
const Color colorGreen = Color(0xff15D892);
const Color colorGreenDeep = Color(0xff459E4C);
const Color colorGreenLight = Color(0xff9EED60);

//* Shimmer
const Color colorShimmerBase = Color.fromARGB(255, 243, 243, 243);
const Color colorShimmerHighlight = Color.fromARGB(255, 227, 224, 224);

//* Miscelleneous
const Color colorLoginButton = Color.fromARGB(255, 55, 98, 141);

// Gradients
const LinearGradient colorPrimarySecondaryGradient = LinearGradient(
  colors: [colorPrimary, colorAccentDeep],
  tileMode: TileMode.mirror,
);
