import 'package:flutter/material.dart';
import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/core/widgets/custom_button.dart';

class FetchErrorWidget extends StatelessWidget {
  const FetchErrorWidget({
    super.key,
    this.title = 'Something went wrong',
    this.message =
        'We couldn’t load the results.\nPlease check your connection and try again.',
    required this.onRetry,
    this.compact = false, // set true if you want a smaller inline version
  });

  final String title;
  final String message;
  final VoidCallback onRetry;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Icon badge
        Container(
          width: compact ? 56 : 72,
          height: compact ? 56 : 72,
          decoration: BoxDecoration(
            color: kPrimaryColor.withOpacity(0.12),
            shape: BoxShape.circle,
          ),
          child: Icon(
            Icons.error_outline_rounded,
            color: kPrimaryColor,
            size: compact ? 28 : 34,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          title,
          textAlign: TextAlign.center,
          style: AppStyles.arialBold(context, compact ? 16 : 18),
        ),
        const SizedBox(height: 6),
        Text(
          message,
          textAlign: TextAlign.center,
          style: AppStyles.styleRegular17(context).copyWith(
            color: Colors.black54,
            fontSize: compact ? 13.5 : 14.5,
            height: 1.35,
          ),
        ),
        const SizedBox(height: 14),
        SizedBox(
          width: compact ? 170 : 200,
          child: CustomButton(
            onPressed: onRetry,
            text: Center(
              child: Text(
                'Retry',
                style: AppStyles.arialBold(context, compact ? 14 : 16).copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );

    return Padding(
      padding: EdgeInsets.all(compact ? 8 : 16),
      child: Center(child: content),
    );
  }
}
