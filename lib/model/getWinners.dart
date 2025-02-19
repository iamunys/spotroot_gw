// To parse this JSON data, do
//
//     final getWinners = getWinnersFromJson(jsonString);

import 'dart:convert';

List<GetWinners> getWinnersFromJson(String str) =>
    List<GetWinners>.from(json.decode(str).map((x) => GetWinners.fromJson(x)));

String getWinnersToJson(List<GetWinners> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GetWinners {
  String? id;
  ProfileImage? profileImage;
  int? kmsInHand;
  String? fullName;
  String? userName;
  String? phoneNumber;

  GetWinners({
    this.id,
    this.profileImage,
    this.kmsInHand,
    this.fullName,
    this.userName,
    this.phoneNumber,
  });

  factory GetWinners.fromJson(Map<String, dynamic> json) => GetWinners(
        id: json["_id"],
        profileImage: json["profileImage"] == null
            ? null
            : ProfileImage.fromJson(json["profileImage"]),
        kmsInHand: json["kmsInHand"],
        fullName: json["fullName"],
        userName: json["userName"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "profileImage": profileImage?.toJson(),
        "kmsInHand": kmsInHand,
        "fullName": fullName,
        "userName": userName,
        "phoneNumber": phoneNumber,
      };
}

class ProfileImage {
  String? compressed;
  String? resized;
  String? id;
  DateTime? createdAt;
  DateTime? updatedAt;

  ProfileImage({
    this.compressed,
    this.resized,
    this.id,
    this.createdAt,
    this.updatedAt,
  });

  factory ProfileImage.fromJson(Map<String, dynamic> json) => ProfileImage(
        compressed: json["compressed"],
        resized: json["resized"],
        id: json["_id"],
        createdAt: json["createdAt"] == null
            ? null
            : DateTime.parse(json["createdAt"]),
        updatedAt: json["updatedAt"] == null
            ? null
            : DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "compressed": compressed,
        "resized": resized,
        "_id": id,
        "createdAt": createdAt?.toIso8601String(),
        "updatedAt": updatedAt?.toIso8601String(),
      };
}
