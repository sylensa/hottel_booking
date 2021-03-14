import 'dart:async';
import 'dart:typed_data';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:hottel_booking/AllWidget/progress_dialog.dart';
import 'package:hottel_booking/helper/helper.dart';
import 'package:hottel_booking/model/direction_details.dart';
import 'package:hottel_booking/pages/request_hotel.dart';
import 'package:hottel_booking/service/obtain_places_direction_details.dart';


class TrackingMap extends StatefulWidget {
  @override
  _TrackingMapState createState() => _TrackingMapState();
}

class _TrackingMapState extends State<TrackingMap> with TickerProviderStateMixin {
  Completer<GoogleMapController> _controllerGoogleMap = Completer();

  GoogleMapController newGoogleMapController;
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  double bottomPaddingofMap = 0;
  LatLng _center;
  Position currentPosition;
  List<LatLng> pLineCoordinates = [];
  Set<Polyline> polylineSet = {};
  Set<Marker> markerSet = {};
  Set<Circle> circleSet = {};
  double rideDetailsContainerHeight = 50;
  double searchContainerHeight = 300;
  bool drawerOpen = true;
  double requestRideContainerHeight = 300;
  DatabaseReference rideRequestRef;
  LatLng initialPosition;
  LatLng finalPosition;
  LatLng riderPosition;
  String pickUpLocationAddress = "" ;
  List<Marker> markers = [];
  String _mapStyle;
  List<ObtainPlacesDirectionDetails> resroute = [];
  DirectionDetails tripDirectionDetails;
  DirectionDetails directionDetails = DirectionDetails();


  Future<Uint8List>getMarker() async{
    ByteData byteData = await DefaultAssetBundle.of(context).load("images/motor-bike-maker.png");
    return byteData.buffer.asUint8List();

  }
  getUserLocation() async {
    currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    currentPosition = await geoController.getInitialLocation();
    initialPosition = LatLng(currentPosition.latitude, currentPosition.longitude);
    _center =  LatLng(currentPosition.latitude, currentPosition.longitude);
    setState(() {

    });
    finalPosition =  LatLng(5.5746889,-0.3228181);
    showDialog(
        context: context,
        builder: (BuildContext context) => ProgressDialog(
          message: "please wait..",
        ));
    resroute = await placesServices.obtainPlaceDirectionsDetails(initialPosition, finalPosition);
    if (resroute == null) {
      print("resroute is empty $resroute");
    } else {
      directionDetails.encodedPoints = resroute[0].routes[0].overviewPolyline.points;

      directionDetails.distanceText = resroute[0].routes[0].legs[0].distance.text;
      directionDetails.distanceValue = resroute[0].routes[0].legs[0].distance.value;

      directionDetails.durationText = resroute[0].routes[0].legs[0].duration.text;
      directionDetails.durationValue = resroute[0].routes[0].legs[0].duration.value;

      setState(() {
        tripDirectionDetails = directionDetails;
      });
    }

    Navigator.pop(context);

    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> decodedPolyLinePointResult = polylinePoints.decodePolyline(directionDetails.encodedPoints);

    pLineCoordinates.clear();
    if (decodedPolyLinePointResult.isNotEmpty) {
      decodedPolyLinePointResult.forEach((PointLatLng pointLatLng) {
        pLineCoordinates.add(LatLng(pointLatLng.latitude, pointLatLng.longitude));
      });
    }
    polylineSet.clear();
    setState(() {
      Polyline polyline = Polyline(
          color: Color(0xFFFCD733),
          polylineId: PolylineId("PolylineID"),
          jointType: JointType.round,
          points: pLineCoordinates,
          width: 5,
          startCap: Cap.roundCap,
          endCap: Cap.roundCap,
          geodesic: true);

      polylineSet.add(polyline);
    });

    LatLngBounds latLngBounds;
    if (initialPosition.latitude > finalPosition.longitude && initialPosition.longitude > finalPosition.longitude) {
      latLngBounds = LatLngBounds(southwest: finalPosition, northeast: initialPosition);
    } else if (initialPosition.longitude > finalPosition.latitude) {
      latLngBounds = LatLngBounds(southwest: LatLng(initialPosition.latitude, finalPosition.longitude), northeast: LatLng(finalPosition.latitude, initialPosition.longitude));
    } else if (initialPosition.latitude > finalPosition.latitude) {
      latLngBounds = LatLngBounds(southwest: LatLng(finalPosition.latitude, initialPosition.longitude), northeast: LatLng(initialPosition.latitude, finalPosition.longitude));
    } else {
      latLngBounds = LatLngBounds(southwest: initialPosition, northeast: finalPosition);
    }
    Marker pickUpLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueYellow),
        infoWindow: InfoWindow(
          title:
          "my Location",
          snippet: "my Location",
        ),
        position: initialPosition,
        markerId: MarkerId("pickUpId"));

    Marker dropOffLocMarker = Marker(
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
        infoWindow: InfoWindow(
          title: "Crismon Hotel",
          snippet: "Crismon Hotel",
        ),
        position: finalPosition,
        markerId: MarkerId("dropOffId"));

    setState(() {
      markerSet.add(pickUpLocMarker);
      markerSet.add(dropOffLocMarker);
    });

    Circle pickUpLocCircle = Circle(
      fillColor: Color(0xFFFCD733),
      center: initialPosition,
      radius: 36,
      strokeColor: Colors.black,
      strokeWidth: 8,
      circleId: CircleId("pickUpId"),
    );

    Circle dropOffLocCircle = Circle(
      fillColor: Color(0xFFFCD733),
      center: finalPosition,
      radius: 36,
      strokeColor: Colors.deepPurple,
      strokeWidth: 8,
      circleId: CircleId("dropOffId"),
    );

    setState(() {
      circleSet.add(pickUpLocCircle);
      circleSet.add(dropOffLocCircle);
    });


  }

  void locationPosition() async {
    currentPosition = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    LatLng latlng = LatLng(currentPosition.latitude, currentPosition.longitude);
    CameraPosition cameraPosition = CameraPosition(target: latlng, zoom: 14);
    newGoogleMapController.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
  }



  @override
  void initState() {
    getUserLocation();
    // TODO: implement initState
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: appColors(2),
        title: appText("Crismon Hotel Location",col: Colors.white,z: 20,family: "Brand Bold"),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          _center != null ?
          GoogleMap(
            padding: EdgeInsets.only(bottom: bottomPaddingofMap),
            mapType: MapType.normal,
            polylines: polylineSet,
            markers: markerSet,
            circles: circleSet,
            myLocationButtonEnabled: true,
            initialCameraPosition: CameraPosition(target: _center, zoom: 20),
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              // newGoogleMapController.setMapStyle(_mapStyle);

              setState(() {
                bottomPaddingofMap = 300;
              });
              locationPosition();
            },
            myLocationEnabled: true,
            zoomGesturesEnabled: true,
            zoomControlsEnabled: true,
          )
              : Positioned(
            top: 60,
            left: 0,
            right: 0,
            child: Center(
              child: ProgressDialog(
                message: "Loading Map, please wait..",
              ),
            ),
          ),

          // request
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: AnimatedSize(
              vsync: this,
              curve: Curves.bounceIn,
              duration: new Duration(microseconds: 160),
              child: Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(16),
                    topRight: Radius.circular(16),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black,
                      blurRadius: 16,
                      spreadRadius: 0.5,
                      offset: Offset(0.7, 0.7),
                    )
                  ],

                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 17),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        width: appWidth(context),
                        child: RaisedButton(
                          onPressed: () {
                            print("button clicked");
                            navigateTo(context, RequestHotel());
                          },
                          color: appColors(2),
                          child: Padding(
                            padding: EdgeInsets.all(17),
                            child:  appText("Reserve a Room",
                                z: 20,
                                w: FontWeight.bold,
                                col: Colors.white
                            ),
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),


        ],
      ),
    );
  }
}
