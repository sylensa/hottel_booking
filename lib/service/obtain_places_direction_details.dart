// To parse this JSON data, do
//
//     final obtainPlacesDirectionDetails = obtainPlacesDirectionDetailsFromJson(jsonString);

import 'dart:convert';

ObtainPlacesDirectionDetails obtainPlacesDirectionDetailsFromJson(String str) => ObtainPlacesDirectionDetails.fromJson(json.decode(str));

String obtainPlacesDirectionDetailsToJson(ObtainPlacesDirectionDetails data) => json.encode(data.toJson());

class ObtainPlacesDirectionDetails {
  ObtainPlacesDirectionDetails({
    this.geocodedWaypoints,
    this.routes,
    this.status,
  });

  List<GeocodedWaypoint> geocodedWaypoints;
  List<Routes> routes;
  String status;

  factory ObtainPlacesDirectionDetails.fromJson(Map<String, dynamic> json) => ObtainPlacesDirectionDetails(
    geocodedWaypoints: json["geocoded_waypoints"] == null ? null : List<GeocodedWaypoint>.from(json["geocoded_waypoints"].map((x) => GeocodedWaypoint.fromJson(x))),
    routes: json["routes"] == null ? null : List<Routes>.from(json["routes"].map((x) => Routes.fromJson(x))),
    status: json["status"] == null ? null : json["status"],
  );

  Map<String, dynamic> toJson() => {
    "geocoded_waypoints": geocodedWaypoints == null ? null : List<dynamic>.from(geocodedWaypoints.map((x) => x.toJson())),
    "routes": routes == null ? null : List<dynamic>.from(routes.map((x) => x.toJson())),
    "status": status == null ? null : status,
  };
}

class GeocodedWaypoint {
  GeocodedWaypoint({
    this.geocoderStatus,
    this.placeId,
    this.types,
  });

  String geocoderStatus;
  String placeId;
  List<String> types;

  factory GeocodedWaypoint.fromJson(Map<String, dynamic> json) => GeocodedWaypoint(
    geocoderStatus: json["geocoder_status"] == null ? null : json["geocoder_status"],
    placeId: json["place_id"] == null ? null : json["place_id"],
    types: json["types"] == null ? null : List<String>.from(json["types"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "geocoder_status": geocoderStatus == null ? null : geocoderStatus,
    "place_id": placeId == null ? null : placeId,
    "types": types == null ? null : List<dynamic>.from(types.map((x) => x)),
  };
}

class Routes {
  Routes({
    this.bounds,
    this.copyrights,
    this.legs,
    this.overviewPolyline,
    this.summary,
    this.warnings,
    this.waypointOrder,
  });

  Bounds bounds;
  String copyrights;
  List<Leg> legs;
  Polylines overviewPolyline;
  String summary;
  List<dynamic> warnings;
  List<dynamic> waypointOrder;

  factory Routes.fromJson(Map<String, dynamic> json) => Routes(
    bounds: json["bounds"] == null ? null : Bounds.fromJson(json["bounds"]),
    copyrights: json["copyrights"] == null ? null : json["copyrights"],
    legs: json["legs"] == null ? null : List<Leg>.from(json["legs"].map((x) => Leg.fromJson(x))),
    overviewPolyline: json["overview_polyline"] == null ? null : Polylines.fromJson(json["overview_polyline"]),
    summary: json["summary"] == null ? null : json["summary"],
    warnings: json["warnings"] == null ? null : List<dynamic>.from(json["warnings"].map((x) => x)),
    waypointOrder: json["waypoint_order"] == null ? null : List<dynamic>.from(json["waypoint_order"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "bounds": bounds == null ? null : bounds.toJson(),
    "copyrights": copyrights == null ? null : copyrights,
    "legs": legs == null ? null : List<dynamic>.from(legs.map((x) => x.toJson())),
    "overview_polyline": overviewPolyline == null ? null : overviewPolyline.toJson(),
    "summary": summary == null ? null : summary,
    "warnings": warnings == null ? null : List<dynamic>.from(warnings.map((x) => x)),
    "waypoint_order": waypointOrder == null ? null : List<dynamic>.from(waypointOrder.map((x) => x)),
  };
}

class Bounds {
  Bounds({
    this.northeast,
    this.southwest,
  });

  Northeast northeast;
  Northeast southwest;

  factory Bounds.fromJson(Map<String, dynamic> json) => Bounds(
    northeast: json["northeast"] == null ? null : Northeast.fromJson(json["northeast"]),
    southwest: json["southwest"] == null ? null : Northeast.fromJson(json["southwest"]),
  );

  Map<String, dynamic> toJson() => {
    "northeast": northeast == null ? null : northeast.toJson(),
    "southwest": southwest == null ? null : southwest.toJson(),
  };
}

class Northeast {
  Northeast({
    this.lat,
    this.lng,
  });

  double lat;
  double lng;

  factory Northeast.fromJson(Map<String, dynamic> json) => Northeast(
    lat: json["lat"] == null ? null : json["lat"].toDouble(),
    lng: json["lng"] == null ? null : json["lng"].toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "lat": lat == null ? null : lat,
    "lng": lng == null ? null : lng,
  };
}

class Leg {
  Leg({
    this.distance,
    this.duration,
    this.endAddress,
    this.endLocation,
    this.startAddress,
    this.startLocation,
    this.steps,
    this.trafficSpeedEntry,
    this.viaWaypoint,
  });

  Distance distance;
  Distance duration;
  String endAddress;
  Northeast endLocation;
  String startAddress;
  Northeast startLocation;
  List<Step> steps;
  List<dynamic> trafficSpeedEntry;
  List<dynamic> viaWaypoint;

  factory Leg.fromJson(Map<String, dynamic> json) => Leg(
    distance: json["distance"] == null ? null : Distance.fromJson(json["distance"]),
    duration: json["duration"] == null ? null : Distance.fromJson(json["duration"]),
    endAddress: json["end_address"] == null ? null : json["end_address"],
    endLocation: json["end_location"] == null ? null : Northeast.fromJson(json["end_location"]),
    startAddress: json["start_address"] == null ? null : json["start_address"],
    startLocation: json["start_location"] == null ? null : Northeast.fromJson(json["start_location"]),
    steps: json["steps"] == null ? null : List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
    trafficSpeedEntry: json["traffic_speed_entry"] == null ? null : List<dynamic>.from(json["traffic_speed_entry"].map((x) => x)),
    viaWaypoint: json["via_waypoint"] == null ? null : List<dynamic>.from(json["via_waypoint"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "distance": distance == null ? null : distance.toJson(),
    "duration": duration == null ? null : duration.toJson(),
    "end_address": endAddress == null ? null : endAddress,
    "end_location": endLocation == null ? null : endLocation.toJson(),
    "start_address": startAddress == null ? null : startAddress,
    "start_location": startLocation == null ? null : startLocation.toJson(),
    "steps": steps == null ? null : List<dynamic>.from(steps.map((x) => x.toJson())),
    "traffic_speed_entry": trafficSpeedEntry == null ? null : List<dynamic>.from(trafficSpeedEntry.map((x) => x)),
    "via_waypoint": viaWaypoint == null ? null : List<dynamic>.from(viaWaypoint.map((x) => x)),
  };
}

class Distance {
  Distance({
    this.text,
    this.value,
  });

  String text;
  int value;

  factory Distance.fromJson(Map<String, dynamic> json) => Distance(
    text: json["text"] == null ? null : json["text"],
    value: json["value"] == null ? null : json["value"],
  );

  Map<String, dynamic> toJson() => {
    "text": text == null ? null : text,
    "value": value == null ? null : value,
  };
}

class Step {
  Step({
    this.distance,
    this.duration,
    this.endLocation,
    this.htmlInstructions,
    this.polyline,
    this.startLocation,
    this.travelMode,
    this.maneuver,
  });

  Distance distance;
  Distance duration;
  Northeast endLocation;
  String htmlInstructions;
  Polylines polyline;
  Northeast startLocation;
  TravelMode travelMode;
  String maneuver;

  factory Step.fromJson(Map<String, dynamic> json) => Step(
    distance: json["distance"] == null ? null : Distance.fromJson(json["distance"]),
    duration: json["duration"] == null ? null : Distance.fromJson(json["duration"]),
    endLocation: json["end_location"] == null ? null : Northeast.fromJson(json["end_location"]),
    htmlInstructions: json["html_instructions"] == null ? null : json["html_instructions"],
    polyline: json["polyline"] == null ? null : Polylines.fromJson(json["polyline"]),
    startLocation: json["start_location"] == null ? null : Northeast.fromJson(json["start_location"]),
    travelMode: json["travel_mode"] == null ? null : travelModeValues.map[json["travel_mode"]],
    maneuver: json["maneuver"] == null ? null : json["maneuver"],
  );

  Map<String, dynamic> toJson() => {
    "distance": distance == null ? null : distance.toJson(),
    "duration": duration == null ? null : duration.toJson(),
    "end_location": endLocation == null ? null : endLocation.toJson(),
    "html_instructions": htmlInstructions == null ? null : htmlInstructions,
    "polyline": polyline == null ? null : polyline.toJson(),
    "start_location": startLocation == null ? null : startLocation.toJson(),
    "travel_mode": travelMode == null ? null : travelModeValues.reverse[travelMode],
    "maneuver": maneuver == null ? null : maneuver,
  };
}

class Polylines {
  Polylines({
    this.points,
  });

  String points;

  factory Polylines.fromJson(Map<String, dynamic> json) => Polylines(
    points: json["points"] == null ? null : json["points"],
  );

  Map<String, dynamic> toJson() => {
    "points": points == null ? null : points,
  };
}

enum TravelMode { DRIVING }

final travelModeValues = EnumValues({
  "DRIVING": TravelMode.DRIVING
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
