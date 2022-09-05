import 'package:flutter/material.dart';

class AppTheme{

  AppTheme._();

  ///light theme
  static final Color _iconColorLight = Colors.blueAccent.shade200;
  static const Color _lightPrimaryColor = Color(0xFF546E7A);
  static const Color _lightPrimaryVariantColor = Color(0xFF546E7A);
  static const Color _lightSecondaryColor = Colors.green;
  static const Color _lightOnPrimaryColor = Colors.black;

  ///dark theme
  static const Color _iconColorDark =  Color(0xccf44336);
  static const Color _darkPrimaryColor = Color(0xFF070b38);
  static const Color _darkPrimaryColorLight = Color(0xFF2D2B48);
  static const Color _darkPrimaryVariantColor = Color(0xFF000015);
  static const Color _darkSecondaryColor = Color(0xccf44336);
  static const Color _darkOnPrimaryColor = Color(0xFFb61827);

  static Color get iconColorLight => _iconColorLight;
  static final ThemeData lightTheme = ThemeData(
      appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color:_darkSecondaryColor,fontFamily: "Roboto",fontWeight: FontWeight.bold,fontSize: 26 ),
        color: _lightPrimaryVariantColor,
        iconTheme: IconThemeData(color: _lightOnPrimaryColor),
      ),
      colorScheme: const ColorScheme.light(
        primary: _lightPrimaryColor,
        secondary: _lightSecondaryColor,
        onPrimary: _lightOnPrimaryColor,
      ),
      iconTheme: IconThemeData(
        color: _iconColorLight,
      ),
      textTheme: _lightTextTheme,
      fontFamily: "Roboto",
      dividerTheme: const DividerThemeData(
          color: Colors.black12
      )

  );

  static final ThemeData darkTheme = ThemeData(
      scaffoldBackgroundColor: _darkPrimaryVariantColor,
      appBarTheme: const AppBarTheme(
        color: _darkPrimaryVariantColor,
        iconTheme: IconThemeData(color: _darkOnPrimaryColor),
      ),
      fontFamily: "Roboto",
      colorScheme: const ColorScheme.dark(
        primary: _darkPrimaryColor,
        primaryVariant: _darkPrimaryVariantColor,
        secondary: _darkSecondaryColor,
        onPrimary: _darkOnPrimaryColor,
        background: Colors.white12,
      ),
      iconTheme: const IconThemeData(
        color: _iconColorDark,
      ),
      textTheme: _darkTextTheme,
      dividerTheme: const DividerThemeData(
          color: Colors.white
      )  ).copyWith(platform: TargetPlatform.windows);

  static const TextTheme _lightTextTheme = TextTheme(
    headline1: _lightScreenHeading1TextStyle,
  );
  static const TextStyle _lightScreenHeading1TextStyle =
  TextStyle(fontSize: 26.0,fontWeight:FontWeight.bold, color: _lightOnPrimaryColor,fontFamily: "Roboto");


  static final TextTheme _darkTextTheme = TextTheme(
    headline1: _darkScreenHeading1TextStyle,

  );

  static final TextStyle _darkScreenHeading1TextStyle =
  _lightScreenHeading1TextStyle.copyWith(color: _darkOnPrimaryColor);






  static Color get darkPrimaryColorLight => _darkPrimaryColorLight;

  static Color get lightPrimaryColor => _lightPrimaryColor;


  static Color get lightPrimaryVariantColor => _lightPrimaryVariantColor;

  static TextStyle get darkScreenHeading1TextStyle =>
      _darkScreenHeading1TextStyle;

  static TextTheme get darkTextTheme => _darkTextTheme;

  static TextStyle get lightScreenHeading1TextStyle =>
      _lightScreenHeading1TextStyle;

  static TextTheme get lightTextTheme => _lightTextTheme;

  static Color get darkOnPrimaryColor => _darkOnPrimaryColor;

  static Color get darkSecondaryColor => _darkSecondaryColor;

  static Color get darkPrimaryVariantColor => _darkPrimaryVariantColor;

  static Color get darkPrimaryColor => _darkPrimaryColor;

  static Color get iconColorDark => _iconColorDark;

  static Color get lightOnPrimaryColor => _lightOnPrimaryColor;

  static Color get lightSecondaryColor => _lightSecondaryColor;
}