import 'package:ast_reader/constants.dart';
import 'package:ast_reader/features/details/presentation/views/widgets/header.dart';
import 'package:flutter/material.dart';

class PatientDateCard extends StatelessWidget {
  const PatientDateCard({
    super.key,
    required this.patientName,
    required this.dateText, // e.g. "25-5-2025"
  });

  final String patientName;
  final String dateText;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(cardRadius),
        boxShadow: shadow,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // headers row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Header('Patient'),
              Header('Date'),
            ],
          ),
          const SizedBox(height: 8),
          // values row
          Row(
            children: [
              Expanded(
                child: Text(
                  patientName,
                  style: const TextStyle(
                    fontSize: 16.5,
                    color: Colors.black87,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 12),
              Text(dateText,
                  style: const TextStyle(
                    fontSize: 16.5,
                    color: Colors.black87,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
