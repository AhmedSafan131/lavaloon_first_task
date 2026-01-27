import 'package:flutter/material.dart';
import 'package:lavaloon_first_task/utils/translation_extension.dart';
import 'package:lavaloon_first_task/utils/app_color.dart';
import 'package:lavaloon_first_task/auth/login.dart';
import 'package:lavaloon_first_task/utils/app_assets.dart';
import 'package:lavaloon_first_task/utils/theme_extensions.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignUpScreen extends StatefulWidget {
  static const String routeName = '/signup';
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  final GlobalKey<FormState> _signUpFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ResponsiveBuilder(
        builder: (context, sizing) {
          final isDesktop = sizing.deviceScreenType == DeviceScreenType.desktop;
          final isTablet = sizing.deviceScreenType == DeviceScreenType.tablet;
          final horizontalPadding = isDesktop ? 64.0 : isTablet ? 40.0 : 24.0;
          final maxWidth = isDesktop
              ? 900.0
              : isTablet
              ? 700.0
              : 500.0;
          return SafeArea(
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxWidth),
                child: Form(
                  key: _signUpFormKey,
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        _buildLogo(sizing),
                        SizedBox(height: 20.h),
                        _buildTitle(),
                        SizedBox(height: 32.h),
                        _buildNameField(),
                        SizedBox(height: 20.h),
                        _buildEmailField(),
                        SizedBox(height: 20.h),
                        _buildPasswordField(),
                        SizedBox(height: 20.h),
                        _buildConfirmPasswordField(),
                        SizedBox(height: 32.h),
                        _buildSignUpButton(),
                        SizedBox(height: 24.h),
                        _buildLoginLink(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLogo(SizingInformation sizing) {
    return Image.asset(
      AppAssets.logoBlack,
      width: sizing.deviceScreenType == DeviceScreenType.desktop
          ? 180.w
          : sizing.deviceScreenType == DeviceScreenType.tablet
              ? 160.w
              : 120.w,
      height: sizing.deviceScreenType == DeviceScreenType.desktop
          ? 180.h
          : sizing.deviceScreenType == DeviceScreenType.tablet
              ? 160.h
              : 120.h,
      fit: BoxFit.contain,
    );
  }

  Widget _buildTitle() {
    return Text(
      'signup_title'.trn,
      style: TextStyle(
        fontSize: 28.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.primary,
      ),
    );
  }

  Widget _buildNameField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'name'.trn,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: context.textTheme.bodyMedium?.color,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(),
        ),
      ],
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'email'.trn,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: context.textTheme.bodyMedium?.color,
          ),
        ),
        SizedBox(height: 8.h),
        TextField(
          controller: _emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(),
        ),
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'password'.trn,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: context.textTheme.bodyMedium?.color,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _passwordController,
          obscureText: _obscurePassword,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
          validator: (value) {
            if ((value ?? '').length < 4) {
              return 'password_too_short'.trn;
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildConfirmPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'confirm_password'.trn,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            color: context.textTheme.bodyMedium?.color,
          ),
        ),
        SizedBox(height: 8.h),
        TextFormField(
          controller: _confirmPasswordController,
          obscureText: _obscureConfirmPassword,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: Icon(
                _obscureConfirmPassword
                    ? Icons.visibility_off
                    : Icons.visibility,
                color: Theme.of(context).iconTheme.color,
              ),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
          ),
          validator: (value) {
            if ((value ?? '').length < 4) {
              return 'password_too_short'.trn;
            }
            return null;
          },
        ),
      ],
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: () {
          final valid = _signUpFormKey.currentState?.validate() ?? false;
          if (!valid) return;
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          elevation: 0,
        ),
        child: Text(
          'signup_button'.trn,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildLoginLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'have_account'.trn,
          style: TextStyle(color: AppColors.blackColor, fontSize: 14.sp),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
          },
          child: Text(
            'login_link'.trn,
            style: TextStyle(
              color: AppColors.primary,
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
