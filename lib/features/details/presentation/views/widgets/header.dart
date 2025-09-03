import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: AppStyles.arialBold(context, 11).copyWith(color: kGreyColor));
  }
}
