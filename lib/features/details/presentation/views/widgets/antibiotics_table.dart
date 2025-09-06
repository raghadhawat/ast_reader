import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/app_assets.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/core/widgets/custom_button.dart';
import 'package:ast_reader/features/home/data/models/all_plates_model/result.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// --- Your badge stays as-is (needs Susceptibility)
enum Susceptibility { s, i, r }

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.status,
    this.textStyle,
    this.colorS = kGreenColor,
    this.colorI = kOrangeColor,
    this.colorR = kRedColor,
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.radius = 10,
  });

  final Susceptibility status;
  final TextStyle? textStyle;
  final Color colorS, colorI, colorR;
  final EdgeInsets padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final label = switch (status) { Susceptibility.s => 'S', Susceptibility.i => 'I', Susceptibility.r => 'R' };
    final bg = switch (status) { Susceptibility.s => colorS, Susceptibility.i => colorI, Susceptibility.r => colorR };
    return Container(
      padding: padding,
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(radius)),
      child: Text(label, style: textStyle ?? const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12)),
    );
  }
}



/// --- Table that uses BACKEND objects ---------------------------------------
class AntibioticTableCard extends StatelessWidget {
  const AntibioticTableCard({
    super.key,
    required this.items,                                    // now List<AntibioticDetection>
    this.title = 'Antibiotic Measurements',
    this.headerAntibiotic = 'Antibiotic',
    this.headerDiameter = 'Diameter (mm)',
    this.headerStatus = 'S\\I\\R',
    this.onDownload,
    this.cardColor = Colors.white,
    this.headerBg = const Color(0xFFE9E9E9),
    this.headerTextColor = const Color(0xFF777777),
    this.rowBg = const Color(0xFFF8F8F8),
    this.radius = 16,
    this.showShadow = true,
    this.rowSpacing = 8,
    this.titleStyle = const TextStyle(fontSize: 14.5, fontWeight: FontWeight.w600, color: Colors.black87),
    this.headerStyle = const TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600, color: Colors.black54),
    this.cellStyle = const TextStyle(fontSize: 15.5, fontWeight: FontWeight.w600, color: Colors.black87),
    this.leftButtonIcon,
    this.rightButtonIcon = const Icon(Icons.download_rounded, color: Colors.white),
    this.padding = const EdgeInsets.all(14),
    this.listPhysics = const NeverScrollableScrollPhysics(),
    this.listShrinkWrap = true,

    /// How to compute S/I/R from a detection. If null, a default simple rule is used.
    this.statusOf,

    /// Optional custom row builder if you want full control.
    this.rowBuilder,
  });

  final List<AntibioticDetection> items;
  final String title, headerAntibiotic, headerDiameter, headerStatus;
  final VoidCallback? onDownload;

  final Color cardColor, headerBg, headerTextColor, rowBg;
  final double radius;
  final bool showShadow;
  final double rowSpacing;
  final TextStyle titleStyle, headerStyle, cellStyle;
  final EdgeInsets padding;
  final ScrollPhysics listPhysics;
  final bool listShrinkWrap;
  final Widget? leftButtonIcon;
  final Widget rightButtonIcon;

  final Susceptibility Function(AntibioticDetection)? statusOf;
  final Widget Function(BuildContext, AntibioticDetection, int)? rowBuilder;

  // default simple classifier (adjust to your breakpoints)
  Susceptibility _defaultStatus(AntibioticDetection d) {
    final v = d.value ?? 0;
    if (v >= 20) return Susceptibility.s;
    if (v >= 15) return Susceptibility.i;
    return Susceptibility.r;
  }

  String _fmt(double? v) => (v ?? 0).toStringAsFixed(1);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: showShadow
            ? const [BoxShadow(color: Color(0x1A000000), blurRadius: 16, offset: Offset(0, 6))]
            : null,
      ),
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: titleStyle),
          const SizedBox(height: 10),

          _HeaderRow(
            bg: headerBg,
            radius: radius,
            textStyle: headerStyle.copyWith(color: headerTextColor),
            a: headerAntibiotic,
            b: headerDiameter,
            c: headerStatus,
          ),
          SizedBox(height: rowSpacing),

          ListView.separated(
            shrinkWrap: listShrinkWrap,
            physics: listPhysics,
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(height: rowSpacing),
            itemBuilder: (context, index) {
              final item = items[index];
              if (rowBuilder != null) return rowBuilder!(context, item, index);

              final status = (statusOf ?? _defaultStatus)(item);
              return _BackendRow(
                name: item.antibiotic?.name ?? '',
                diameter: _fmt(item.value),
                status: status,
                bg: rowBg,
                radius: radius,
                cellStyle: cellStyle,
              );
            },
          ),

          const SizedBox(height: 12),

          CustomButton(
            onPressed: onDownload ?? () {},
            text: Row(
              children: [
                SvgPicture.asset(Assets.imagesExcelIcon),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Download Excel',
                    textAlign: TextAlign.center,
                    style: AppStyles.styleRegular17(context).copyWith(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 10),
                rightButtonIcon,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// --- Row for BACKEND item ---------------------------------------------------
class _BackendRow extends StatelessWidget {
  const _BackendRow({
    required this.name,
    required this.diameter,
    required this.status,
    required this.bg,
    required this.radius,
    required this.cellStyle,
  });

  final String name;
  final String diameter;
  final Susceptibility status;
  final Color bg;
  final double radius;
  final TextStyle cellStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(radius)),
      child: Row(
        children: [
          Expanded(flex: 5, child: Text(name, style: cellStyle, overflow: TextOverflow.ellipsis)),
          Expanded(flex: 4, child: Text(diameter, style: cellStyle)),
          Expanded(flex: 3, child: Align(alignment: Alignment.centerRight, child: StatusBadge(status: status))),
        ],
      ),
    );
  }
}

/// --- Header row kept the same ----------------------------------------------
class _HeaderRow extends StatelessWidget {
  const _HeaderRow({
    required this.bg,
    required this.radius,
    required this.textStyle,
    required this.a,
    required this.b,
    required this.c,
  });

  final Color bg;
  final double radius;
  final TextStyle textStyle;
  final String a, b, c;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(color: bg, borderRadius: BorderRadius.circular(radius)),
      child: Row(
        children: [
          Expanded(flex: 5, child: Text(a, style: textStyle)),
          Expanded(flex: 4, child: Text(b, style: textStyle)),
          Expanded(flex: 3, child: Align(alignment: Alignment.centerRight, child: Text(c, style: textStyle))),
        ],
      ),
    );
  }
}
