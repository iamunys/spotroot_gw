// To parse this JSON data, do
//
//     final getAllUser = getAllUserFromJson(jsonString);

import 'dart:convert';

List<GetAllUser> getAllUserFromJson(String str) =>
    List<GetAllUser>.from(json.decode(str).map((x) => GetAllUser.fromJson(x)));

String getAllUserToJson(List<GetAllUser> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetAllUser {
  String? id;
  String? phoneNumber;
  int? kmsInHand;
  String? fullName;
  String? userName;

  GetAllUser({
    this.id,
    this.phoneNumber,
    this.kmsInHand,
    this.fullName,
    this.userName,
  });

  factory GetAllUser.fromJson(Map<String, dynamic> json) => GetAllUser(
        id: json["_id"],
        phoneNumber: json["phoneNumber"],
        kmsInHand: json["kmsInHand"],
        fullName: json["fullName"],
        userName: json["userName"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "phoneNumber": phoneNumber,
        "kmsInHand": kmsInHand,
        "fullName": fullName,
        "userName": userName,
      };
}
