import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:zoficash/styles/styles.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    super.key,
    this.minLines,
    this.maxLines,
    this.readOnly,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.controller,
    this.initialValue,
    this.keyboardType,
    required this.hintText,
    required this.onChanged,
  });

  final int? minLines;
  final int? maxLines;
  final bool? readOnly;
  final String hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? initialValue;
  final Function(String) onChanged;
  final TextInputType? keyboardType;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      minLines: minLines ?? 1,
      initialValue: initialValue,
      keyboardType: keyboardType,
      readOnly: readOnly ?? false,
      textInputAction: TextInputAction.next,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.normal,
        color: AppColors.black,
      ),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorText: errorText,
        hintText: hintText,
        isCollapsed: true,
      ),
      onChanged: (value) {
        onChanged.call(value);
      },
    );
  }
}

class PasswordTextFormFieldWidget extends StatelessWidget {
  const PasswordTextFormFieldWidget({
    super.key,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    required this.hintText,
    required this.onChanged,
    required this.obscureText,
  });

  final String hintText;
  final bool obscureText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function(String) onChanged;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      maxLines: 1,
      obscuringCharacter: "*",
      obscureText: !obscureText,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.visiblePassword,
      style: theme.textTheme.titleMedium?.copyWith(
        fontWeight: FontWeight.normal,
        color: AppColors.black,
      ),
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorText: errorText,
        hintText: hintText,
        isCollapsed: true,
      ),
      onChanged: (value) {
        onChanged.call(value);
      },
    );
  }
}

class AppRichTextSingle extends StatelessWidget {
  const AppRichTextSingle({
    super.key,
    required this.text,
    required this.actionText,
    required this.action,
  });

  final String text;
  final String actionText;
  final VoidCallback action;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        style: GoogleFonts.openSans(),
        children: [
          TextSpan(
            text: text,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: AppColors.grey,
              height: 1.5,
            ),
          ),
          TextSpan(
            text: actionText,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.blue,
              height: 1.5,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = (() {
                action.call();
              }),
          ),
        ],
      ),
    );
  }
}
