import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/routes/App_Routes_name.dart';
import 'package:app/core/theme/AppColors.dart';
import 'package:app/core/widgets/botton.dart';
import 'package:app/core/widgets/textformfeild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:go_router/go_router.dart';

class ForgetView extends StatelessWidget {
  const ForgetView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Bounceable(onTap: () {   context.go(AppRoutesName.login);},
        child: Assets.icons.backArrowPng.image()),
        title: const Text(
          'Forget Password',
          style: TextStyle(
            color: AppColors.bottoncolora,
            fontWeight: FontWeight.w400,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Assets.images.forgotPasswordImg.image(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomTextForm(
              hintText: "Email",
              prefixIcon: Assets.icons.emailIcon.svg(),
            ),
          ),
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomButton(text: "Verify Email", onPressed: () {}),
          ),
        ],
      ),
    );
  }
}
