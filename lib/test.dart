import 'package:ast_reader/core/utils/app_assets.dart';
import 'package:ast_reader/core/utils/download_excel.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomButton(
          onPressed: () {
            downloadExcelToAppDocs(
              context,
              urlOrPath:
                  'https://www.ou.edu/content/dam/cms/docs/sample-excel-file.xlsx', // <-- the value you said you stored
              fileName: 'Result_${DateTime.now()}.xlsx',
            );
          },
          text: Row(
            children: [
              SvgPicture.asset(Assets.imagesExcelIcon),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  'Download Excel',
                  textAlign: TextAlign.center,
                  style: AppStyles.styleRegular17(context)
                      .copyWith(color: Colors.white),
                ),
              ),
              const SizedBox(width: 10),
              const Icon(Icons.download_rounded, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}
