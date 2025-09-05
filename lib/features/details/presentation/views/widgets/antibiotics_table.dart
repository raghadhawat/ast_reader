import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/app_assets.dart';
import 'package:ast_reader/core/utils/style.dart';
import 'package:ast_reader/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

/// ---- Data model ------------------------------------------------------------

enum Susceptibility { s, i, r }

class AntibioticMeasurement {
  final String antibiotic;
  final double diameterMm;
  final Susceptibility status;

  const AntibioticMeasurement({
    required this.antibiotic,
    required this.diameterMm,
    required this.status,
  });
}

/// ---- Badge widget (customizable) ------------------------------------------

class StatusBadge extends StatelessWidget {
  const StatusBadge({
    super.key,
    required this.status,
    this.textStyle,
    this.colorS = kGreenColor, // green
    this.colorI = kOrangeColor, // orange
    this.colorR = kRedColor, // red
    this.padding = const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    this.radius = 10,
  });

  final Susceptibility status;
  final TextStyle? textStyle;
  final Color colorS;
  final Color colorI;
  final Color colorR;
  final EdgeInsets padding;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final label = switch (status) {
      Susceptibility.s => 'S',
      Susceptibility.i => 'I',
      Susceptibility.r => 'R'
    };
    final bg = switch (status) {
      Susceptibility.s => colorS,
      Susceptibility.i => colorI,
      Susceptibility.r => colorR,
    };
    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Text(
        label,
        style: (textStyle ??
            const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 12,
            )),
      ),
    );
  }
}

/// ---- Table card ------------------------------------------------------------

class AntibioticTableCard extends StatelessWidget {
  const AntibioticTableCard({
    super.key,
    required this.items,
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
    this.titleStyle = const TextStyle(
      fontSize: 14.5,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    this.headerStyle = const TextStyle(
      fontSize: 12.5,
      fontWeight: FontWeight.w600,
      color: Colors.black54,
    ),
    this.cellStyle = const TextStyle(
      fontSize: 15.5,
      fontWeight: FontWeight.w600,
      color: Colors.black87,
    ),
    this.leftButtonIcon,
    this.rightButtonIcon =
        const Icon(Icons.download_rounded, color: Colors.white),
    this.padding = const EdgeInsets.all(14),
    this.listPhysics = const NeverScrollableScrollPhysics(),
    this.listShrinkWrap = true,
    this.rowBuilder,
  });

  final List<AntibioticMeasurement> items;

  // Texts
  final String title;
  final String headerAntibiotic;
  final String headerDiameter;
  final String headerStatus;

  // Actions
  final VoidCallback? onDownload;

  // Styling
  final Color cardColor;
  final Color headerBg;
  final Color headerTextColor;
  final Color rowBg;
  final double radius;
  final bool showShadow;
  final double rowSpacing;
  final TextStyle titleStyle;
  final TextStyle headerStyle;
  final TextStyle cellStyle;
  final EdgeInsets padding;

  // List behavior when placed in scrollables
  final ScrollPhysics listPhysics;
  final bool listShrinkWrap;

  // Download button icons
  final Widget? leftButtonIcon;
  final Widget rightButtonIcon;

  /// If provided, this overrides the default row layout.
  /// Signature: (context, item, index) => Widget
  final Widget Function(BuildContext, AntibioticMeasurement, int)? rowBuilder;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(radius),
        boxShadow: showShadow
            ? const [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 16,
                  offset: Offset(0, 6),
                ),
              ]
            : null,
      ),
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          Text(title, style: titleStyle),
          const SizedBox(height: 10),

          // Header row
          _HeaderRow(
            bg: headerBg,
            radius: radius,
            textStyle: headerStyle.copyWith(color: headerTextColor),
            a: headerAntibiotic,
            b: headerDiameter,
            c: headerStatus,
          ),
          SizedBox(height: rowSpacing),

          // Data rows
          ListView.separated(
            shrinkWrap: listShrinkWrap,
            physics: listPhysics,
            itemCount: items.length,
            separatorBuilder: (_, __) => SizedBox(height: rowSpacing),
            itemBuilder: (context, index) {
              final item = items[index];
              if (rowBuilder != null) {
                return rowBuilder!(context, item, index);
              }
              return _DefaultRow(
                item: item,
                bg: rowBg,
                radius: radius,
                cellStyle: cellStyle,
              );
            },
          ),

          const SizedBox(height: 12),

          // Download button
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

    return card;
  }
}

/// ---- Default row layout ----------------------------------------------------

class _DefaultRow extends StatelessWidget {
  const _DefaultRow({
    required this.item,
    required this.bg,
    required this.radius,
    required this.cellStyle,
  });

  final AntibioticMeasurement item;
  final Color bg;
  final double radius;
  final TextStyle cellStyle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Row(
        children: [
          // Antibiotic
          Expanded(
            flex: 5,
            child: Text(
              item.antibiotic,
              style: cellStyle,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Diameter
          Expanded(
            flex: 4,
            child: Text(
              item.diameterMm.toStringAsFixed(1),
              style: cellStyle,
            ),
          ),
          // Status
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: StatusBadge(status: item.status),
            ),
          ),
        ],
      ),
    );
  }
}

/// ---- Header row ------------------------------------------------------------

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
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(radius),
      ),
      child: Row(
        children: [
          Expanded(flex: 5, child: Text(a, style: textStyle)),
          Expanded(flex: 4, child: Text(b, style: textStyle)),
          Expanded(
            flex: 3,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(c, style: textStyle),
            ),
          ),
        ],
      ),
    );
  }
}
