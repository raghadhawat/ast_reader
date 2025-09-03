import 'dart:developer';

import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/features/capture/presentation/views/widgets/plate_photo_field.dart';
import 'package:ast_reader/features/capture/presentation/views/widgets/submit_analysis_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CaptureView extends StatelessWidget {
  const CaptureView({super.key});

  @override
  Widget build(BuildContext context) {
    var file1;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          foregroundColor: Colors.white,
          centerTitle: true,
          title: Text('Capture plate', style: AppStyles.arialBold(context, 23)),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 19),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add photo',
                  style: AppStyles.arialBold(context, 18),
                ),
                Gap(20),
                PlatePhotoField(
                  onPicked: (file) {
                    file1 = file;
                  },
                ),
                Gap(10),
                SubmitAnalysisCard(
                  onSubmit: (patientName, notes) {
                    log(patientName);
                    log(notes);
                    log('Picked file path: ${file1}');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
