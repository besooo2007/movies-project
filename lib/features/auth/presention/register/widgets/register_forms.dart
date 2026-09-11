import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/widgets/botton.dart';
import 'package:app/core/widgets/textformfeild.dart';
import 'package:app/features/auth/presention/bloc/auth_bloc.dart';
import 'package:app/features/auth/presention/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterForms extends StatefulWidget {
  const RegisterForms({super.key});

  @override
  State<RegisterForms> createState() => _RegisterFormsState();
}

class _RegisterFormsState extends State<RegisterForms> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  void register(BuildContext context) {
    if (!formKey.currentState!.validate()) {
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
    return Form(
      key: formKey,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomTextForm(
              controller: nameController,
              hintText: "Name",
              prefixIcon: Assets.icons.iden.image(),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter your name";
                }
                return null;
              },
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomTextForm(
              controller: emailController,
              hintText: "Email",
              prefixIcon: Assets.icons.emailIcon.svg(),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
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
                width: 20,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Please confirm your password";
                }

                if (value != passwordController.text) {
                  return "Passwords do not match";
                }

                return null;
              },
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomTextForm(
              controller: phoneController,
              hintText: "Phone Number",
              prefixIcon: Assets.icons.phone.image(),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Please enter your phone number";
                }

                return null;
              },
            ),
          ),

          const SizedBox(height: 24),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: CustomButton(
              text: "Create Account",
              onPressed: () {
                register(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}