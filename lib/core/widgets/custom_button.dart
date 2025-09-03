import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.onPressed,
      required this.text,
      this.color,
      this.padding});
  final VoidCallback onPressed;
  final Widget text;
  final Color? color;
  final double? padding;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: color ?? Color(0xFF1C6E70),
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(24),
        child: Padding(
            padding:
                EdgeInsets.symmetric(horizontal: padding ?? 20, vertical: 10),
            child: text),
      ),
    );
  }
}
