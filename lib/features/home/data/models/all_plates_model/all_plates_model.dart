import 'datum.dart';

class AllPlatesModel {
  int? count;
  List<Datum>? data;

  AllPlatesModel({this.count, this.data});

  factory AllPlatesModel.fromJson(Map<String, dynamic> json) {
    return AllPlatesModel(
      count: json['count'] as int?,
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => Datum.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'count': count,
        'data': data?.map((e) => e.toJson()).toList(),
      };
}
