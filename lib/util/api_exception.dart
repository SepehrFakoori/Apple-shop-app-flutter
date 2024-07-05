import 'package:dio/dio.dart';

class ApiException implements Exception {
  int? code;
  String? message;
  Response<dynamic>? response;

  ApiException(this.code, this.message, {this.response}) {
    print("THE CODE ------------------------> ($code)");
    if (code != 400) {
      return;
    }
    if (message == "Moved Permanently ") {
      message = "مادر جنده";
    }
    if (message == "Failed to authenticate.") {
      message = "نام کاربری یا رمز عبور اشتباه است.";
    }
    if (message == "Failed to create record.") {
      if (response!.data['data']['username'] != null) {
        if (response!.data['data']['username']['message'] == "The username is invalid or already in use.") {
          message == "نام کاربری نا معتبر است یا قبلا گرفته شده است.";
        }
      }
    }
  }
}