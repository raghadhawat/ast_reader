import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ResultCardShimmer extends StatelessWidget {
  const ResultCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    final base = Colors.black12;
    final highlight = Colors.black26;

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
      child: Shimmer.fromColors(
        baseColor: base,
        highlightColor: highlight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // ---- Header (avatar + text + badge)
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // avatar
                ClipRRect(
                  borderRadius: BorderRadius.circular(26),
                  child: Container(
                    width: 52,
                    height: 52,
                    color: base,
                  ),
                ),
                const SizedBox(width: 12),

                // name + date
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // name line
                      Container(
                        height: 16,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: base,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      const SizedBox(height: 8),
                      // date line (shorter)
                      Container(
                        height: 12,
                        width: MediaQuery.of(context).size.width * 0.35,
                        decoration: BoxDecoration(
                          color: base,
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                    ],
                  ),
                ),

                // status badge
                Container(
                  height: 26,
                  width: 76,
                  decoration: BoxDecoration(
                    color: base,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 14),

            // ---- Download button skeleton
            Container(
              height: 46,
              decoration: BoxDecoration(
                color: base,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
