import 'package:app/core/gen/fonts.gen.dart';
import 'package:app/core/routes/App_Routes_name.dart';
import 'package:app/core/theme/AppColors.dart';
import 'package:app/core/widgets/botton.dart';
import 'package:app/core/widgets/textformfeild.dart';
import 'package:app/core/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'widgets/avatar_bottom_sheet.dart';

class UpdateProfileView extends StatefulWidget {
  const UpdateProfileView({super.key});

  @override
  State<UpdateProfileView> createState() => _UpdateProfileViewState();
}

class _UpdateProfileViewState extends State<UpdateProfileView> {
  int selectedAvatarIndex = 0;

  final List<AssetGenImage> avatars = [
    Assets.images.avatar1,
    Assets.images.avatar2,
    Assets.images.avatar3,
    Assets.images.avatar4,
    Assets.images.avatar5,
    Assets.images.avatar6,
    Assets.images.avatar7,
    Assets.images.avatar8,
    Assets.images.avatar9,
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        textTheme: Theme.of(
          context,
        ).textTheme.apply(fontFamily: FontFamily.roboto),
      ),
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: IconButton(
            icon: Assets.icons.arrowBack.svg(color: AppColors.yellow),
            onPressed: () => context.pop(),
          ),
          title: Text(
            "Pick Avatar",
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(color: AppColors.yellow),
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 24.0,
            ),
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: () async {
                            final result = await showModalBottomSheet<int>(
                              context: context,
                              backgroundColor: Colors.transparent,
                              builder: (context) => AvatarBottomSheet(
                                selectedIndex: selectedAvatarIndex,
                              ),
                            );
                            if (result != null) {
                              setState(() {
                                selectedAvatarIndex = result;
                              });
                            }
                          },
                          child: CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.transparent,
                            backgroundImage: avatars[selectedAvatarIndex]
                                .provider(),
                          ),
                        ),
                        const SizedBox(height: 32),
                        CustomTextForm(
                          hintText: "User Name",
                          prefixIcon: Assets.icons.user.svg(
                            width: 24,
                            height: 24,
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomTextForm(
                          hintText: "Phone Number",
                          prefixIcon: Assets.icons.phone.image(
                            width: 24,
                            height: 24,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {
                              context.go(AppRoutesName.forgetPassword);
                            },
                            child: Text(
                              "Reset Password",
                              style: Theme.of(context).textTheme.bodyLarge
                                  ?.copyWith(color: AppColors.textColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: "Delete Account",
                  onPressed: () {},
                  color: AppColors.red,
                ),
                const SizedBox(height: 16),
                CustomButton(
                  text: "Update Data",
                  onPressed: () {},
                  color: AppColors.bottoncolora,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
