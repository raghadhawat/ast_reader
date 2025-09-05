class Result {
  final int? id;
  final int? plateId;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<AntibioticDetection> antibioticDetections;

  Result({
    this.id,
    this.plateId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.antibioticDetections = const [],
  });

  factory Result.fromJson(Map<String, dynamic> json) {
    final detectionsJson = json['antibioticDetections'];
    return Result(
      id: json['id'] as int?,
      plateId: json['plateId'] as int?,
      status: json['status'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      antibioticDetections: (detectionsJson is List)
          ? detectionsJson
              .map((e) => AntibioticDetection.fromJson(e as Map<String, dynamic>))
              .toList()
          : const [],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'plateId': plateId,
        'status': status,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
        'antibioticDetections':
            antibioticDetections.map((e) => e.toJson()).toList(),
      };
}

class AntibioticDetection {
  final int? id;
  final Antibiotic? antibiotic;
  final double? value;

  AntibioticDetection({
    this.id,
    this.antibiotic,
    this.value,
  });

  factory AntibioticDetection.fromJson(Map<String, dynamic> json) {
    return AntibioticDetection(
      id: json['id'] as int?,
      antibiotic: json['antibiotic'] == null
          ? null
          : Antibiotic.fromJson(json['antibiotic'] as Map<String, dynamic>),
      value: _asDouble(json['value']),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'antibiotic': antibiotic?.toJson(),
        'value': value,
      };
}

class Antibiotic {
  final int? id;
  final String? name;

  Antibiotic({this.id, this.name});

  factory Antibiotic.fromJson(Map<String, dynamic> json) => Antibiotic(
        id: json['id'] as int?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}

// Helper to safely parse numbers coming as int/double/string
double? _asDouble(dynamic v) {
  if (v == null) return null;
  if (v is num) return v.toDouble();
  if (v is String) return double.tryParse(v);
  return null;
}
