import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mytodo_app/src/constants/colors.dart';

final appTheme = _themeData();

ThemeData _themeData() {
  final base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: AppColors.primaryBlue,
      onPrimary: AppColors.primaryWhite,
      secondary: AppColors.secondaryBlue,
      onSecondary: AppColors.primaryWhite,
    ),
    iconTheme: base.iconTheme.copyWith(
      color: AppColors.primaryBlueLight,
    ),
    scaffoldBackgroundColor: AppColors.secondaryBlue,
    cardTheme: base.cardTheme.copyWith(
      color: AppColors.primaryBlue,
      elevation: 5.0,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(60.0)),
      ),
    ),
    checkboxTheme: base.checkboxTheme.copyWith(
      shape: const CircleBorder(),
    ),
    floatingActionButtonTheme: base.floatingActionButtonTheme.copyWith(
      backgroundColor: AppColors.tertiaryPink,
    ),
    appBarTheme: base.appBarTheme.copyWith(
      elevation: 0.0,
      color: AppColors.secondaryBlue,
    ),
    snackBarTheme: base.snackBarTheme.copyWith(
        shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(60.0)),
        backgroundColor: AppColors.tertiaryPink,
        behavior: SnackBarBehavior.fixed),
    listTileTheme: base.listTileTheme.copyWith(
        tileColor: AppColors.primaryBlue,
        textColor: AppColors.primaryWhite,
        iconColor: AppColors.secondaryBlueLight,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0))),
    textTheme: _textTheme(GoogleFonts.interTextTheme()),
  );
}

TextTheme _textTheme(TextTheme base) {
  return base
      .copyWith(
        overline: base.overline!.copyWith(
            color: AppColors.primaryBlueLight, fontWeight: FontWeight.w700),
        headline5: base.headline5!.copyWith(
            color: AppColors.primaryWhite, fontWeight: FontWeight.w700),
        bodyText1: base.bodyLarge!.copyWith(
          color: AppColors.primaryWhite,
        ),
      )
      .apply(
        displayColor: AppColors.primaryWhite,
      );
}
