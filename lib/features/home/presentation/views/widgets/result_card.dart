import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/app_assets.dart';
import 'package:ast_reader/core/utils/functions/navigate_function.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/core/widgets/custom_button.dart';
import 'package:ast_reader/features/details/presentation/views/details_view.dart';
import 'package:ast_reader/features/home/data/models/all_plates_model/datum.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({
    super.key,
    required this.onDownload,
    required this.data,
  });

  final VoidCallback onDownload;
  final Datum data;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        navigateTo(
            context,
            DetailsView(
              data: data,
            ));
      },
      child: Container(
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
                SizedBox(
                  height: 75,
                  width: 75,
                  child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                      child: CachedNetworkImage(
                          imageUrl: '$kBaseUrl${data.image!.path!}',
                          imageBuilder: (context, imageProvider) => Image(
                                image: imageProvider,
                                fit: BoxFit.fill,
                              ),
                          errorWidget: (context, url, error) {
                            return Icon(Icons.error_outline);
                          })),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${data.patient!.firstName!} ${data.patient!.lastName!}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data.createdAt.toString().substring(0, 19),
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
                    color: statusColor(data.result!.status),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    data.result!.status!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12.5,
                    ),
                  ),
                )
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
      ),
    );
  }
}

Color statusColor(String? status) {
  switch ((status ?? '').toLowerCase()) {
    case 'undetected':
      return kPrimaryColor; // your primary
    case 'accepted':
      return kGreenColor; // nice green; or define kGreenColor
    case 'rejected':
      return kRedColor;
    case 'confused':
      return kOrangeColor;
    default:
      return const Color(0xFF9CA3AF); // neutral grey fallback
  }
}
