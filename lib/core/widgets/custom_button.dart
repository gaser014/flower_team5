import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../values/app_colors.dart';
import '../values/app_font_style.dart';

enum ButtonVariant { filled, outlined }

class CustomButton extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool isEnabled;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double radius;
  final double? height;
  final Widget? child;
  final ButtonVariant variant;
  final BorderSide? borderSide;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.isLoading = false,
    this.isEnabled = true,
    this.backgroundColor,
    this.radius = 100,
    this.textColor,
    this.width,
    this.height,
    this.child,
    this.borderSide,
    this.variant = ButtonVariant.filled,
  });

  @override
  Widget build(BuildContext context) {
    final enabled = isEnabled && !isLoading && onPressed != null;

    if (variant == ButtonVariant.outlined) {
      return _OutlinedButton(
        text: text ?? '',
        onPressed: enabled ? onPressed : null,
        isLoading: isLoading,
        width: width,
        height: height,
        radius: radius,
        textColor: textColor,
        borderColor: backgroundColor,
        child: child,
      );
    }

    return _FilledButton(
      text: text ?? '',
      onPressed: enabled ? onPressed : null,
      isLoading: isLoading,
      enabled: enabled,
      width: width,
      radius: radius,
      height: height,
      backgroundColor: backgroundColor,
      textColor: textColor,
      borderSide: borderSide,
      child: child,
    );
  }
}

class _FilledButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final bool enabled;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final double radius;
  final Color? textColor;
  final BorderSide? borderSide;
  final Widget? child;

  const _FilledButton({
    required this.text,
    required this.onPressed,
    required this.isLoading,
    required this.enabled,
    required this.width,
    required this.radius,
    required this.height,
    this.backgroundColor,
    this.textColor,
    this.borderSide,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,

        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppColors.primerColor,
          disabledBackgroundColor: AppColors.grayA6,
          foregroundColor: textColor ?? AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
          side: borderSide,
          elevation: 0,
        ),
        child: isLoading
            ? const _LoadingIndicator()
            : child ??
                  Text(
                    text,
                    style: AppFontStyle.medium18(
                      context: context,
                    ).copyWith(color: textColor ?? AppColors.white),
                  ),
      ),
    );
  }
}

class _OutlinedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final double radius;
  final Color? textColor;
  final Color? borderColor;
  final Widget? child;

  const _OutlinedButton({
    required this.text,
    required this.onPressed,
    required this.isLoading,
    required this.width,
    required this.height,
    required this.radius,
    this.textColor,
    this.borderColor,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    final color = textColor ?? AppColors.gray53;

    return SizedBox(
      width: width ?? double.infinity,
      height: height,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          side: BorderSide(color: borderColor ?? color, width: 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
        child: isLoading
            ? _LoadingIndicator(color: color)
            : child ??
                  Text(
                    text,
                    style: AppFontStyle.medium18(
                      context: context,
                    ).copyWith(color: color),
                  ),
      ),
    );
  }
}

class _LoadingIndicator extends StatelessWidget {
  final Color? color;

  const _LoadingIndicator({this.color});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 24,
      child: CupertinoActivityIndicator(color: color ?? AppColors.white),
    );
  }
}
