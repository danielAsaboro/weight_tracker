import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weight_tracker/core/theme/color.dart';


class AppTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String? hintText;
  final VoidCallback? onTap;
  final Widget? suffix;
  final bool? readOnly;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final int? hintMaxLines;
  final String? initialValue;
  final void Function(String)? onChanged;

  const AppTextField(
    this.controller, {
    this.hintText,
    this.obscureText,
    this.suffixIcon,
    this.onTap,
    this.suffix,
    this.readOnly,
    this.validator,
    this.keyboardType,
    this.hintMaxLines,
    this.initialValue,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      readOnly: readOnly ?? false,
      validator: validator,
      keyboardType: keyboardType,
      initialValue: initialValue,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: AppColors.grey90.withOpacity(0.4),
        ),
        hintText: hintText,
        hintMaxLines: hintMaxLines,
        filled: true,
        fillColor: AppColors.mainGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.all(10.r),
        suffixIcon: suffixIcon ?? const Offstage(),
        suffix: suffix ?? const Offstage(),
        errorMaxLines: 2,
      ),
      onTap: onTap,
    );
  }
}
