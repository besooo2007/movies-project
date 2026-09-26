import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/routes/App_Routes_name.dart';
import 'package:app/core/theme/AppColors.dart';
import 'package:app/features/auth/presention/bloc/auth_bloc.dart';
import 'package:app/features/auth/presention/bloc/auth_event.dart';
import 'package:app/features/auth/presention/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({super.key});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  late final TextEditingController _nameController;
  late final TextEditingController _phoneController;

  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController(text: 'John Safwat');

    _phoneController = TextEditingController(text: '01200000000');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();

    super.dispose();
  }

  void _updateProfile() {
    if (_isUpdating) {
      return;
    }

    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter your name')));
      return;
    }

    if (phone.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter your phone')));
      return;
    }

    context.read<AuthBloc>().add(
      UpdateProfileRequested(name: name, phone: phone),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          setState(() {
            _isUpdating = true;
          });
        }

        if (state is AuthSuccess) {
          setState(() {
            _isUpdating = false;
          });

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message ?? 'Profile updated successfully'),
            ),
          );

          context.go(AppRoutesName.profile);
        }

        if (state is AuthFailure) {
          setState(() {
            _isUpdating = false;
          });

          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },

      child: Scaffold(
        backgroundColor: const Color(0xFF121312),

        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,

          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.bottoncolora),

            onPressed: () {
              context.go(AppRoutesName.profile);
            },
          ),

          title: const Text(
            'Update Profile',
            style: TextStyle(
              color: AppColors.bottoncolora,
              fontSize: 16,
              fontWeight: FontWeight.bold,
              fontFamily: 'Inter',
            ),
          ),
        ),

        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),

            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                const SizedBox(height: 24),

                Center(
                  child: ClipOval(
                    child: Assets.images.avatar1.image(
                      width: 140,
                      height: 140,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 36),

                TextFormField(
                  controller: _nameController,

                  enabled: !_isUpdating,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                  ),

                  decoration: InputDecoration(
                    filled: true,

                    fillColor: const Color(0xFF282A28),

                    prefixIcon: const Icon(Icons.person, color: Colors.white),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: AppColors.bottoncolora,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                TextFormField(
                  controller: _phoneController,

                  enabled: !_isUpdating,

                  keyboardType: TextInputType.phone,

                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontFamily: 'Inter',
                  ),

                  decoration: InputDecoration(
                    filled: true,

                    fillColor: const Color(0xFF282A28),

                    prefixIcon: const Icon(Icons.phone, color: Colors.white),

                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),

                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),

                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: AppColors.bottoncolora,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                Align(
                  alignment: Alignment.centerLeft,

                  child: GestureDetector(
                    onTap: _isUpdating
                        ? null
                        : () {
                            context.push(AppRoutesName.forgetPassword);
                          },

                    child: const Text(
                      'Reset Password',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: 'Inter',
                      ),
                    ),
                  ),
                ),

                const Spacer(),

                ElevatedButton(
                  onPressed: _isUpdating
                      ? null
                      : () {
                          // Delete Account
                        },

                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.red,

                    minimumSize: const Size(double.infinity, 56),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),

                  child: const Text(
                    'Delete Account',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Inter',
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                ElevatedButton(
                  onPressed: _isUpdating ? null : _updateProfile,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.bottoncolora,

                    disabledBackgroundColor: AppColors.bottoncolora.withValues(
                      alpha: 0.5,
                    ),

                    minimumSize: const Size(double.infinity, 56),

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),

                  child: _isUpdating
                      ? const SizedBox(
                          width: 24,
                          height: 24,

                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Color(0xFF121312),
                          ),
                        )
                      : const Text(
                          'Update Data',
                          style: TextStyle(
                            color: Color(0xFF121312),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),
                ),

                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
