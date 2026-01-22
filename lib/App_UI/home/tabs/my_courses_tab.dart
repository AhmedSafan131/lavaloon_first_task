import 'package:flutter/material.dart';
import 'package:lavaloon_first_task/utils/translation_extension.dart';
import 'package:lavaloon_first_task/utils/theme_extensions.dart';

class MyCoursesTab extends StatelessWidget {
  const MyCoursesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'myCourses'.trn,
        style: TextStyle(color: context.textTheme.bodyLarge?.color),
      ),
    );
  }
}
