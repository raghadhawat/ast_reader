import 'package:ast_reader/constants.dart';
import 'package:ast_reader/features/home/data/models/all_plates_model/datum.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PlatePhoto extends StatelessWidget {
  const PlatePhoto({
    super.key,
    this.radius = 16,
    this.aspectRatio = 16 / 10,
    required this.data, // tweak to your photo’s shape
  });

  final double radius;
  final double aspectRatio;
  final Datum data;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000), // ~10% black
            blurRadius: 12,
            offset: Offset(0, 4),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias, // ensures rounded corners clip the image
      child: AspectRatio(
          aspectRatio: aspectRatio,
          child: CachedNetworkImage(
              imageUrl: '$kBaseUrl${data.image!.path!}',
              imageBuilder: (context, imageProvider) => Image(
                    image: imageProvider,
                    fit: BoxFit.cover,
                  ),
              errorWidget: (context, url, error) {
                return Icon(Icons.error_outline);
              })),
    );
  }
}

// wherever you build it:
