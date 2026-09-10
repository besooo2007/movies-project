import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/routes/App_Routes_name.dart';
import 'package:app/core/theme/AppColors.dart';
import 'package:app/features/auth/di/injection.dart';
import 'package:app/features/auth/presention/bloc/auth_bloc.dart';
import 'package:app/features/auth/presention/bloc/auth_state.dart';
import 'package:app/features/auth/presention/register/widgets/Language_Toggle_Switch.dart';
import 'package:app/features/auth/presention/register/widgets/carsuol.dart';
import 'package:app/features/auth/presention/register/widgets/register_forms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bounceable/flutter_bounceable.dart';
import 'package:go_router/go_router.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (_) => getIt<AuthBloc>(),
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.go(AppRoutesName.discovermovies);
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
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.black,
              elevation: 0,
              leading: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Bounceable(
                  onTap: () {
                    context.go(AppRoutesName.login);
                  },
                  child: Assets.icons.arrowBack.svg(
                    width: 21,
                  ),
                ),
              ),
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
                  const SizedBox(height: 25),

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

                  const SizedBox(height: 16),

                  const RegisterForms(),

                  const SizedBox(height: 16),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account ? ",
                        style: theme.textTheme.bodyLarge!.copyWith(
                          color: AppColors.textcolor,
                        ),
                      ),
                      Bounceable(
                        onTap: () {
                          context.go(AppRoutesName.login);
                        },
                        child: Text(
                          "Login",
                          style: theme.textTheme.bodyLarge!.copyWith(
                            color: AppColors.bottoncolora,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 18.5),

                  LanguageToggleSwitch(),

                  const SizedBox(height: 50),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}