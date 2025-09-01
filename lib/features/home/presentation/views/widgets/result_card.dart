
import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/app_assets.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({
    super.key,
    required this.name,
    required this.dateText, // e.g. "2025-8-25 . 14:25"
    required this.statusText, // e.g. "Confusing"
    required this.avatar, // AssetImage/NetworkImage/FileImage
    required this.onDownload,
  });

  final String name;
  final String dateText;
  final String statusText;
  final String avatar;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 16,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ---- Header (avatar, name/date, status badge)
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(avatar),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      dateText,
                      style: const TextStyle(
                        fontSize: 13.5,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: kOrangeColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  statusText,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12.5,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 14),

          // ---- Download button (full width, pill, icons left & right)
          CustomButton(
            onPressed: () {},
            text: Row(
              children: [
                SvgPicture.asset(Assets
                    .imagesExcelIcon), // swap with your Excel SVG if you have one
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Download Excel',
                    textAlign: TextAlign.center,
                    style: AppStyles.styleRegular17(context)
                        .copyWith(color: Colors.white),
                  ),
                ),
                SizedBox(width: 10),
                Icon(
                  Icons.download_rounded,
                  color: Colors.white,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
