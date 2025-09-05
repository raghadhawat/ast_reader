class SignUpModel {
  String? accessToken;
  String? refreshToken;

  SignUpModel({this.accessToken, this.refreshToken});

  factory SignUpModel.fromJson(Map<String, dynamic> json) => SignUpModel(
        accessToken: json['accessToken'] as String?,
        refreshToken: json['refreshToken'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'accessToken': accessToken,
        'refreshToken': refreshToken,
      };
}
