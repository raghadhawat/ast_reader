import 'package:ast_reader/core/utils/app_assets.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/features/home/presentation/views/widgets/result_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class ConfussingView extends StatelessWidget {
  const ConfussingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Gap(23),
          Text(
            'Confused Result',
            style: AppStyles.arialBold(context, 21),
          ),
          Gap(20),
          Expanded(
            child: ListView.separated(
                itemBuilder: (context, index) {
                  return ResultCard(
                    name: 'John Doe',
                    dateText: '2025-8-25 . 14:25',
                    statusText: 'Confusing',
                    avatar: Assets.imagesTestCard,
                    onDownload: () {
                      // TODO: trigger your Excel export
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return Gap(18);
                },
                itemCount: 2),
          )
        ],
      ),
    );
  }
}
