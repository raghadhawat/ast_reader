
import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/app_assets.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/core/widgets/custom_button.dart';
import 'package:ast_reader/features/details/presentation/views/widgets/plate_photo.dart';
import 'package:flutter/material.dart';

class PlatePhotoStack extends StatelessWidget {
  const PlatePhotoStack({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PlatePhoto(
          image: Image.asset(Assets.imagesTestPlate),
        ),
        Positioned(
          top: 10,
          right: 20,
          child: CustomButton(
            onPressed: () {},
            padding: 5,
            text: Text(
              'Acceptable',
              style: AppStyles.arialBold(context, 12)
                  .copyWith(color: Colors.white),
            ),
            color: kGreenColor,
          ),
        ),
      ],
    );
  }
}
