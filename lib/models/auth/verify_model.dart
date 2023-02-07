import 'dart:convert';

class GetVerifyRequestModel {
  String? phonenumber;

  GetVerifyRequestModel({this.phonenumber});

  GetVerifyRequestModel.fromJson(Map<String, dynamic> json) {
    phonenumber = json['phonenumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phonenumber'] = this.phonenumber;
    return data;
  }
}

// class GetVerifyResponseModel {
//   String? code;
//   String? message;
//   Data1? data;

//   GetVerifyResponseModel({this.code, this.message, this.data});

//   GetVerifyResponseModel.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     message = json['message'];
//     data = json['data'] != null ? new Data1.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['code'] = this.code;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class Data1 {
//   String? verifyCode;

//   Data1({this.verifyCode});

//   Data1.fromJson(Map<String, dynamic> json) {
//     verifyCode = json['verifyCode'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['verifyCode'] = this.verifyCode;
//     return data;
//   }
// }

class CheckVerifyRequestModel {
  String? phonenumber;
  String? codeVerify;

  CheckVerifyRequestModel({this.phonenumber, this.codeVerify});

  CheckVerifyRequestModel.fromJson(Map<String, dynamic> json) {
    phonenumber = json['phonenumber'];
    codeVerify = json['code_verify'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['phonenumber'] = this.phonenumber;
    data['code_verify'] = this.codeVerify;
    return data;
  }
}

// class CheckVerifyResponseModel {
//   String? code;
//   String? message;
//   Data2? data;

//   CheckVerifyResponseModel({this.code, this.message, this.data});

//   CheckVerifyResponseModel.fromJson(Map<String, dynamic> json) {
//     code = json['code'];
//     message = json['message'];
//     data = json['data'] != null ? new Data2.fromJson(json['data']) : null;
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['code'] = this.code;
//     data['message'] = this.message;
//     if (this.data != null) {
//       data['data'] = this.data!.toJson();
//     }
//     return data;
//   }
// }

// class Data2 {
//   String? token;
//   String? id;
//   Null? active;

//   Data2({this.token, this.id, this.active});

//   Data2.fromJson(Map<String, dynamic> json) {
//     token = json['token'];
//     id = json['id'];
//     active = json['active'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['token'] = this.token;
//     data['id'] = this.id;
//     data['active'] = this.active;
//     return data;
//   }
// }

// GetVerifyResponseModel getVerifyResponseJson(String str) =>
//     GetVerifyResponseModel.fromJson(json.decode(str));

// CheckVerifyResponseModel checkVerifyResponseJson(String str) =>
//     CheckVerifyResponseModel.fromJson(json.decode(str));
