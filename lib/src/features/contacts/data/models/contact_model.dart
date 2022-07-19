// To parse this JSON data, do
//
//     final contactModel = contactModelFromJson(jsonString);

import 'dart:convert';

import 'package:isar/isar.dart';
part 'contact_model.g.dart';

ContactModel contactModelFromJson(String str) =>
    ContactModel.fromJson(json.decode(str));

String contactModelToJson(ContactModel data) => json.encode(data.toJson());

@Collection()
class ContactModel {
  ContactModel({
    this.id,
    required this.fname,
    required this.lname,
    required this.countryCode,
    required this.number,
    this.facebook,
    this.instagram,
    this.slack,
    this.skype,
    this.twiter,
    required this.country,
  });
@Id()
  int ?id;
  String fname;
  String lname;
  String countryCode;
  String number;
  String? facebook;
  String? instagram;
  String? slack;
  String? skype;
  String? twiter;
  String country;

  factory ContactModel.fromJson(Map<String, dynamic> json) => ContactModel(
        fname: json["fname"],
        lname: json["lname"],
        countryCode: json["countryCode"],
        number: json["number"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        slack: json["slack"],
        skype: json["skype"],
        twiter: json["twiter"],
        country: json["country"],
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        "fname": fname,
        "lname": lname,
        "countryCode": countryCode,
        "number": number,
        "facebook": facebook,
        "instagram": instagram,
        "slack": slack,
        "skype": skype,
        "twiter": twiter,
        "country": country,
      };
}
