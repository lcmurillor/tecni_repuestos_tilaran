import 'package:flutter/material.dart';
import 'color_style.dart';

class MainTheme {
  static const cardShadow = BoxShadow(
    color: Colors.black12,
    offset: Offset(0, 4),
    blurRadius: 16,
  );
  static final lightTheme = _build(false);
  static final darkTheme = _build(true);

  static ThemeData _build(bool dark) {
    final background = Color(dark ? 0xFF111315 : 0xFFF2F3F5);
    final surface = Color(dark ? 0xFF1D2024 : 0xFFFFFFFF);
    final text = Color(dark ? 0xFFF4F5F7 : 0xFF202328);
    final muted = Color(dark ? 0xFFB9BEC7 : 0xFF5D6571);
    final border = Color(dark ? 0xFF363B43 : 0xFFDDE1E6);
    final scheme =
        ColorScheme.fromSeed(
          seedColor: ColorStyle.mainRed,
          brightness: dark ? Brightness.dark : Brightness.light,
        ).copyWith(
          primary: Color(dark ? 0xFFFF7676 : 0xFFBB202B),
          onPrimary: Color(dark ? 0xFF350008 : 0xFFFFFFFF),
          primaryContainer: Color(dark ? 0xFF442329 : 0xFFFFE9EA),
          onPrimaryContainer: text,
          secondary: Color(dark ? 0xFF7EB8FF : 0xFF175DA8),
          onSecondary: Color(dark ? 0xFF071D36 : 0xFFFFFFFF),
          tertiary: Color(dark ? 0xFF70D6A2 : 0xFF167346),
          onTertiary: Color(dark ? 0xFF06291A : 0xFFFFFFFF),
          surface: surface,
          onSurface: text,
          onSurfaceVariant: muted,
          surfaceContainerLowest: background,
          surfaceContainerLow: surface,
          surfaceContainer: Color(dark ? 0xFF25292F : 0xFFECEFF2),
          surfaceContainerHigh: Color(dark ? 0xFF2B3037 : 0xFFE5E8ED),
          surfaceContainerHighest: Color(dark ? 0xFF323841 : 0xFFDDE2E8),
          outline: muted,
          outlineVariant: border,
        );
    return ThemeData(
      useMaterial3: true,
      brightness: scheme.brightness,
      colorScheme: scheme,
      fontFamily: 'Roboto',
      scaffoldBackgroundColor: background,
      canvasColor: surface,
      dividerColor: border,
      cardTheme: CardThemeData(
        color: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(22),
          side: BorderSide(color: border),
        ),
        clipBehavior: Clip.antiAlias,
      ),
      drawerTheme: DrawerThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
      ),
      listTileTheme: ListTileThemeData(
        textColor: text,
        iconColor: muted,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 2),
      ),
      iconTheme: IconThemeData(color: muted),
      appBarTheme: AppBarTheme(
        backgroundColor: surface,
        foregroundColor: text,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: scheme.surfaceContainer,
        hintStyle: TextStyle(color: muted),
        labelStyle: TextStyle(color: muted),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: scheme.primary, width: 2),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: const Size(48, 48),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: scheme.inverseSurface,
        contentTextStyle: TextStyle(color: scheme.onInverseSurface),
      ),
    );
  }
}
