
import 'package:flutter/material.dart';

class PlatePhoto extends StatelessWidget {
  const PlatePhoto({
    super.key,
    required this.image, // AssetImage / NetworkImage / FileImage
    this.radius = 16,
    this.aspectRatio = 16 / 10, // tweak to your photo’s shape
  });

  final Widget image;
  final double radius;
  final double aspectRatio;

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
      child: AspectRatio(aspectRatio: aspectRatio, child: image),
    );
  }
}

// wherever you build it:
