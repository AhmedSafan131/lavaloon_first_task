import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:lavaloon_first_task/utils/app_color.dart';
import 'package:lavaloon_first_task/app_ui/home/tabs/home_tab.dart';
import 'package:lavaloon_first_task/app_ui/home/tabs/my_courses_tab.dart';
import 'package:lavaloon_first_task/app_ui/home/tabs/blogs_tab.dart';
import 'package:lavaloon_first_task/app_ui/home/tabs/my_profile_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = const [
    HomeTab(),
    MyCoursesTab(),
    BlogsTab(),
    MyProfileTab(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCurrentPage(),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  Widget _buildCurrentPage() => _pages[_currentIndex];

  Widget _buildBottomNavBar() {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = Theme.of(context).cardColor;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.3 : 0.1),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: isDark ? AppColors.greyColor : AppColors.greyColor,
        selectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        unselectedLabelStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
        ),
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: _currentIndex == 0
                  ? AppColors.primary
                  : (isDark ? AppColors.greyColor : AppColors.greyColor),
            ),
            label: 'home'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.play_circle_outline,
              color: _currentIndex == 1
                  ? AppColors.primary
                  : (isDark ? AppColors.greyColor : AppColors.greyColor),
            ),
            label: 'myCourses'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.menu_book,
              color: _currentIndex == 2
                  ? AppColors.primary
                  : (isDark ? AppColors.greyColor : AppColors.greyColor),
            ),
            label: 'blogs'.tr(),
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person_outline,
              color: _currentIndex == 3
                  ? AppColors.primary
                  : (isDark ? AppColors.greyColor : AppColors.greyColor),
            ),
            label: 'myProfile'.tr(),
          ),
        ],
      ),
    );
  }
}
