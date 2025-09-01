
import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:flutter/material.dart';

class AuthInlineLink extends StatelessWidget {
  const AuthInlineLink(
      {super.key,
      required this.question,
      required this.actionText,
      required this.onTap});
  final String question;
  final String actionText;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 6,
      children: [
        Text(
          question,
          style: AppStyles.styleRegular17(context)
              .copyWith(color: kGreyColor, fontSize: 14),
        ),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.zero,
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: onTap,
          child: Text(
            actionText,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.underline,
              color: Color(0xFF1C6E70), // teal-ish like your mock
            ),
          ),
        ),
      ],
    );
  }
}
