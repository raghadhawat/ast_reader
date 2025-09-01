import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/core/widgets/text_field_icon.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField(
      {super.key,
      this.textEditingController,
      required this.icon,
      required this.hintText,
      this.keyboardType,
      this.showPass,
      this.onTap,
      this.isBorder = false});
  final TextEditingController? textEditingController;
  final Widget icon;
  final String hintText;
  final TextInputType? keyboardType;
  final bool? showPass;
  final void Function()? onTap;
  final bool? isBorder;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: keyboardType,
      cursorColor: kGreyColor,
      obscureText: showPass ?? false,
      validator: (data) {
        if (data!.isEmpty) {
          return 'Field is required';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle: AppStyles.styleRegular13(context)
              .copyWith(color: kGreyColor.withOpacity(.65)),
          prefixIcon: TextFieldIcon(icon: icon),
          suffix: GestureDetector(
            onTap: onTap,
            child: Text(showPass == null  
                ? ''
                : showPass!
                    ? 'show'
                    : 'hide'),
          ),
          suffixStyle:
              AppStyles.styleRegular17(context).copyWith(color: kGreyColor),
          filled: true,
          fillColor: kLightGrayColor.withOpacity(.3),
          focusedBorder: textBorder(),
          border: textBorder(),
          enabledBorder: textBorder()),
    );
  }

  OutlineInputBorder textBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            BorderSide(color: isBorder! ? kLightGrayColor : kGreyColor));
  }
}
