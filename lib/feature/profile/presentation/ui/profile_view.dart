import 'package:app/core/gen/assets.gen.dart';
import 'package:app/core/routes/App_Routes_name.dart';
import 'package:app/core/theme/AppColors.dart';
import 'package:flutter/material.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121312),
      body: SafeArea(
        bottom: false,
        child: DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Column(
                      children: [
                        ClipOval(
                          child: Assets.images.avatar1.image(
                            width: 84,
                            height: 84,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'John Safwat',
                          style: TextStyle(
                            color: AppColors.textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ],
                    ),
                    const Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '12',
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Wish List',
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                '10',
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter',
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'History',
                                style: TextStyle(
                                  color: AppColors.textColor,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'Inter',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: [
                    Expanded(
                      flex: 5,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            AppRoutesName.updateprofile,
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.bottoncolora,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          'Edit Profile',
                          style: TextStyle(
                            color: Color(0xFF121312),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Inter',
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 3,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.red,
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Exit',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Inter',
                              ),
                            ),
                            SizedBox(width: 6),
                            Icon(
                              Icons.exit_to_app,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              const TabBar(
                indicatorColor: AppColors.bottoncolora,
                indicatorWeight: 3,
                indicatorSize: TabBarIndicatorSize.tab,
                dividerColor: Colors.transparent,
                labelColor: Colors.white,
                unselectedLabelColor: Colors.white,
                labelStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
                unselectedLabelStyle: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Inter',
                ),
                tabs: [
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.format_list_bulleted,
                          color: AppColors.bottoncolora,
                          size: 22,
                        ),
                        SizedBox(width: 8),
                        Text('Watch List'),
                      ],
                    ),
                  ),
                  Tab(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.folder,
                          color: AppColors.bottoncolora,
                          size: 22,
                        ),
                        SizedBox(width: 8),
                        Text('History'),
                      ],
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    Center(
                      child: Assets.images.empty.image(
                        width: 140,
                        height: 140,
                        fit: BoxFit.contain,
                      ),
                    ),
                    Center(
                      child: Assets.images.empty.image(
                        width: 140,
                        height: 140,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
