import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class MyCoursesTab extends StatelessWidget {
  const MyCoursesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Text(
          'myCourses'.tr(),
          style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
        ),
      ),
    );
  }
}
