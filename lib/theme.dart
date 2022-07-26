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
  static const primaryColor = Color(0xFF012326);
  static const secondaryColor = Color(0xff025159);
// black and white
  static const black = Color(0xFF000000);
  static const almostBlackColor = Color(0xFF22282F);
  static const white = Color(0xFFFFFFFF);
  static const almostWhiteColor = Color(0xFFF5F5F5);
  static const hintColor = Color(0x8D4A6474);
  static const errorColor = Color.fromARGB(255, 255, 0, 0);

  /////////////////////
  static ColorScheme lightColorScheme = ColorScheme(
    primary: primaryColor,
    primaryContainer: primaryColor,
    secondaryContainer: secondaryColor,
    errorContainer: errorColor,
    onErrorContainer: Colors.red.shade50,
    secondary: secondaryColor,
    onSecondaryContainer: almostBlackColor,
    surface: white,
    background: white,
    error: errorColor,
    onPrimary: white,
    onSecondary: white,
    onSurface: black,
    onBackground: black,
    onError: Colors.white,
    brightness: Brightness.light,
  );

  static ColorScheme darkColorScheme = ColorScheme(
    primary: primaryColor,
    primaryContainer: primaryColor,
    secondaryContainer: secondaryColor,
    errorContainer: errorColor,
    onErrorContainer: Colors.red.shade50,
    secondary: secondaryColor,
    onSecondaryContainer: almostWhiteColor,
    surface: almostBlackColor,
    background: black,
    error: errorColor,
    onPrimary: white,
    onSecondary: almostWhiteColor,
    onSurface: white,
    onBackground: black,
    onError: Colors.white,
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
//////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////
  static final ButtonStyle raisedButtonStyleCancel = TextButton.styleFrom(
    textStyle: _textTheme.button!
        .copyWith(color: const Color.fromARGB(255, 0, 82, 206)),
    minimumSize: const Size(120, 40),
    elevation: 0,
    backgroundColor: Colors.transparent,
    //  foregroundColor: Colors.white.withOpacity(0.5),
    padding: const EdgeInsets.symmetric(horizontal: 8),
    shape: const RoundedRectangleBorder(
      side: BorderSide(color: Color.fromARGB(195, 3, 187, 162)),
      borderRadius: BorderRadius.all(Radius.circular(6)),
    ),
  );

//////////////////////////////////////////////////////////////////////////////////////
  static final ButtonStyle raisedButtonStyleSave = TextButton.styleFrom(
    textStyle: _textTheme.button!
        .copyWith(color: const Color.fromARGB(255, 0, 82, 206)),
    minimumSize: const Size(120, 40),
    elevation: 0,
    backgroundColor: const Color.fromARGB(195, 3, 187, 162),
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
        // backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: hintColor),
        colorScheme: colorScheme,
        textTheme: _textTheme,
        buttonTheme: ButtonThemeData(
          buttonColor: colorScheme.primary,
          textTheme: ButtonTextTheme.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        focusColor: focusColor,

        ///#deprecated
        //accentColor: colorScheme.primary,

        scaffoldBackgroundColor: colorScheme.surface,
        cardColor: colorScheme.background,
        dividerColor: colorScheme.onSurface,

        ///#deprecated
        // cursorColor: colorScheme.onPrimary,
        // textSelectionColor: colorScheme.primary,
        // textSelectionHandleColor: colorScheme.secondary,
        indicatorColor: colorScheme.primary,
        hintColor: colorScheme.onSurface,
        errorColor: colorScheme.error,
        toggleableActiveColor: colorScheme.primary,
        unselectedWidgetColor: colorScheme.onSurface,
        disabledColor: colorScheme.onSurface,
        fontFamily: GoogleFonts.roboto().fontFamily,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          labelStyle: TextStyle(
            color: colorScheme.onSurface,
          ),
          hintStyle: TextStyle(
            color: colorScheme.onSurface,
          ),
          errorStyle: TextStyle(
            color: colorScheme.error,
          ),
        ),
        appBarTheme: AppBarTheme(
          color: colorScheme.background,
          elevation: 0,

          ///#deprecated
          // textTheme: _textTheme,
          // iconTheme: IconThemeData(
          //   color: hintColor,
          // ),
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: colorScheme.background,
          foregroundColor: colorScheme.onPrimary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ),
        snackBarTheme: SnackBarThemeData(
          backgroundColor: colorScheme.background,
          contentTextStyle: _textTheme.bodyText1,
        ),
        dialogTheme: DialogTheme(
          titleTextStyle: _textTheme.headline6,
          contentTextStyle: _textTheme.bodyText1,
        ),
        bottomSheetTheme: BottomSheetThemeData(
          backgroundColor: colorScheme.background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
        ));
  }

  static const _bold = FontWeight.bold;
  static const _semiBold = FontWeight.w600;
  static const _medium = FontWeight.w500;
  static const _regular = FontWeight.normal;
  static const _light = FontWeight.w300;

  static final TextTheme _textTheme = TextTheme(
      headline1: GoogleFonts.robotoSlab(fontWeight: _bold, fontSize: 24.0),
      /***************************** */
      headline2: GoogleFonts.sansita(fontWeight: _semiBold, fontSize: 22.0),
      /***************************** */
      headline3: GoogleFonts.sansita(fontWeight: _semiBold, fontSize: 18.0),
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
      bodyText1: GoogleFonts.robotoMono(fontWeight: _regular, fontSize: 14.0),
      /***************************** */
      bodyText2: GoogleFonts.robotoMono(fontWeight: _bold, fontSize: 14.0),
      // bodyMedium: GoogleFonts.robotoMono(
      //   fontWeight: _bold,
      //   fontSize: 14.0,
      // ),
      /***************************** */

      button: GoogleFonts.robotoMono(fontWeight: _semiBold, fontSize: 14.0));
}
