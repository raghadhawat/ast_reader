import 'image.dart';
import 'patient.dart';
import 'result.dart';

class Datum {
  int? id;
  Result? result;
  Patient? patient;
  String? notes;
  Image? image;
  String? excelPath;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.result,
    this.patient,
    this.notes,
    this.image,
    this.excelPath,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json['id'] as int?,
        result: json['result'] == null
            ? null
            : Result.fromJson(json['result'] as Map<String, dynamic>),
        patient: json['patient'] == null
            ? null
            : Patient.fromJson(json['patient'] as Map<String, dynamic>),
        notes: json['notes'] as String?,
        excelPath: json['excel_path'] as String?,
        image: json['image'] == null
            ? null
            : Image.fromJson(json['image'] as Map<String, dynamic>),
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'excel_path': excelPath,
        'result': result?.toJson(),
        'patient': patient?.toJson(),
        'notes': notes,
        'image': image?.toJson(),
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}
