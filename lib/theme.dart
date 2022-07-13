import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MThemeData {
  const MThemeData._();
  ///////gradient colors/////////////
  static const gradient1 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xff38B2F7),
      Color(0xff61E3AF),
    ],
  );

  static const gradient2 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xff61E3AF),
      Color(0xff38B2F7),
    ],
  );
  /////// light theme
  static const accentColorm = Color(0xFF1EABFB);
  static const primaryColorm = Color(0xFF0074B6);
  static const secondaryColorm = Color(0xFF00446D);
  static const hintColorm = Color(0xFF7FBFE2);
  static const hint2Colorm = Color.fromARGB(255, 22, 45, 61);
  static const almostWhiteColorm = Color(0xFFFAFAFA);
  static const whiteColorm = Color.fromARGB(115, 255, 255, 255);
  ////// Dark Theme
  static const accentColorDark = Color(0xFF1EABFB);
  static const primaryColorDark = Color(0xFF0074B6);
  static const secondaryColorDak = Color(0xFF00446D);
  static const hintColorDark = Color.fromARGB(255, 7, 41, 59);
  static const hint2ColorDark = Color.fromARGB(255, 74, 116, 110);
  static const almostBlackColorDark = Color(0xFF22282F);

  ////////////////////
  static const accentColor = Color(0xFFEAB93C);
  static const primaryColor = Color(0xFF121212);
  static const secondaryColor = Color(0xFF262626);
// black and white
  static const black = Color(0xFF000000);
  static const white = Color(0xFFFFFFFF);
  static final hintColor =
      const Color.fromARGB(141, 255, 255, 255).withOpacity(0.5);

  /////////////////////
  static const ColorScheme lightColorScheme = ColorScheme(
    primary: primaryColorm,
    primaryContainer: Color(0xFF023E62),
    secondary: secondaryColorm,
    secondaryContainer: Color(0xFFFBFAFC),
    background: almostWhiteColorm,
    surface: white,
    onBackground: white,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: _lightFillColor,
    onSurface: _lightFillColor,
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: primaryColorm,
    primaryContainer: hintColorm,
    secondary: secondaryColorm,
    secondaryContainer: Color(0xFF9BE9F2),
    surface: Color(0xFF2C3035),
    background: almostBlackColorDark,
    onBackground: Color(0xFF262626),
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: hintColorm,
    onSecondary: accentColorm,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );

  /////////////////////////
  static const hintTextColor = Colors.grey;
  static const revenuColor = Color(0xFFC8AF8A);
  static const profitColor = Color.fromARGB(255, 255, 0, 85);
  static const salesColor = Color.fromARGB(255, 231, 131, 74);
  static const productColor = Color.fromARGB(255, 6, 165, 117);
  static const serviceColor = Color.fromARGB(255, 25, 66, 179);
  static const expensesColor = Color.fromARGB(255, 247, 166, 16);
  static const incomeColor = Color.fromARGB(255, 161, 15, 154);
  static const debtsColor = Color.fromARGB(255, 251, 30, 104);
  static const errorColor = Color(0xFFE86161);
////////////////////////////
  static final ButtonStyle raisedButtonSdtyle = ElevatedButton.styleFrom(
    minimumSize: const Size(100, 40),
    textStyle: _textTheme.button!.copyWith(color: black),
    elevation: 0,
    // padding: const EdgeInsets.symmetric(horizontal: 8),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
  );
  // static final ButtonStyle raisedButtonStylenodColor = ElevatedButton.styleFrom(
  //   minimumSize: const Size(100, 40),
  //   textStyle: subTextTextStyle.copyWith(color: black),
  //   elevation: 0,
  //   // padding: const EdgeInsets.symmetric(horizontal: 8),
  //   shape: const RoundedRectangleBorder(
  //     borderRadius: BorderRadius.all(Radius.circular(6)),
  //   ),
  // );
  static final ButtonStyle raisedButtonStyleCancel = TextButton.styleFrom(
    textStyle: _textTheme.button!
        .copyWith(color: const Color.fromARGB(255, 0, 82, 206)),
    minimumSize: const Size(88, 36),
    elevation: 0,
    backgroundColor: Colors.transparent,
    foregroundColor: Colors.white.withOpacity(0.5),
    padding: const EdgeInsets.symmetric(horizontal: 8),
    shape: const RoundedRectangleBorder(
      side: BorderSide(color: Color.fromARGB(195, 3, 187, 162)),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
  );
  static final ButtonStyle raisedButtonStyleSave = TextButton.styleFrom(
    textStyle: _textTheme.button!
        .copyWith(color: const Color.fromARGB(255, 0, 82, 206)),
    minimumSize: const Size(88, 36),
    elevation: 0,
    backgroundColor: const Color.fromARGB(195, 3, 187, 162),
    foregroundColor: MThemeData.white,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    shape: const RoundedRectangleBorder(
      //side: BorderSide(color: MThemeData.accentColorm),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
  );

  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      dialogBackgroundColor: colorScheme.secondary,
      colorScheme: colorScheme,
      backgroundColor: colorScheme.background,
      typography: Typography(),
      textTheme: _textTheme,
      primaryColor: colorScheme.background,
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.all(accentColor),
        trackColor: MaterialStateProperty.all(secondaryColor),
      ),
      tabBarTheme: TabBarTheme(labelColor: colorScheme.primary),
      iconTheme: IconThemeData(color: colorScheme.primary),
      canvasColor: colorScheme.background,
      scaffoldBackgroundColor: colorScheme.background,
      // highlightColor: Colors.transparent,
      focusColor: focusColor,

      cardTheme: CardTheme(
        elevation: 0,
        color: colorScheme.surface.withOpacity(0.08),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color.alphaBlend(
          _lightFillColor.withOpacity(0.80),
          _darkFillColor,
        ),
        contentTextStyle: _textTheme.subtitle1!.apply(color: _darkFillColor),
      ),
      //cardTheme: CardTheme(color: colorScheme.primary),
      tooltipTheme: TooltipThemeData(
        decoration: BoxDecoration(
          color: secondaryColorm,
          borderRadius: BorderRadius.circular(4),
        ),
        textStyle: _textTheme.bodyText2!.apply(color: primaryColorm),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        waitDuration: const Duration(milliseconds: 100),
        showDuration: const Duration(milliseconds: 50),
        preferBelow: true,
      ),
    );
  }

  static const _bold = FontWeight.bold;
  static const _semiBold = FontWeight.w600;
  static const _medium = FontWeight.w500;
  static const _regular = FontWeight.normal;
  static const _light = FontWeight.w300;

  static final TextTheme _textTheme = TextTheme(
      headline1: GoogleFonts.robotoMono(fontWeight: _bold, fontSize: 24.0),
      /***************************** */
      headline2: GoogleFonts.robotoMono(fontWeight: _semiBold, fontSize: 22.0),
      /***************************** */
      headline3: GoogleFonts.robotoMono(fontWeight: _semiBold, fontSize: 18.0),
      /***************************** */
      headline4: GoogleFonts.robotoMono(fontWeight: _medium, fontSize: 18.0),
      /***************************** */
      headline5: GoogleFonts.robotoMono(fontWeight: _regular, fontSize: 16.0),
      /***************************** */
      headline6: GoogleFonts.robotoMono(fontWeight: _regular, fontSize: 16.0),
      /***************************** */
      subtitle1: GoogleFonts.robotoMono(fontWeight: _regular, fontSize: 14.0),
      /***************************** */
      subtitle2: GoogleFonts.robotoMono(
          fontWeight: _light, fontSize: 12.0, color: hintColor),
      /***************************** */
      caption: GoogleFonts.robotoMono(fontWeight: _light, fontSize: 12.0),
      /***************************** */
      overline: GoogleFonts.robotoMono(
          fontWeight: _light, fontSize: 12.0, color: hintTextColor),
      /***************************** */
      bodyText1: GoogleFonts.robotoMono(fontWeight: _regular, fontSize: 16.0),
      /***************************** */
      bodyText2: GoogleFonts.robotoMono(fontWeight: _regular, fontSize: 14.0),
      /***************************** */

      button: GoogleFonts.robotoMono(fontWeight: _semiBold, fontSize: 14.0));
}
