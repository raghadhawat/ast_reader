import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/app_assets.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/features/details/presentation/views/widgets/antibiotics_table.dart';
import 'package:ast_reader/features/details/presentation/views/widgets/details_view_body.dart';
import 'package:ast_reader/features/details/presentation/views/widgets/plate_photo.dart';
import 'package:ast_reader/features/capture/presentation/views/widgets/plate_situatution_choose.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AfterCaptureView extends StatelessWidget {
  const AfterCaptureView({super.key});

  @override
  Widget build(BuildContext context) {
    final data = <AntibioticMeasurement>[
      const AntibioticMeasurement(
          antibiotic: 'Amc 30', diameterMm: 23.6, status: Susceptibility.i),
      const AntibioticMeasurement(
          antibiotic: 'CIP 5', diameterMm: 18.4, status: Susceptibility.s),
      const AntibioticMeasurement(
          antibiotic: 'CN 10', diameterMm: 16.3, status: Susceptibility.r),
      const AntibioticMeasurement(
          antibiotic: 'Amc 30', diameterMm: 23.6, status: Susceptibility.i),
      const AntibioticMeasurement(
          antibiotic: 'Amc 30', diameterMm: 23.6, status: Susceptibility.i),
    ];

    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'plate details',
          style: AppStyles.arialBold(context, 23),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 17),
        child: SingleChildScrollView(
          child: Column(
            children: [
              PlateSituationChoose(),
              Gap(36),
              PlatePhoto(
                image: Image.asset(Assets.imagesTestPlate),
              ),
              DetailsViewBody(data: data),
            ],
          ),
        ),
      ),
    ));
  }
}
