import 'package:ast_reader/constants.dart';
import 'package:ast_reader/core/utils/download_excel.dart';
import 'package:ast_reader/features/details/presentation/views/widgets/antibiotics_table.dart';
import 'package:ast_reader/features/details/presentation/views/widgets/notes_card.dart';
import 'package:ast_reader/features/details/presentation/views/widgets/patient_date_card.dart';
import 'package:ast_reader/features/home/data/models/all_plates_model/datum.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class DetailsViewBody extends StatelessWidget {
  const DetailsViewBody({
    super.key,
    required this.datum,
  });

  final Datum datum;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(18),
        PatientDateCard(
          patientName:
              '${datum.patient!.firstName!} ${datum.patient!.lastName!}',
          dateText: datum.createdAt.toString().substring(0, 10),
        ),
        Gap(18),
        NotesCard(
          notes: datum.notes!,
        ),
        Gap(18),
        AntibioticTableCard(
          items: datum.result!.antibioticDetections,
          // Customize anything:
          title: 'Antibiotic Measurements',
          headerAntibiotic: 'Antibiotic',
          headerDiameter: 'Diameter (mm)',
          headerStatus: 'S\\I\\R',
          onDownload: () {
            downloadExcelToAppDocs(
              context,
              urlOrPath:
                  '$kBaseUrl${datum.excelPath!}', // <-- the value you said you stored
              fileName: 'Result.xlsx',
            );
          },
        ),
        Gap(18),
      ],
    );
  }
}
