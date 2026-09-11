import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/routes/App_Routes_name.dart';
import 'package:app/core/theme/AppColors.dart';
import 'package:app/core/widgets/botton.dart';
import 'package:app/core/widgets/textformfeild.dart';
import 'package:app/features/auth/di/injection.dart';
import 'package:app/features/auth/presention/bloc/auth_bloc.dart';
import 'package:app/features/auth/presention/bloc/auth_event.dart';
import 'package:app/features/auth/presention/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:go_router/go_router.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isOn = false;
  bool isPasswordVisible = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void login(BuildContext context) {
    if (!formKey.currentState!.validate()) {
      return;
    }

    context.read<AuthBloc>().add(
      SignInRequested(
        email: emailController.text.trim(),
        password: passwordController.text,
      ),
    );
  }

  void loginWithGoogle(BuildContext context) {
    context.read<AuthBloc>().add(
      SignInWithGoogleRequested(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => getIt<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  state.message ?? 'Login successful',
                ),
              ),
            );

            context.go(AppRoutesName.home);
          }

          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        builder: (context, state) {
          final isLoading = state is AuthLoading;

          return Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(19.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 67,
                        ),
                        child: Center(
                          child: Assets.images.loginImg.image(
                            width: 120,
                            height: 118,
                          ),
                        ),
                      ),

                      CustomTextForm(
                        hintText: "Email",
                        controller: emailController,
                        prefixIcon: Assets.icons.emailIcon.svg(
                          width: 31,
                          height: 25,
                        ),
                        validator: (value) {
                          if (value == null ||
                              value.trim().isEmpty) {
                            return "Please enter your email";
                          }

                          if (!RegExp(
                            r'^[\w\.-]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value.trim())) {
                            return "Please enter a valid email";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 22),

                      CustomTextForm(
                        hintText: "Password",
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        prefixIcon: Assets.icons.passwordIcon.svg(
                          width: 31,
                          height: 25,
                        ),
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isPasswordVisible =
                                  !isPasswordVisible;
                            });
                          },
                          child: Icon(
                            isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off_sharp,
                            color: AppColors.textcolor,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your password";
                          }

                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 17),

                      Bounceable(
                        onTap: () {
                          context.go(
                            AppRoutesName.forgetPassword,
                          );
                        },
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Text(
                            "Forget Password?",
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: AppColors.yellow,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: 33),

                      CustomButton(
                        text: isLoading ? "Loading..." : "Login",
                        onPressed: () {
                          if (!isLoading) {
                            login(context);
                          }
                        },
                      ),

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
                            onTap: () {
                              context.go(
                                AppRoutesName.register,
                              );
                            },
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
                        padding: const EdgeInsets.symmetric(
                          horizontal: 50,
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: Divider(
                                thickness: 1,
                                color: AppColors.bottoncolora,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
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
                        text: isLoading
                            ? "Loading..."
                            : "Login With Google",
                        image: Assets.icons.iconGoogle.svg(
                          width: 20,
                          height: 20,
                        ),
                        onPressed: () {
                          if (!isLoading) {
                            loginWithGoogle(context);
                          }
                        },
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
            ),
          );
        },
      ),
    );
  }
}