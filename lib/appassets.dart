import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'theme.dart';

class AppAssets {
  static const String logo = 'assets/icons/logo.svg';
  // static const String logor = 'assets/icons/logo_r.svg';
  // static const String logoc = 'assets/icons/logo_c.svg';
  // static const String splashLeft = 'assets/svgs/splash1.svg';
  static const String splashLeftPng = 'assets/svgs/splash.png';
  static final Widget logoTm = SvgPicture.asset(
    logo,
    color: MThemeData.primaryColor,
    semanticsLabel: 'Corp Logo',
  );

  // static final Widget logoC = SvgPicture.asset(logoc,
  //     semanticsLabel: 'Corp Logo', cacheColorFilter: true);
  // static final Widget svgCircle = SvgPicture.asset(splashLeft,
  //     semanticsLabel: 'Corp Logo',
  //     width: 160,
  //     height: 160,
  //     cacheColorFilter: true);
}
