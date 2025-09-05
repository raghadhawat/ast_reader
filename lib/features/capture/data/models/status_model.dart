class StatusModel {
  int? id;
  int? patientId;
  int? userId;
  int? mediaId;
  String? notes;
  DateTime? createdAt;
  DateTime? updatedAt;

  StatusModel({
    this.id,
    this.patientId,
    this.userId,
    this.mediaId,
    this.notes,
    this.createdAt,
    this.updatedAt,
  });

  factory StatusModel.fromJson(Map<String, dynamic> json) => StatusModel(
        id: json['id'] as int?,
        patientId: json['patientId'] as int?,
        userId: json['userId'] as int?,
        mediaId: json['mediaId'] as int?,
        notes: json['notes'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'patientId': patientId,
        'userId': userId,
        'mediaId': mediaId,
        'notes': notes,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}
