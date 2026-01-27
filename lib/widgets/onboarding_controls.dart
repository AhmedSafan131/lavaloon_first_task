import 'package:flutter/material.dart';
import 'package:lavaloon_first_task/utils/translation_extension.dart';
import 'package:lavaloon_first_task/utils/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingControls extends StatelessWidget {
  final PageController controller;
  final bool isFirst;
  final bool isLast;
  final VoidCallback onDone;

  const OnboardingControls({
    super.key,
    required this.controller,
    required this.isFirst,
    required this.isLast,
    required this.onDone,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (!isFirst)
            TextButton(
              onPressed: () {
                controller.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              },
              child: Text(
                'back'.trn,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
              ),
            )
          else
            SizedBox(width: 80.w),
          ElevatedButton(
            onPressed: () {
              if (!isLast) {
                controller.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                onDone();
              }
            },
            style: ElevatedButton.styleFrom(
              minimumSize: Size(120.w, 44.h),
              backgroundColor: AppColors.primary,
              foregroundColor: AppColors.whiteColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.r),
                side: BorderSide(color: AppColors.primary),
              ),
            ),
            child: Text(isLast ? 'done'.trn : 'next'.trn),
          ),
        ],
      ),
    );
  }
}
