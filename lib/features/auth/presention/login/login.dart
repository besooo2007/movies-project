import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/theme/AppColors.dart';
import 'package:app/core/widgets/botton.dart';
import 'package:app/core/widgets/textformfeild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isOn = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(19.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 67),
                child: Center(
                  child: Assets.images.loginImg.image(width: 120, height: 118),
                ),
              ),

              CustomTextForm(
                hintText: "Email",
                prefixIcon: Assets.icons.emailIcon.svg(width: 31, height: 25),
              ),

              const SizedBox(height: 22),

              CustomTextForm(
                hintText: "Password",
                prefixIcon: Assets.icons.passwordIcon.svg(
                  width: 31,
                  height: 25,
                ),
                suffixIcon: const Icon(
                  Icons.visibility_off_sharp,
                  color: AppColors.textcolor,
                ),
              ),

              const SizedBox(height: 17),

              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "Forget Password?",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: AppColors.yellow,
                  ),
                ),
              ),

              const SizedBox(height: 33),

              CustomButton(text: "Login", onPressed: () {}),

              const SizedBox(height: 22),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppColors.textColor,
                    ),
                  ),
                  Bounceable(
                    onTap: () {},
                    child: Text(
                      " Create One",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: AppColors.bottoncolora,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 27),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: AppColors.bottoncolora,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Or",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: AppColors.bottoncolora,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        color: AppColors.bottoncolora,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              CustomButton(
                text: "Login With Google",
                image: Assets.icons.iconGoogle.svg(width: 20, height: 20),
                onPressed: () {},
              ),

              const SizedBox(height: 25),

              GestureDetector(
                onTap: () {
                  setState(() {
                    isOn = !isOn;
                  });
                },
                child: Container(
                  width: 90,
                  height: 45,
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppColors.bottoncolora,
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: !isOn
                                ? AppColors.bottoncolora
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Assets.images.lr.image(
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                      ),

                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: isOn
                                ? AppColors.bottoncolora
                                : Colors.transparent,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Assets.images.eg.image(
                              width: 25,
                              height: 25,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
