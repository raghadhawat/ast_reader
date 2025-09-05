import 'package:ast_reader/constants.dart';
import 'package:ast_reader/features/details/presentation/views/widgets/header.dart';
import 'package:flutter/material.dart';

class NotesCard extends StatelessWidget {
  const NotesCard({
    super.key,
    required this.notes,
    this.minHeight = 110, // tweak to match your mock height
  });

  final String notes;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      constraints: BoxConstraints(minHeight: minHeight),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(cardRadius),
        boxShadow: shadow,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Header('Notes'),
          const SizedBox(height: 8),
          Text(
            notes,
            style: const TextStyle(fontSize: 16.5, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
