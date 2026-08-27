import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/theme/AppColors.dart';
import 'package:app/core/widgets/botton.dart';
import 'package:app/core/widgets/textformfeild.dart';
import 'package:app/feature/Register/presentation/ui/widgets/Language_Toggle_Switch.dart';
import 'package:app/feature/Register/presentation/ui/widgets/carsuol.dart';
import 'package:app/feature/Register/presentation/ui/widgets/register_forms.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Assets.icons.arrowBack.svg(),
        title: const Text(
          'Register',
          style: TextStyle(
            color: AppColors.bottoncolora,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 25),
            CaruselAvatars(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Avatar",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            RegisterForms(),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account ? ",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: AppColors.textcolor,
                  ),
                ),

                Text(
                  "Login",
                  style: theme.textTheme.bodyLarge!.copyWith(
                    color: AppColors.bottoncolora,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(height: 18.5),
            LanguageToggleSwitch(),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }
}
