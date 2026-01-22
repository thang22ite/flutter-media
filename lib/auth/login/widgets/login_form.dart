import 'package:app_ui/app_ui.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_social_media/auth/login/login.dart';


class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
          EmailTextField(),
          SizedBox(height: AppSpacing.md),
          PasswordTextField()
      ],
    );
  }
}
