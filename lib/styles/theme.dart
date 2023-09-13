import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:zoficash/styles/styles.dart';

class AppTheme {
  AppTheme({required this.context});

  final BuildContext context;

  ThemeData get lightTheme => ThemeData(
        scaffoldBackgroundColor: AppColors.white,
        fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          secondary: AppColors.white,
          primary: AppColors.black,
        ),
        primaryTextTheme: GoogleFonts.outfitTextTheme(
          ThemeData.dark().textTheme,
        ).apply(
          fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
          bodyColor: AppColors.black,
        ),
        textTheme: Theme.of(context).textTheme.apply(
              fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
              bodyColor: AppColors.black,
            ),
        iconTheme: ThemeData.dark().iconTheme.copyWith(
              color: AppColors.grey,
            ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.iOS: ZoomPageTransitionsBuilder(),
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          },
        ),
        // TextSelectionThemeData
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: AppColors.black,
        ),
        // AppBarTheme
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: AppColors.white,
          iconTheme: IconThemeData(color: AppColors.grey),
          actionsIconTheme: IconThemeData(color: AppColors.grey),
          titleTextStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
                fontWeight: FontWeight.w600,
                color: AppColors.grey,
              ),
        ),
        // ElevatedButtonThemeData
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 5,
            backgroundColor: AppColors.blue,
            foregroundColor: AppColors.white,
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
            textStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
                  fontWeight: FontWeight.w600,
                ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        // SnackBarThemeData
        snackBarTheme: SnackBarThemeData(
          backgroundColor: AppColors.grey,
          contentTextStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
                fontWeight: FontWeight.normal,
                color: AppColors.white,
              ),
        ),
        // InputDecorationTheme
        inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.symmetric(vertical: 15),
          hintStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
                fontWeight: FontWeight.normal,
                color: AppColors.grey,
              ),
          errorStyle: Theme.of(context).textTheme.labelMedium?.copyWith(
                fontFamily: GoogleFonts.ibmPlexSans().fontFamily,
                fontWeight: FontWeight.normal,
                color: AppColors.red,
              ),
        ),
        // CardTheme
        cardTheme: const CardTheme(
          elevation: 1,
          color: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
        ),
        // ListTileThemeData
        listTileTheme: ListTileThemeData(
          titleTextStyle: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: AppColors.black,
              ),
          subtitleTextStyle: Theme.of(context).textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.normal,
                color: AppColors.grey,
              ),
          leadingAndTrailingTextStyle:
              Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w500,
                    color: AppColors.black,
                  ),
        ),
      );
}
