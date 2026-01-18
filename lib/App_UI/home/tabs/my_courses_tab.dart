import 'package:flutter/material.dart';
import 'package:lavaloon_first_task/l10n/app_localizations.dart';

class MyCoursesTab extends StatelessWidget {
  const MyCoursesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Text(
          loc.myCourses,
          style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
        ),
      ),
    );
  }
}
