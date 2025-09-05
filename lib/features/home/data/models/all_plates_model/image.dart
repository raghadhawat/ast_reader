class Image {
  int? id;
  String? name;
  String? path;

  Image({this.id, this.name, this.path});

  factory Image.fromJson(Map<String, dynamic> json) => Image(
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
