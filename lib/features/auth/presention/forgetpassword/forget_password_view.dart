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

class ForgetView extends StatefulWidget {
  const ForgetView({super.key});

  @override
  State<ForgetView> createState() => _ForgetViewState();
}

class _ForgetViewState extends State<ForgetView> {
  final emailController = TextEditingController();

  void resetPassword(BuildContext context) {
    if (emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please enter your email"),
        ),
      );
      return;
    }

    context.read<AuthBloc>().add(
          ResetPasswordRequested(
            email: emailController.text.trim(),
          ),
        );
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text(
                  "Password reset email sent successfully",
                ),
              ),
            );
          }

          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
              ),
            );
          }
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: Bounceable(
              onTap: () {
                context.go(AppRoutesName.login);
              },
              child: Assets.icons.backArrowPng.image(),
            ),
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
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: CustomTextForm(
                  controller: emailController,
                  hintText: "Email",
                  prefixIcon: Assets.icons.emailIcon.svg(),
                ),
              ),
              const SizedBox(height: 25),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                ),
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    final isLoading = state is AuthLoading;

                    return CustomButton(
                      text: isLoading
                          ? "Sending..."
                          : "Verify Email",
                      onPressed: () {
                        if (!isLoading) {
                          resetPassword(context);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

































