import 'package:ast_reader/core/utils/app_assets.dart';
import 'package:ast_reader/core/utils/service_locator.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/core/widgets/fetch_error_widget.dart';
import 'package:ast_reader/features/home/data/repos/home_repo_impl.dart';
import 'package:ast_reader/features/home/presentation/manager/all_plates_cubit/all_plates_cubit.dart';
import 'package:ast_reader/features/home/presentation/views/widgets/result_card.dart';
import 'package:ast_reader/features/home/presentation/views/widgets/shimmer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class AllResultView extends StatelessWidget {
  const AllResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: BlocProvider(
        create: (context) => AllPlatesCubit(getIt.get<HomeRepoImpl>())
          ..getAllPlatesCubitFunction(),
        child: BlocBuilder<AllPlatesCubit, AllPlatesState>(
          builder: (context, state) {
            if (state is AllPlatesSuccess) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gap(23),
                  Text(
                    'All Result',
                    style: AppStyles.arialBold(context, 21),
                  ),
                  Expanded(
                    child: ListView.separated(
                        itemBuilder: (context, index) {
                          return ResultCard(
                            data: state.allPlatesModel.data![index],
                            onDownload: () {
                              // TODO: trigger your Excel export
                            },
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Gap(20);
                        },
                        itemCount: state.allPlatesModel.data!.length),
                  )
                ],
              );
            }
            if (state is AllPlatesLoading) {
              return Expanded(
                child: ListView.separated(
                  itemCount: 6,
                  separatorBuilder: (_, __) => const SizedBox(height: 18),
                  itemBuilder: (_, __) => const ResultCardShimmer(),
                ),
              );
            }
            if (state is AllPlatesFailure) {
              return FetchErrorWidget(
                onRetry: () {
                  BlocProvider.of<AllPlatesCubit>(context)
                      .getAllPlatesCubitFunction();
                },
                message: state.errMessage,
              );
            } else {
              return FetchErrorWidget(
                onRetry: () {
                  BlocProvider.of<AllPlatesCubit>(context)
                      .getAllPlatesCubitFunction();
                },
              );
            }
          },
        ),
      ),
    );
  }
}
