// lib/core/widgets/app_snackbar.dart
import 'package:flutter/material.dart';
import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/style.dart';

enum AppSnackType { error, success, info, warning }

void showAppSnackBar(
  BuildContext context, {
  required String message,
  AppSnackType type = AppSnackType.error,
  Duration duration = const Duration(seconds: 3),
  String? actionLabel,
  VoidCallback? onAction,
}) {
  // Colors/icons per type
  final Color bg;
  final IconData icon;
  switch (type) {
    case AppSnackType.success:
      bg = kPrimaryColor; // your teal
      icon = Icons.check_circle_rounded;
      break;
    case AppSnackType.info:
      bg = kGreenColor;
      icon = Icons.info_rounded;
      break;
    case AppSnackType.warning:
      bg = kOrangeColor; // or kOrangeColor if you prefer
      icon = Icons.warning_amber_rounded;
      break;
    case AppSnackType.error:
      bg = kRedColor;
      icon = Icons.error_outline_rounded;
      break;
  }

  // Dismiss any existing bar first
  final messenger = ScaffoldMessenger.of(context);
  messenger.hideCurrentSnackBar();

  messenger.showSnackBar(
    SnackBar(
      behavior: SnackBarBehavior.floating,
      elevation: 0,
      backgroundColor: Colors.transparent, // we’ll style the inner container
      margin: const EdgeInsets.all(16),
      duration: duration,
      content: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: bg,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: bg.withOpacity(.35),
              blurRadius: 14,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                message,
                style: AppStyles.styleRegular17(context)
                    .copyWith(color: Colors.white),
              ),
            ),
            if (actionLabel != null && onAction != null) ...[
              const SizedBox(width: 8),
              TextButton(
                onPressed: () {
                  messenger.hideCurrentSnackBar();
                  onAction();
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                ),
                child: Text(
                  actionLabel,
                  style: AppStyles.arialBold(context, 14)
                      .copyWith(color: Colors.white),
                ),
              ),
            ],
          ],
        ),
      ),
    ),
  );
}

/// Convenience helpers
void showAppError(BuildContext context, String message,
        {Duration duration = const Duration(seconds: 3)}) =>
    showAppSnackBar(context,
        message: message, type: AppSnackType.error, duration: duration);

void showAppSuccess(BuildContext context, String message,
        {Duration duration = const Duration(seconds: 2)}) =>
    showAppSnackBar(context,
        message: message, type: AppSnackType.success, duration: duration);
