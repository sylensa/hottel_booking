// To parse this JSON data, do
//
//     final country = countryFromJson(jsonString);

import 'dart:convert';

Country countryFromJson(String str) => Country.fromJson(json.decode(str));

String countryToJson(Country data) => json.encode(data.toJson());

class Country {
  Country({
    this.status,
    this.data,
  });

  bool status;
  List<CountriesInfo> data;

  factory Country.fromJson(Map<String, dynamic> json) => Country(
    status: json["status"] == null ? null : json["status"],
    data: json["data"] == null ? null : List<CountriesInfo>.from(json["data"].map((x) => CountriesInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status == null ? null : status,
    "data": data == null ? null : List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class CountriesInfo {
  CountriesInfo({
    this.country,
    this.mcc,
    this.code,
    this.short,
    this.flag,
  });

  String country;
  String mcc;
  String code;
  String short;
  String flag;

  factory CountriesInfo.fromJson(Map<String, dynamic> json) => CountriesInfo(
    country: json["country"] == null ? null : json["country"],
    mcc: json["mcc"] == null ? null : json["mcc"],
    code: json["code"] == null ? null : json["code"],
    short: json["short"] == null ? null : json["short"],
    flag: json["flag"] == null ? null : json["flag"],
  );

  Map<String, dynamic> toJson() => {
    "country": country == null ? null : country,
    "mcc": mcc == null ? null : mcc,
    "code": code == null ? null : code,
    "short": short == null ? null : short,
    "flag": flag == null ? null : flag,
  };
}
