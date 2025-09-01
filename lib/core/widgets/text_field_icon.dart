import 'package:ast_reader/constants.dart';
import 'package:flutter/material.dart';

class TextFieldIcon extends StatelessWidget {
  const TextFieldIcon({
    super.key,
    required this.icon,
  });

  final Widget icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14),
        child: Row(
          children: [
            icon,
            const SizedBox(
              height: 30,
              child: VerticalDivider(
                color: kGreyColor,
                thickness: 1,
              ),
            )
          ],
        ),
      ),
    );
  }
}
