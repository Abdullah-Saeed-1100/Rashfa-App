// To parse this JSON data, do
//
//     final juiceModel = juiceModelFromJson(jsonString);

import 'dart:convert';

List<JuiceModel> juiceModelFromJson(String str) =>
    List<JuiceModel>.from(json.decode(str).map((x) => JuiceModel.fromJson(x)));

String juiceModelToJson(List<JuiceModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JuiceModel {
  int? juicesId;
  String? juicesName;
  int? juicesPrice;
  String? juicesDescription;
  String? juicesImage;
  int? juicesUser;

  JuiceModel({
    this.juicesId,
    this.juicesName,
    this.juicesPrice,
    this.juicesDescription,
    this.juicesImage,
    this.juicesUser,
  });

  factory JuiceModel.fromJson(Map<String, dynamic> json) => JuiceModel(
        juicesId: json["juices_id"],
        juicesName: json["juices_name"],
        juicesPrice: json["juices_price"],
        juicesDescription: json["juices_description"],
        juicesImage: json["juices_image"],
        juicesUser: json["juices_user"],
      );

  Map<String, dynamic> toJson() => {
        "juices_id": juicesId,
        "juices_name": juicesName,
        "juices_price": juicesPrice,
        "juices_description": juicesDescription,
        "juices_image": juicesImage,
        "juices_user": juicesUser,
      };
}
