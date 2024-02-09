import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/theme/color.dart';


class AppSearchField extends StatelessWidget {
  final TextEditingController controller;
  final bool? obscureText;
  final Widget? suffixIcon;
  final String? hintText;
  final VoidCallback? onTap;
  final Widget? suffix;
  final bool? readOnly;
  final Function(String)? onChanged;

  const AppSearchField(
    this.controller, {
    this.hintText,
    this.obscureText,
    this.suffixIcon,
    this.onTap,
    this.suffix,
    this.readOnly,
    this.onChanged,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText ?? false,
      readOnly: readOnly ?? false,
      decoration: InputDecoration(
        hintStyle: TextStyle(
          color: AppColors.grey90.withOpacity(0.4),
        ),
        hintText: hintText,
        filled: true,
        fillColor: AppColors.mainGrey,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5.r),
          borderSide: BorderSide.none,
        ),
        contentPadding: EdgeInsets.all(10.r),
        prefixIcon: const Icon(Icons.search),
        suffixIcon: suffixIcon ?? const Offstage(),
        suffix: suffix ?? const Offstage(),
      ),
      onTap: onTap,
      onChanged: onChanged,
    );
  }
}
