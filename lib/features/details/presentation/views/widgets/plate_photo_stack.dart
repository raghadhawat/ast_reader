import 'package:ast_reader/constants.dart';
import 'package:ast_reader/features/details/presentation/views/widgets/plate_photo.dart';
import 'package:ast_reader/features/home/data/models/all_plates_model/datum.dart';
import 'package:flutter/material.dart';

class PlatePhotoStack extends StatelessWidget {
  const PlatePhotoStack({super.key, required this.data});
  final Datum data;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PlatePhoto(
          data: data,
        ),
        Positioned(
            top: 10,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
            )),
      ],
    );
  }
}

Color statusColor(String? status) {
  switch ((status ?? '').toLowerCase()) {
    case 'undetected':
      return kPrimaryColor; // your primary
    case 'done':
      return kGreenColor; // nice green; or define kGreenColor
    case 'rejected':
      return kRedColor;
    case 'confused':
      return kOrangeColor;
    default:
      return const Color(0xFF9CA3AF); // neutral grey fallback
  }
}
