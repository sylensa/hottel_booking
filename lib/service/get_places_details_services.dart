// To parse this JSON data, do
//
//     final getPlacesDetails = getPlacesDetailsFromJson(jsonString);

import 'dart:convert';

GetPlacesDetails getPlacesDetailsFromJson(String str) => GetPlacesDetails.fromJson(json.decode(str));

String getPlacesDetailsToJson(GetPlacesDetails data) => json.encode(data.toJson());

class GetPlacesDetails {
  GetPlacesDetails({
    this.result,
    this.status,
  });

  List<dynamic> htmlAttributions;
  ResultDetails result;
  String status;

  factory GetPlacesDetails.fromJson(Map<String, dynamic> json) => GetPlacesDetails(
    result: json["result"] == null ? null : ResultDetails.fromJson(json["result"]),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "result": result == null ? null : result.toJson(),
    "status": status == null ? null : status,
  };
}

class ResultDetails {
  ResultDetails({
    this.addressComponents,
    this.adrAddress,
    this.businessStatus,
    this.formattedAddress,
    this.formattedPhoneNumber,
    this.geometry,
    this.icon,
    this.internationalPhoneNumber,
    this.name,
    this.openingHours,
    this.photos,
    this.placeId,
    this.plusCode,
    this.rating,
    this.reference,
    this.reviews,
    this.types,
    this.url,
    this.userRatingsTotal,
    this.utcOffset,
    this.vicinity,
    this.website,
  });

  List<AddressComponent> addressComponents;
  String adrAddress;
  String businessStatus;
  String formattedAddress;
  String formattedPhoneNumber;
  Geometry geometry;
  String icon;
  String internationalPhoneNumber;
  String name;
  OpeningHours openingHours;
  List<Photo> photos;
  String placeId;
  PlusCode plusCode;
  double rating;
  String reference;
  List<Review> reviews;
  List<String> types;
  String url;
  int userRatingsTotal;
  int utcOffset;
  String vicinity;
  String website;

  factory ResultDetails.fromJson(Map<String, dynamic> json) => ResultDetails(
    addressComponents: json["address_components"] == null ? null : List<AddressComponent>.from(json["address_components"].map((x) => AddressComponent.fromJson(x))),
    adrAddress: json["adr_address"] == null ? null : json["adr_address"],
    businessStatus: json["business_status"] == null ? null : json["business_status"],
    formattedAddress: json["formatted_address"] == null ? null : json["formatted_address"],
    formattedPhoneNumber: json["formatted_phone_number"] == null ? null : json["formatted_phone_number"],
    geometry: json["geometry"] == null ? null : Geometry.fromJson(json["geometry"]),
    icon: json["icon"] == null ? null : json["icon"],
    internationalPhoneNumber: json["international_phone_number"] == null ? null : json["international_phone_number"],
    name: json["name"] == null ? null : json["name"],
    openingHours: json["opening_hours"] == null ? null : OpeningHours.fromJson(json["opening_hours"]),
    photos: json["photos"] == null ? null : List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
    placeId: json["place_id"] == null ? null : json["place_id"],
    plusCode: json["plus_code"] == null ? null : PlusCode.fromJson(json["plus_code"]),
    rating: json["rating"] == null ? null : json["rating"].toDouble(),
    reference: json["reference"] == null ? null : json["reference"],
    reviews: json["reviews"] == null ? null : List<Review>.from(json["reviews"].map((x) => Review.fromJson(x))),
    types: json["types"] == null ? null : List<String>.from(json["types"].map((x) => x)),
    url: json["url"] == null ? null : json["url"],
    userRatingsTotal: json["user_ratings_total"] == null ? null : json["user_ratings_total"],
    utcOffset: json["utc_offset"] == null ? null : json["utc_offset"],
    vicinity: json["vicinity"] == null ? null : json["vicinity"],
    website: json["website"] == null ? null : json["website"],
  );

  Map<String, dynamic> toJson() => {
    "address_components": addressComponents == null ? null : List<dynamic>.from(addressComponents.map((x) => x.toJson())),
    "adr_address": adrAddress == null ? null : adrAddress,
    "business_status": businessStatus == null ? null : businessStatus,
    "formatted_address": formattedAddress == null ? null : formattedAddress,
    "formatted_phone_number": formattedPhoneNumber == null ? null : formattedPhoneNumber,
    "geometry": geometry == null ? null : geometry.toJson(),
    "icon": icon == null ? null : icon,
    "international_phone_number": internationalPhoneNumber == null ? null : internationalPhoneNumber,
    "name": name == null ? null : name,
    "opening_hours": openingHours == null ? null : openingHours.toJson(),
    "photos": photos == null ? null : List<dynamic>.from(photos.map((x) => x.toJson())),
    "place_id": placeId == null ? null : placeId,
    "plus_code": plusCode == null ? null : plusCode.toJson(),
    "rating": rating == null ? null : rating,
    "reference": reference == null ? null : reference,
    "reviews": reviews == null ? null : List<dynamic>.from(reviews.map((x) => x.toJson())),
    "types": types == null ? null : List<dynamic>.from(types.map((x) => x)),
    "url": url == null ? null : url,
    "user_ratings_total": userRatingsTotal == null ? null : userRatingsTotal,
    "utc_offset": utcOffset == null ? null : utcOffset,
    "vicinity": vicinity == null ? null : vicinity,
    "website": website == null ? null : website,
  };
}

class AddressComponent {
  AddressComponent({
    this.longName,
    this.shortName,
    this.types,
  });

  String longName;
  String shortName;
  List<String> types;

  factory AddressComponent.fromJson(Map<String, dynamic> json) => AddressComponent(
    longName: json["long_name"] == null ? null : json["long_name"],
    shortName: json["short_name"] == null ? null : json["short_name"],
    types: json["types"] == null ? null : List<String>.from(json["types"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "long_name": longName == null ? null : longName,
    "short_name": shortName == null ? null : shortName,
    "types": types == null ? null : List<dynamic>.from(types.map((x) => x)),
  };
}

class Geometry {
  Geometry({
    this.location,
    this.viewport,
  });

  Location location;
  Viewport viewport;

  factory Geometry.fromJson(Map<String, dynamic> json) => Geometry(
    location: json["location"] == null ? null : Location.fromJson(json["location"]),
    viewport: json["viewport"] == null ? null : Viewport.fromJson(json["viewport"]),
  );

  Map<String, dynamic> toJson() => {
    "location": location == null ? null : location.toJson(),
    "viewport": viewport == null ? null : viewport.toJson(),
  };
}

class Location {
  Location({
    this.lat,
    this.lng,
  });

  double lat;
  double lng;

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    lng: json["lng"] == null ? null : json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat == null ? null : lat,
    "lng": lng == null ? null : lng,
  };
}

class Viewport {
  Viewport({
    this.northeast,
    this.southwest,
  });

  Location northeast;
  Location southwest;

  factory Viewport.fromJson(Map<String, dynamic> json) => Viewport(
    northeast: json["northeast"] == null ? null : Location.fromJson(json["northeast"]),
    southwest: json["southwest"] == null ? null : Location.fromJson(json["southwest"]),
  );

  Map<String, dynamic> toJson() => {
    "northeast": northeast == null ? null : northeast.toJson(),
    "southwest": southwest == null ? null : southwest.toJson(),
  };
}

class OpeningHours {
  OpeningHours({
    this.openNow,
    this.periods,
    this.weekdayText,
  });

  bool openNow;
  List<Period> periods;
  List<String> weekdayText;

  factory OpeningHours.fromJson(Map<String, dynamic> json) => OpeningHours(
    openNow: json["open_now"] == null ? null : json["open_now"],
    periods: json["periods"] == null ? null : List<Period>.from(json["periods"].map((x) => Period.fromJson(x))),
    weekdayText: json["weekday_text"] == null ? null : List<String>.from(json["weekday_text"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "open_now": openNow == null ? null : openNow,
    "periods": periods == null ? null : List<dynamic>.from(periods.map((x) => x.toJson())),
    "weekday_text": weekdayText == null ? null : List<dynamic>.from(weekdayText.map((x) => x)),
  };
}

class Period {
  Period({
    this.close,
    this.open,
  });

  Close close;
  Close open;

  factory Period.fromJson(Map<String, dynamic> json) => Period(
    close: json["close"] == null ? null : Close.fromJson(json["close"]),
    open: json["open"] == null ? null : Close.fromJson(json["open"]),
  );

  Map<String, dynamic> toJson() => {
    "close": close == null ? null : close.toJson(),
    "open": open == null ? null : open.toJson(),
  };
}

class Close {
  Close({
    this.day,
    this.time,
  });

  int day;
  String time;

  factory Close.fromJson(Map<String, dynamic> json) => Close(
    day: json["day"] == null ? null : json["day"],
    time: json["time"] == null ? null : json["time"],
  );

  Map<String, dynamic> toJson() => {
    "day": day == null ? null : day,
    "time": time == null ? null : time,
  };
}

class Photo {
  Photo({
    this.height,
    this.htmlAttributions,
    this.photoReference,
    this.width,
  });

  int height;
  List<String> htmlAttributions;
  String photoReference;
  int width;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
    height: json["height"] == null ? null : json["height"],
    htmlAttributions: json["html_attributions"] == null ? null : List<String>.from(json["html_attributions"].map((x) => x)),
    photoReference: json["photo_reference"] == null ? null : json["photo_reference"],
    width: json["width"] == null ? null : json["width"],
  );

  Map<String, dynamic> toJson() => {
    "height": height == null ? null : height,
    "html_attributions": htmlAttributions == null ? null : List<dynamic>.from(htmlAttributions.map((x) => x)),
    "photo_reference": photoReference == null ? null : photoReference,
    "width": width == null ? null : width,
  };
}

class PlusCode {
  PlusCode({
    this.compoundCode,
    this.globalCode,
  });

  String compoundCode;
  String globalCode;

  factory PlusCode.fromJson(Map<String, dynamic> json) => PlusCode(
    compoundCode: json["compound_code"] == null ? null : json["compound_code"],
    globalCode: json["global_code"] == null ? null : json["global_code"],
  );

  Map<String, dynamic> toJson() => {
    "compound_code": compoundCode == null ? null : compoundCode,
    "global_code": globalCode == null ? null : globalCode,
  };
}

class Review {
  Review({
    this.authorName,
    this.authorUrl,
    this.language,
    this.profilePhotoUrl,
    this.rating,
    this.relativeTimeDescription,
    this.text,
    this.time,
  });

  String authorName;
  String authorUrl;
  String language;
  String profilePhotoUrl;
  int rating;
  String relativeTimeDescription;
  String text;
  int time;

  factory Review.fromJson(Map<String, dynamic> json) => Review(
    authorName: json["author_name"] == null ? null : json["author_name"],
    authorUrl: json["author_url"] == null ? null : json["author_url"],
    language: json["language"] == null ? null : json["language"],
    profilePhotoUrl: json["profile_photo_url"] == null ? null : json["profile_photo_url"],
    rating: json["rating"] == null ? null : json["rating"],
    relativeTimeDescription: json["relative_time_description"] == null ? null : json["relative_time_description"],
    text: json["text"] == null ? null : json["text"],
    time: json["time"] == null ? null : json["time"],
  );

  Map<String, dynamic> toJson() => {
    "author_name": authorName == null ? null : authorName,
    "author_url": authorUrl == null ? null : authorUrl,
    "language": language == null ? null : language,
    "profile_photo_url": profilePhotoUrl == null ? null : profilePhotoUrl,
    "rating": rating == null ? null : rating,
    "relative_time_description": relativeTimeDescription == null ? null : relativeTimeDescription,
    "text": text == null ? null : text,
    "time": time == null ? null : time,
  };
}
