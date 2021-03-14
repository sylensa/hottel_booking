import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hottel_booking/helper/helper.dart';
import 'package:hottel_booking/model/direction_details.dart';
import 'package:hottel_booking/service/get_nearby_places_services.dart';
import 'package:hottel_booking/service/get_places_details_services.dart';
import 'package:hottel_booking/service/get_predictions_services.dart';
import 'package:hottel_booking/service/obtain_places_direction_details.dart';
import 'package:http/http.dart';


class GooglePlacesController{
  final key = "AIzaSyAF98xSnTXRPZBrrQwEonH2uCz_usc7_pY";
  Future<Position> getLocation() async{
    return await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
  }

  Future<List<Result>> getPlaces(double lat, double lon) async {
    result.clear();
    try{
      Response response = await get("https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lon&key=$key");
      print("http res ${"https://maps.googleapis.com/maps/api/geocode/json?latlng=$lat,$lon&key=$key"}");
      Map _places = jsonDecode(response.body);
      print("_places $_places");
      if(_places['status'].toString().toUpperCase() == "OK"){
        for (var i = 0; i < _places['results'].length; i++) {
          Result g = Result.fromJson(_places['results'][i]);
          result.add(g);
        }
        print("name: ${result[0].formattedAddress}");
        return result;
      }else{
        print(_places['status']);
      }

    } catch(e){
      print("error message $e");
    }

  }

  Future<List<Prediction>> findPlaces(String placeName) async {
    prediction.clear();
    try{
      Response response = await get("https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${Uri.encodeComponent(placeName)}&key=$key&sessiontoken=1234567890&components=country:gh");
      print("http res ${"https://maps.googleapis.com/maps/api/place/autocomplete/json?input=${Uri.encodeComponent(placeName)}&key=$key&sessiontoken=1234567890&components=country:gh"}");
      Map _places = jsonDecode(response.body);
      print("_places $_places");
      if(_places['status'].toString().toUpperCase() == "OK"){
        for (var i = 0; i < _places['predictions'].length; i++) {
          Prediction g = Prediction.fromJson(_places['predictions'][i]);
          prediction.add(g);
        }
        print("name: ${prediction[0].placeId}");
        return prediction;
      }else{
        print(_places['status']);
      }

    } catch(e){
      print("error message $e");
    }

  }

  Future<List<GetPlacesDetails>> findDropOffPlacesDetails(String placeid) async {
    DropOfresultDetails.clear();
    try{
      Response response = await get("https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeid&key=$key");
      print("http res ${"https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeid&key=$key"}");
      Map _places = jsonDecode(response.body);
      print("_places $_places");
      if(_places['status'].toString().toUpperCase() == "OK"){
        print("Status ok");
        print(_places['result']);
        GetPlacesDetails g = GetPlacesDetails.fromJson(_places);
        DropOfresultDetails.add(g);
        if(DropOfresultDetails.isNotEmpty){
          print("not empty resultDetails ${DropOfresultDetails[0].result.geometry.location.lat}");
          return DropOfresultDetails;
        }else{
          print(" empty resultDetails");
        }

      }else{
        print(_places['status']);
      }

    } catch(e){
      print("error message $e");
    }

  }

  Future<List<GetPlacesDetails>> findPickUpPlacesDetails(String placeid) async {
    PickUpresultDetails.clear();
    try{
      Response response = await get("https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeid&key=$key");
      print("http res ${"https://maps.googleapis.com/maps/api/place/details/json?place_id=$placeid&key=$key"}");
      Map _places = jsonDecode(response.body);
      print("_places $_places");
      if(_places['status'].toString().toUpperCase() == "OK"){
        print("Status ok");
        print(_places['result']);
        GetPlacesDetails g = GetPlacesDetails.fromJson(_places);
        PickUpresultDetails.add(g);
        if(PickUpresultDetails.isNotEmpty){
          print("not empty resultDetails ${PickUpresultDetails[0].result.geometry.location.lat}");
          return PickUpresultDetails;
        }else{
          print(" empty resultDetails");
        }

      }else{
        print(_places['status']);
      }

    } catch(e){
      print("error message $e");
    }

  }

  Future<List<ObtainPlacesDirectionDetails>> obtainPlaceDirectionsDetails(LatLng initialPosition, LatLng finalPosition) async {
    route.clear();
    try{
      Response response = await get("https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$key");
      print("http res ${"https://maps.googleapis.com/maps/api/directions/json?origin=${initialPosition.latitude},${initialPosition.longitude}&destination=${finalPosition.latitude},${finalPosition.longitude}&key=$key"}");
      Map _places = jsonDecode(response.body);
      print("_places ${_places['geocoded_waypoints']}");
      if(_places['status'].toString().toUpperCase() == "OK"){
        print("_places ${_places['geocoded_waypoints']}");
        ObtainPlacesDirectionDetails g = ObtainPlacesDirectionDetails.fromJson(_places);
        route.add(g);

        return route;

      }else{
        print(_places['status']);
      }

    } catch(e){
      print("error message $e");
    }

  }

  Future<double> getDistance(double startLat, double startLon, double endLat, double endLon) async{
    return await Geolocator.distanceBetween(startLat, startLon, endLat, endLon);
  }

  calculateFares(DirectionDetails directionDetails){
    double timeTraveledFare = (directionDetails.durationValue / 60) * 0.20;
    double distanceTravelFare = (directionDetails.distanceValue / 1000) * 0.20;
    double totalFare = timeTraveledFare + distanceTravelFare;
    return totalFare.truncate();
  }



  List<Marker> getMarkers(List<Result> results,Uint8List imageData){
    var markers = List<Marker>();

    results.forEach((result) {
      Marker marker = Marker(
          markerId: MarkerId(result.formattedAddress),
          draggable: false,
          infoWindow: InfoWindow(title: result.formattedAddress, snippet: result.formattedAddress),
          position: LatLng(result.geometry.location.lat,result.geometry.location.lng),
          icon: BitmapDescriptor.fromBytes(imageData)
      );

      markers.add(marker);
    });

    return markers;
  }


}
