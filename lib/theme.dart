import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MThemeData {
  const MThemeData._();
  ///////gradient colors/////////////
  static const gradient1 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    tileMode: TileMode.repeated,
    colors: [
      secondaryColor,
      primaryColor,
    ],
  );

  static const gradient2 = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      primaryColor,
      secondaryColor,
    ],
  );
  /////// light theme
  /// static const primaryColor = Color(0xFF185A9D);
  ///static const secondaryColor = Color(0xFF43CEA2);
  ////////////////////
  static const accentColor = Color(0xFF038C8C);
  static const primaryColor = Color(0xFF01707A);
  static const secondaryColor = Color.fromARGB(255, 0, 191, 212);
  static const onSecondary = Color(0xFFD9D4D0);
  static const background = Color(0xFFEFCECE);
  static const surface = Color(0xFFCC9B9B);
  static const onPrimary = Color(0xFF00C788);
// black and white
  static const black = Color(0xFF000000);
  static const almostBlackColor = Color(0xFF22282F);
  static const white = Color(0xFFFFFFFF);
  static const almostWhiteColor = Color(0xFFF5F5F5);
  static const hintColor = Color.fromARGB(157, 255, 254, 254);
  static const errorColor = Color.fromARGB(255, 255, 0, 0);
  /////////////////////
  static const ColorScheme lightColorScheme = ColorScheme(
    primary: primaryColor,
    primaryContainer: primaryColor,
    secondary: secondaryColor,
    secondaryContainer: secondaryColor,
    background: background,
    surface: surface,
    onBackground: white,
    error: _lightFillColor,
    onError: _lightFillColor,
    onPrimary: _lightFillColor,
    onSecondary: accentColor,
    onSurface: _lightFillColor,
    brightness: Brightness.light,
  );

  static const ColorScheme darkColorScheme = ColorScheme(
    primary: primaryColor,
    primaryContainer: hintColor,
    secondary: secondaryColor,
    secondaryContainer: secondaryColor,
    surface: Color(0xFF2C3035),
    background: almostBlackColor,
    onBackground: Color(0xFF262626),
    error: _darkFillColor,
    onError: _darkFillColor,
    onPrimary: _darkFillColor,
    onSecondary: accentColor,
    onSurface: _darkFillColor,
    brightness: Brightness.dark,
  );
  /////////////////////////
  static const hintTextColor = Colors.grey;
  static const revenuColor = Color(0xFFC8AF8A);
  static const profitColor = Color.fromARGB(255, 255, 0, 85);
  static const salesColor = Color.fromARGB(255, 231, 131, 74);
  static const productColor = Color.fromARGB(255, 25, 179, 94);
  static const serviceColor = Color.fromARGB(255, 25, 66, 179);
  static const expensesColor = Color.fromARGB(255, 247, 166, 16);
  static const incomeColor = Color.fromARGB(255, 161, 15, 154);
  static const debtsColor = Color.fromARGB(255, 251, 30, 104);
//////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
  static final ButtonStyle raisedButtonStyleCancel = TextButton.styleFrom(
    textStyle: _textTheme.button!,
    //.copyWith(color: const Color.fromARGB(255, 0, 82, 206)),
    minimumSize: const Size(88, 36),
    elevation: 0,
    backgroundColor: Colors.transparent,
    //  foregroundColor: Colors.white.withOpacity(0.5),
    padding: const EdgeInsets.symmetric(horizontal: 8),
    shape: const RoundedRectangleBorder(
      side: BorderSide(color: primaryColor),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
  );

//////////////////////////////////////////////////////////////////////////////////////
  static final ButtonStyle raisedButtonStyleSave = TextButton.styleFrom(
    textStyle: _textTheme.button!,
    //.copyWith(color: const Color.fromARGB(255, 0, 82, 206)),
    minimumSize: const Size(88, 36),
    elevation: 0,
    backgroundColor: primaryColor,
    // foregroundColor: MThemeData.white,
    padding: const EdgeInsets.symmetric(horizontal: 8),
    shape: const RoundedRectangleBorder(
      //side: BorderSide(color: MThemeData.accentColorm),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
  );

////////////////////////////////////////////////////////////////////////////////////
  ///////////////////////////////////////////////////////////////////////////////////////

  static const _lightFillColor = Colors.black;
  static const _darkFillColor = Colors.white;

  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =
      themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
      colorScheme: colorScheme,
      textTheme: _textTheme,
      focusColor: focusColor,
      dialogBackgroundColor: colorScheme.secondaryContainer,
      iconTheme: IconThemeData(color: hintColor),
      // cursorColor: colorScheme.onPrimary,
      // textSelectionColor: colorScheme.primary,
      // textSelectionHandleColor: colorScheme.secondary,
      //disabledColor: colorScheme.onSurface,
      fontFamily: GoogleFonts.robotoSlab().fontFamily,
    );
  }

  static const _bold = FontWeight.bold;
  static const _semiBold = FontWeight.w600;
  static const _medium = FontWeight.w500;
  static const _regular = FontWeight.normal;
  static const _light = FontWeight.w300;

  static final TextTheme _textTheme = TextTheme(
    headline1: GoogleFonts.robotoSlab(fontWeight: _bold, fontSize: 22.0),
    /***************************** */
    headline2: GoogleFonts.sansita(fontWeight: _semiBold, fontSize: 20.0),
    /***************************** */
    headline3: GoogleFonts.sansita(fontWeight: _semiBold, fontSize: 18.0),
    /***************************** */
    headline4: GoogleFonts.robotoMono(fontWeight: _semiBold, fontSize: 16.0),
    /***************************** */
    headline5: GoogleFonts.robotoMono(fontWeight: _regular, fontSize: 16.0),
    /***************************** */
    headline6: GoogleFonts.robotoMono(fontWeight: _regular, fontSize: 14.0),
    /***************************** */
    subtitle1: GoogleFonts.robotoMono(fontWeight: _regular, fontSize: 12.0),
    /***************************** */
    subtitle2: GoogleFonts.robotoMono(
      fontWeight: _light,
      fontSize: 12.0,
    ),
    /***************************** */
    caption: GoogleFonts.robotoMono(fontWeight: _regular, fontSize: 12.0),
    /***************************** */
    overline: GoogleFonts.robotoMono(
        fontWeight: _light, fontSize: 12.0, color: hintTextColor),
    /***************************** */
    bodyText1: GoogleFonts.robotoMono(fontWeight: _regular, fontSize: 14.0),
    /***************************** */
    bodyText2: GoogleFonts.robotoMono(fontWeight: _bold, fontSize: 14.0),
    button: GoogleFonts.robotoMono(fontWeight: _medium, fontSize: 14.0),
    // displayLarge: GoogleFonts.robotoMono(fontWeight: _regular, fontSize: 34.0),
  );
}
