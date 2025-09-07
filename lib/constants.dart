import 'package:ast_reader/core/utils/secure_storage.dart';
import 'package:flutter/material.dart';

const kName = 'AST_READER';
const kBaseUrl = 'https://62e7f03ec0ca.ngrok-free.app/';
const kPrimaryColor = Color(0xFF1C6E70);
const kGreyColor = Color(0xff707070);
const kGreenColor = Color(0xff0D9488);
const kOrangeColor = Color(0xffF1872C);
const kRedColor = Color(0xffEF4444);
const kLightGrayColor = Color(0xffE7E7E7);
const cardRadius = 16.0;
const shadow = [
  BoxShadow(color: Color(0x1A000000), blurRadius: 16, offset: Offset(0, 6)),
];
const tokenKey = 'Token';
String? kToken;
Future<void> loadToken() async {
  kToken = await SecureStorage().readSecureData(tokenKey);
}
