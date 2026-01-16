
import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_social_media/auth/view/auth_page.dart';
import 'package:flutter_social_media/l10n/l10n.dart';



class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    context.customAdaptiveColor(light: AppColors.red, dark: AppColors.black);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: const AppTheme().theme,
      darkTheme: const AppDarkTheme().theme,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const AuthPage(),
    );
  }
}
