import 'dart:io';

import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/functions/navigate_function.dart';
import 'package:ast_reader/core/utils/functions/snack_bar.dart';
import 'package:ast_reader/core/utils/service_locator.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/features/capture/data/repos/capture_repo_impl.dart';
import 'package:ast_reader/features/capture/presentation/manager/add_photo_cubit/add_photo_cubit.dart';
import 'package:ast_reader/features/capture/presentation/manager/create_plate_cubit/create_plate_cubit.dart';
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
  File? _plateFile;
  String? _firstName, _lastName, _number, _notes;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => AddPhotoCubit(getIt.get<CaptureRepoImpl>())),
        BlocProvider(
            create: (_) => CreatePlateCubit(getIt.get<CaptureRepoImpl>())),
      ],
      child: Builder(builder: (context) {
        // 👇 derive one isBusy flag from both cubits
        final addState = context.watch<AddPhotoCubit>().state;
        final createState = context.watch<CreatePlateCubit>().state;
        final isBusy = (addState is AddPhotoLoading) ||
            (createState is CreatePlateLoading);

        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              backgroundColor: kPrimaryColor,
              foregroundColor: Colors.white,
              centerTitle: true,
              title: Text('Capture plate',
                  style: AppStyles.arialBold(context, 23)),
            ),
            body: MultiBlocListener(
              listeners: [
                BlocListener<AddPhotoCubit, AddPhotoState>(
                  listener: (context, state) {
                    if (state is AddPhotoSuccess) {
                      final imageId = state.addPhotoModel.id;
                      if (imageId == null) {
                        showAppError(
                            context, 'Upload succeeded but imageId is null.');
                        return;
                      }
                      context.read<CreatePlateCubit>().createPlateCubitFun(
                            firstName: _firstName!,
                            lastName: _lastName!,
                            number: _number!,
                            notes: _notes ?? '',
                            imageId: imageId,
                          );
                    } else if (state is AddPhotoFailure) {
                      showAppError(context, state.errMessage);
                    }
                  },
                ),
                BlocListener<CreatePlateCubit, CreatePlateState>(
                  listener: (context, state) {
                    if (state is CreatePlateSuccess) {
                      showAppSuccess(context, 'Plate submitted for analysis.');

                      navigateTo(
                          context,
                          AfterCaptureView(
                            data: state.data,
                          ));
                    } else if (state is CreatePlateFailure) {
                      showAppError(context, state.errMessage);
                    }
                  },
                ),
              ],
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 17, vertical: 19),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Add photo',
                          style: AppStyles.arialBold(context, 18)),
                      const Gap(20),

                      PlatePhotoField(
                        onPicked: (file) {
                          setState(() => _plateFile = file);
                        },
                      ),

                      const Gap(10),

                      SubmitAnalysisCard(
                        isLoading:
                            isBusy, // 👈 show loader on button when either cubit is loading
                        onSubmit: (firstName, lastName, number, notes) {
                          if (_plateFile == null) {
                            showAppError(context, 'Please add a photo first.');
                            return;
                          }
                          _firstName = firstName;
                          _lastName = lastName;
                          _number = number;
                          _notes = notes;

                          context
                              .read<AddPhotoCubit>()
                              .addPhotoCubitFun(image: _plateFile!);
                        },
                      ),

                      // ⛔️ Remove the LinearProgressIndicator section, the button handles loading now.
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
