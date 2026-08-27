import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/widgets/botton.dart';
import 'package:app/core/widgets/textformfeild.dart';
import 'package:flutter/material.dart';

class RegisterForms extends StatelessWidget {
  const RegisterForms({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomTextForm(
            hintText: "Name",
            prefixIcon: Assets.icons.iden.image(),
          ),
        ),
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomTextForm(
            hintText: "Email",
            prefixIcon: Assets.icons.emailIcon.svg(),
          ),
        ),
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomTextForm(
            hintText: "Password",
            prefixIcon: Assets.icons.passwordIcon.svg(),
            suffixIcon: Assets.icons.hidden.image(height: 20, width: 20),
          ),
        ),
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomTextForm(
            hintText: "Confirm Password",
            prefixIcon: Assets.icons.passwordIcon.svg(),
            suffixIcon: Assets.icons.hidden.image(height: 20),
          ),
        ),
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomTextForm(
            hintText: "Phone Number",
            prefixIcon: Assets.icons.phone.image(),
          ),
        ),
        SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomButton(text: "Create Account", onPressed: () {}),
        ),
      ],
    );
  }
}
