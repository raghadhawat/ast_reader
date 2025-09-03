import 'package:ast_reader/features/home/presentation/views/widgets/date_with_result_card_list.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AllResultView extends StatelessWidget {
  const AllResultView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Gap(23),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return DateWithResultCardList();
                },
                separatorBuilder: (context, index) {
                  return Gap(20);
                },
                itemCount: 2),
          )
        ],
      ),
    );
  }
}
