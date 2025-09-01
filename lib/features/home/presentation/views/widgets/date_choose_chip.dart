
import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:flutter/material.dart';

class DateChooseChip extends StatelessWidget {
  const DateChooseChip({
    super.key,
    required this.label,
    required this.onTap,
  });

  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0xFFEDEDED), // light grey like the mock
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 8),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.calendar_today_outlined, size: 18, color: kGreyColor),
              const SizedBox(width: 8),
              Text(
                label,
                style: AppStyles.styleRegular13(context)
                    .copyWith(color: kGreyColor),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
