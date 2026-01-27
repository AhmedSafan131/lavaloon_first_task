import 'package:flutter/material.dart';
import 'package:lavaloon_first_task/utils/translation_extension.dart';
import 'package:lavaloon_first_task/utils/app_color.dart';
import 'package:lavaloon_first_task/auth/sgin_up.dart';
import 'package:lavaloon_first_task/auth/reset_password.dart';
import 'package:lavaloon_first_task/app_ui/home/home_screen.dart';
import 'package:lavaloon_first_task/utils/app_assets.dart';
import 'package:lavaloon_first_task/utils/theme_extensions.dart';
import 'package:responsive_builder/responsive_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginScreen extends StatefulWidget {
  static const String routeName = '/login';
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;
  final GlobalKey<FormState> _loginFormKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
                  key: _loginFormKey,
                  child: SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(horizontal: horizontalPadding.w),
                    child: Column(
                      children: [
                        SizedBox(height: 20.h),
                        _buildLogo(sizing),
                        SizedBox(height: 20.h),
                        _buildWelcomeText(),
                        SizedBox(height: 32.h),
                        _buildEmailField(),
                        SizedBox(height: 20.h),
                        _buildPasswordField(),
                        SizedBox(height: 12.h),
                        _buildForgotPassword(),
                        SizedBox(height: 32.h),
                        _buildLoginButton(),
                        SizedBox(height: 24.h),
                        _buildSignUpLink(),
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

  Widget _buildWelcomeText() {
    return Column(
      children: [
        Text(
          'login_title'.trn,
          style: TextStyle(
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        SizedBox(height: 4.h),
        Text(
          'login_subtitle'.trn,
          style: TextStyle(fontSize: 16.sp, color: AppColors.primary),
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

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          Navigator.of(context).pushNamed(ResetPasswordScreen.routeName);
        },
        child: Text(
          'forgot_password'.trn,
          style: TextStyle(color: AppColors.primary, fontSize: 14.sp),
        ),
      ),
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: ElevatedButton(
        onPressed: () {
          final valid = _loginFormKey.currentState?.validate() ?? false;
          if (!valid) return;
          Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.whiteColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
          elevation: 0,
        ),
        child: Text(
          'login_button'.trn,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSignUpLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'no_account'.trn,
          style: TextStyle(color: AppColors.greyColor, fontSize: 14.sp),
        ),
        GestureDetector(
          onTap: () {
            Navigator.of(context).pushReplacementNamed(SignUpScreen.routeName);
          },
          child: Text(
            'signup_now'.trn,
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
