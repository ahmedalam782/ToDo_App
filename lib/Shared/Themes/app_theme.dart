import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color lightPrimary = Color(0xffDFECDB);
  static const Color darkPrimary = Color(0xff060E1E);
  static const Color blue = Color(0xff5D9CEC);
  static const Color white = Color(0xffFFFFFF);
  static const Color green = Color(0xff61E757);
  static const Color grey = Color(0xffC8C9CB);
  static const Color black = Color(0xff141922);
  static const Color red = Color(0xffEC4B4B);

  static ThemeData lightTheme = ThemeData(
    dividerTheme: const DividerThemeData(
      color: blue,
      thickness: 2,
      indent: 6,
      endIndent: 6,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: white,
      elevation: 0,
      surfaceTintColor: Colors.white,
    ),
    primaryColor: blue,
    secondaryHeaderColor: white,
    primaryColorLight: black,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: blue,
    ),
    scaffoldBackgroundColor: lightPrimary,
    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: lightPrimary,
      elevation: 0,
      foregroundColor: black,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: white,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: white,
      selectedItemColor: blue,
      unselectedItemColor: grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: blue,
      foregroundColor: white,
      shape: CircleBorder(
        side: BorderSide(
          color: white,
          width: 4,
        ),
      ),
      elevation: 0,
      iconSize: 20,
    ),
    cardTheme: const CardTheme(
      color: white,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: white,
      shape: CircularNotchedRectangle(),
      padding: EdgeInsets.zero,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: white,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: black,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: blue,
      ),
      labelMedium: GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: black,
      ),
    ),
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    dividerTheme: const DividerThemeData(
      color: blue,
      thickness: 2,
      indent: 6,
      endIndent: 6,
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: black,
      elevation: 0,
      surfaceTintColor: Colors.white,
    ),
    primaryColorLight: white,
    primaryColor: blue,
    secondaryHeaderColor: black,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: blue,
    ),
    scaffoldBackgroundColor: darkPrimary,
    appBarTheme: AppBarTheme(
      centerTitle: false,
      backgroundColor: darkPrimary,
      elevation: 0,
      foregroundColor: white,
      titleTextStyle: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: black,
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      type: BottomNavigationBarType.fixed,
      backgroundColor: darkPrimary,
      selectedItemColor: blue,
      unselectedItemColor: grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      elevation: 0,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: blue,
      foregroundColor: white,
      shape: CircleBorder(
        side: BorderSide(
          color: black,
          width: 4,
        ),
      ),
      elevation: 0,
      iconSize: 20,
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: darkPrimary,
      shape: CircularNotchedRectangle(),
      padding: EdgeInsets.zero,
    ),
    cardTheme: const CardTheme(
      color: black,
    ),
    textTheme: TextTheme(
      titleLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w700,
        color: black,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: white,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: blue,
      ),
      labelMedium: GoogleFonts.roboto(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: white,
      ),
    ),
  );
}
