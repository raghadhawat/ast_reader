import 'dart:developer';

import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/service_locator.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/core/widgets/custom_text_form_field.dart';
import 'package:ast_reader/core/widgets/fetch_error_widget.dart';
import 'package:ast_reader/features/home/data/repos/home_repo_impl.dart';
import 'package:ast_reader/features/home/presentation/manager/all_plates_cubit/all_plates_cubit.dart';
import 'package:ast_reader/features/home/presentation/views/widgets/date_choose_chip.dart';
import 'package:ast_reader/features/home/presentation/views/widgets/result_card.dart';
import 'package:ast_reader/features/home/presentation/views/widgets/shimmer_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  DateTime? _selectedDate;

  Future<void> _pickDate(BuildContext ctx) async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: ctx, // use INNER context
      initialDate: _selectedDate ?? now,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme:
                Theme.of(context).colorScheme.copyWith(primary: kPrimaryColor),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() => _selectedDate = picked);
      final y = picked.year.toString().padLeft(4, '0');
      final m = picked.month.toString().padLeft(2, '0');
      final d = picked.day.toString().padLeft(2, '0');
      ctx.read<AllPlatesCubit>().getAllPlatesCubitFunction(
          startDate: '$y-$m-$d', endDate: '$y-$m-$d');
    }
  }

  String _dateLabel() {
    if (_selectedDate == null) return 'choose a date';
    final y = _selectedDate!.year.toString().padLeft(4, '0');
    final m = _selectedDate!.month.toString().padLeft(2, '0');
    final d = _selectedDate!.day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AllPlatesCubit(getIt.get<HomeRepoImpl>())
        ..getAllPlatesCubitFunction(),
      child: Builder(
        // 👈 get INNER context that can see the cubit
        builder: (ctx) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Gap(23),

              // Search (OUTSIDE BlocBuilder; uses inner ctx)
              CustomTextFormField(
                isBorder: true,
                icon: Icon(Icons.search, color: kGreyColor),
                hintText: 'put the patient name',
                onChanged: (value) {
                  log(value);
                  ctx
                      .read<AllPlatesCubit>()
                      .getAllPlatesCubitFunction(firstName: value);
                },
              ),

              const Gap(18),

              // Date chip (OUTSIDE BlocBuilder; uses inner ctx)
              DateChooseChip(
                label: _dateLabel(),
                onTap: () => _pickDate(ctx),
              ),

              const Gap(22),
              Text('The Result', style: AppStyles.arialBold(context, 21)),
              const Gap(8),

              // Only the list is inside BlocBuilder
              Expanded(
                child: BlocBuilder<AllPlatesCubit, AllPlatesState>(
                  builder: (context, state) {
                    if (state is AllPlatesLoading) {
                      return ListView.separated(
                        itemCount: 6,
                        separatorBuilder: (_, __) => const SizedBox(height: 18),
                        itemBuilder: (_, __) => const ResultCardShimmer(),
                      );
                    }

                    if (state is AllPlatesFailure) {
                      return Center(
                        child: FetchErrorWidget(
                          onRetry: () => ctx
                              .read<AllPlatesCubit>()
                              .getAllPlatesCubitFunction(),
                          message: state.errMessage,
                        ),
                      );
                    }

                    if (state is AllPlatesSuccess) {
                      final items = state.allPlatesModel.data ?? const [];
                      if (items.isEmpty) {
                        return const Center(child: Text('No results found'));
                      }
                      return ListView.separated(
                        itemCount: items.length,
                        separatorBuilder: (_, __) => const SizedBox(height: 20),
                        itemBuilder: (_, index) {
                          return ResultCard(
                            data: items[index],
                            onDownload: () {
                              // TODO: Excel export
                            },
                          );
                        },
                      );
                    }

                    // Fallback
                    return Center(
                      child: FetchErrorWidget(
                        onRetry: () => ctx
                            .read<AllPlatesCubit>()
                            .getAllPlatesCubitFunction(),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
