class AddPhotoModel {
  int? id;
  String? name;
  String? path;

  AddPhotoModel({this.id, this.name, this.path});

  factory AddPhotoModel.fromJson(Map<String, dynamic> json) => AddPhotoModel(
        id: json['id'] as int?,
        name: json['name'] as String?,
        path: json['path'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'path': path,
      };
}
