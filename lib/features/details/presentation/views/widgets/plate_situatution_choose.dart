import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PlateSituationChoose extends StatelessWidget {
  const PlateSituationChoose({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(11),
        Text(
          'This is the result of you plate please choose the situation of the plate to save the result',
          style: AppStyles.arialBold(context, 15),
        ),
        Gap(22),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CustomButton(
              onPressed: () {},
              text: Text(
                'Acceptable',
                style: AppStyles.arialBold(context, 14)
                    .copyWith(color: Colors.white),
              ),
              color: kGreenColor,
            ),
            CustomButton(
              onPressed: () {},
              text: Text(
                'Confusing',
                style: AppStyles.arialBold(context, 14)
                    .copyWith(color: Colors.white),
              ),
              color: kOrangeColor,
            ),
            CustomButton(
              onPressed: () {},
              text: Text(
                'Rejected',
                style: AppStyles.arialBold(context, 14)
                    .copyWith(color: Colors.white),
              ),
              color: kRedColor,
            )
          ],
        ),
      ],
    );
  }
}
