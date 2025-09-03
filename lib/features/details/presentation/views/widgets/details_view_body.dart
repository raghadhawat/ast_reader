
import 'package:ast_reader/features/details/presentation/views/widgets/antibiotics_table.dart';
import 'package:ast_reader/features/details/presentation/views/widgets/notes_card.dart';
import 'package:ast_reader/features/details/presentation/views/widgets/patient_date_card.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DetailsViewBody extends StatelessWidget {
  const DetailsViewBody({
    super.key,
    required this.data,
  });

  final List<AntibioticMeasurement> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(18),
        PatientDateCard(
          patientName: 'John John',
          dateText: '25-5-2025',
        ),
        Gap(18),
        NotesCard(
          notes: 'This Plate Has Notes',
        ),
        Gap(18),
        AntibioticTableCard(
          items: data,
          // Customize anything:
          title: 'Antibiotic Measurements',
          headerAntibiotic: 'Antibiotic',
          headerDiameter: 'Diameter (mm)',
          headerStatus: 'S\\I\\R',
          onDownload: () {
            // call your Excel downloader here
          },
        ),
        Gap(18),
      ],
    );
  }
}
