import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/routes/App_Routes_name.dart';
import 'package:app/core/widgets/botton.dart';
import 'package:app/core/widgets/textformfeild.dart';
import 'package:app/features/auth/presention/bloc/auth_bloc.dart';
import 'package:app/features/auth/presention/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterForms extends StatefulWidget {
  const RegisterForms({super.key});

  @override
  State<RegisterForms> createState() => _RegisterFormsState();
}

class _RegisterFormsState extends State<RegisterForms> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void register(BuildContext context) {
    if (nameController.text.trim().isEmpty ||
        emailController.text.trim().isEmpty ||
        passwordController.text.isEmpty ||
        confirmPasswordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all fields"),
        ),
      );
      return;
    }

    if (passwordController.text != confirmPasswordController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Passwords do not match"),
        ),
      );
      return;
    }

    context.read<AuthBloc>().add(
          SignUpRequested(
            name: nameController.text.trim(),
            email: emailController.text.trim(),
            password: passwordController.text,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomTextForm(
            controller: nameController,
            hintText: "Name",
            prefixIcon: Assets.icons.iden.image(),
          ),
        ),

        const SizedBox(height: 24),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomTextForm(
            controller: emailController,
            hintText: "Email",
            prefixIcon: Assets.icons.emailIcon.svg(),
          ),
        ),

        const SizedBox(height: 24),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomTextForm(
            controller: passwordController,
            hintText: "Password",
            obscureText: true,
            prefixIcon: Assets.icons.passwordIcon.svg(),
            suffixIcon: Assets.icons.hidden.image(
              height: 20,
              width: 20,
            ),
          ),
        ),

        const SizedBox(height: 24),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomTextForm(
            controller: confirmPasswordController,
            hintText: "Confirm Password",
            obscureText: true,
            prefixIcon: Assets.icons.passwordIcon.svg(),
            suffixIcon: Assets.icons.hidden.image(
              height: 20,
            ),
          ),
        ),

        const SizedBox(height: 24),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomTextForm(
            hintText: "Phone Number",
            prefixIcon: Assets.icons.phone.image(),
          ),
        ),

        const SizedBox(height: 24),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: CustomButton(
            text: "Create Account",
            onPressed: () {
              context.go(
                              AppRoutesName.login,
                            );
              
            },
          ),
        ),
      ],
    );
  }
}