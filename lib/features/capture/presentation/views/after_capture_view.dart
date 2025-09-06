import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/app_assets.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/features/details/presentation/views/widgets/antibiotics_table.dart';
import 'package:ast_reader/features/details/presentation/views/widgets/details_view_body.dart';
import 'package:ast_reader/features/details/presentation/views/widgets/plate_photo.dart';
import 'package:ast_reader/features/capture/presentation/views/widgets/plate_situatution_choose.dart';
import 'package:ast_reader/features/home/data/models/all_plates_model/datum.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AfterCaptureView extends StatelessWidget {
  const AfterCaptureView({super.key, required this.data});
  final Datum data;
  @override
  Widget build(BuildContext context) {
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
              Gap(36),
              PlatePhoto(
                data: data,
              ),
              DetailsViewBody(datum: data),
              PlateSituationChoose(
                id: data.id!,
              ),
              Gap(20)
            ],
          ),
        ),
      ),
    ));
  }
}
