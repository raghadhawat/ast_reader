import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/functions/navigate_function.dart';
import 'package:ast_reader/core/utils/functions/snack_bar.dart';
import 'package:ast_reader/core/utils/service_locator.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/core/widgets/custom_button.dart';
import 'package:ast_reader/core/widgets/loading_button.dart';
import 'package:ast_reader/features/capture/data/repos/capture_repo_impl.dart';
import 'package:ast_reader/features/capture/presentation/manager/accept_plate_cubit/acceptplate_cubit.dart';
import 'package:ast_reader/features/capture/presentation/manager/confuse_plate_cubit/confuse_cubit.dart';
import 'package:ast_reader/features/capture/presentation/manager/reject_plate_cubit/reject_plate_cubit.dart';
import 'package:ast_reader/features/home/presentation/views/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
          'This is the result of your plate, please choose the situation of the plate to save the result',
          style: AppStyles.arialBold(context, 15),
        ),
        Gap(22),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocProvider(
              create: (context) =>
                  AcceptplateCubit(getIt.get<CaptureRepoImpl>()),
              child: BlocConsumer<AcceptplateCubit, AcceptplateState>(
                listener: (context, state) {
                  if (state is AcceptplateFailure) {
                    showAppError(context, state.errMessage);
                  }
                  if (state is AcceptplateSuccess) {
                    showAppSuccess(context, 'the plate accepted successfully');
                    navigateAndFinish(context, HomeView());
                  }
                },
                builder: (context, state) {
                  return state is AcceptplateLoading
                      ? ButtonLoading(width: 90, height: 40, color: kGreenColor)
                      : CustomButton(
                          onPressed: () {
                            BlocProvider.of<AcceptplateCubit>(context)
                                .acceptPlateCubitFun(plateId: 3);
                          },
                          text: Text(
                            'Acceptable',
                            style: AppStyles.arialBold(context, 14)
                                .copyWith(color: Colors.white),
                          ),
                          color: kGreenColor,
                        );
                },
              ),
            ),
            BlocProvider(
              create: (context) => ConfuseCubit(getIt.get<CaptureRepoImpl>()),
              child: BlocConsumer<ConfuseCubit, ConfuseState>(
                listener: (context, state) {
                  if (state is ConfuseFailure) {
                    showAppError(context, state.errMessage);
                  }
                  if (state is ConfuseSuccess) {
                    showAppSuccess(context, 'the plate situation is Confused');
                    navigateAndFinish(context, HomeView());
                  }
                },
                builder: (context, state) {
                  return state is ConfuseLoading
                      ? ButtonLoading(
                          width: 90, height: 40, color: kOrangeColor)
                      : CustomButton(
                          onPressed: () {
                            BlocProvider.of<ConfuseCubit>(context)
                                .confusePlateCubitFun(plateId: 3);
                          },
                          text: Text(
                            'Confusing',
                            style: AppStyles.arialBold(context, 14)
                                .copyWith(color: Colors.white),
                          ),
                          color: kOrangeColor,
                        );
                },
              ),
            ),
            BlocProvider(
              create: (context) =>
                  RejectPlateCubit(getIt.get<CaptureRepoImpl>()),
              child: BlocConsumer<RejectPlateCubit, RejectPlateState>(
                listener: (context, state) {
                  if (state is RejectPlateFailure) {
                    showAppError(context, state.errMessage);
                  }
                  if (state is RejectPlateSuccess) {
                    showAppSuccess(context, 'the plate rejected successfully');
                    navigateAndFinish(context, HomeView());
                  }
                },
                builder: (context, state) {
                  return state is RejectPlateLoading
                      ? ButtonLoading(width: 90, height: 40, color: kRedColor)
                      : CustomButton(
                          onPressed: () {
                            BlocProvider.of<RejectPlateCubit>(context)
                                .rejectPlateCubitFun(plateId: 2);
                          },
                          text: Text(
                            'Rejected',
                            style: AppStyles.arialBold(context, 14)
                                .copyWith(color: Colors.white),
                          ),
                          color: kRedColor,
                        );
                },
              ),
            )
          ],
        ),
      ],
    );
  }
}
