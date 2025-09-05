import 'dart:io';
import 'dart:developer';

import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/functions/navigate_function.dart';
import 'package:ast_reader/core/utils/functions/snack_bar.dart';
import 'package:ast_reader/core/utils/service_locator.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/features/capture/data/repos/capture_repo_impl.dart';
import 'package:ast_reader/features/capture/presentation/manager/add_photo_cubit/add_photo_cubit.dart';
import 'package:ast_reader/features/capture/presentation/views/after_capture_view.dart';
import 'package:ast_reader/features/capture/presentation/views/widgets/plate_photo_field.dart';
import 'package:ast_reader/features/capture/presentation/views/widgets/submit_analysis_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CaptureView extends StatefulWidget {
  const CaptureView({super.key});

  @override
  State<CaptureView> createState() => _CaptureViewState();
}

class _CaptureViewState extends State<CaptureView> {
  File? _plateFile; // <-- keep the picked file here

  @override
  Widget build(BuildContext context) {
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
                Text('Add photo', style: AppStyles.arialBold(context, 18)),
                const Gap(20),

                // pick photo and store it
                PlatePhotoField(
                  onPicked: (file) {
                    setState(() => _plateFile = file);
                    log('Picked file path: ${file.path}');
                  },
                ),

                const Gap(10),

                BlocProvider(
                  create: (_) => AddPhotoCubit(getIt.get<CaptureRepoImpl>()),
                  child: BlocConsumer<AddPhotoCubit, AddPhotoState>(
                    listener: (context, state) {
                      if (state is AddPhotoSuccess) {
                        showAppSuccess(
                            context, state.addPhotoModel.id!.toString());
                        navigateTo(context, AfterCaptureView());
                      } else if (state is AddPhotoFailure) {
                        showAppError(context, state.errMessage);
                      }
                    },
                    builder: (context, state) {
                      return SubmitAnalysisCard(
                        onSubmit: (patientName, notes) {
                          // validate file before calling repo
                          if (_plateFile == null) {
                            showAppError(context, 'Please add a photo first');
                            return;
                          }
                          context
                              .read<AddPhotoCubit>()
                              .addPhotoCubitFun(image: _plateFile!);

                          log('patient: $patientName');
                          log('notes: $notes');
                          log('sending file: ${_plateFile!.path}');
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
