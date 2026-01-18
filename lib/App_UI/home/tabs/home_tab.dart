import 'package:flutter/material.dart';
import 'package:lavaloon_first_task/l10n/app_localizations.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Center(
        child: Text(
          loc.home,
          style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
        ),
      ),
    );
  }
}
