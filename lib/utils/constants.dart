import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF00897B);
const kPrimaryLightColor = Color(0xFFFFECDF);
const kPrimaryGradientColor = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [Color(0xFFEF5350), Color(0xFFE53935)],
);
const kSecondaryColor = Color(0xFF979797);
const kTextColor = Color(0xFF757575);

const kAnimationDuration = Duration(milliseconds: 200);

final kTitleStyle = TextStyle(
  color: Colors.black38,
  fontFamily: 'CM Sans Serif',
  fontSize: 26.0,
  height: 1.5,
);

final kSubtitleStyle = TextStyle(
  color: Colors.black38,
  fontSize: 18.0,
  height: 1.2,
);
