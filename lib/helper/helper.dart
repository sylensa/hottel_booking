import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hottel_booking/controller/geolocator_controller.dart';
import 'package:hottel_booking/controller/google_places_controller.dart';
import 'package:hottel_booking/service/get_nearby_places_services.dart';
import 'package:hottel_booking/service/get_places_details_services.dart';
import 'package:hottel_booking/service/get_predictions_services.dart';
import 'package:hottel_booking/service/obtain_places_direction_details.dart';
import 'package:http/http.dart';
import 'package:intl/intl.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recase/recase.dart';

const base = "";

String placeName = "";
String placeId = "";
double latitude;
double longitude;
int pickupLocationIndex = 0;
int dropoffLocationIndex = 0;
List wishListName = [];
List<ObtainPlacesDirectionDetails> route = [];
List mapAddresses = [];
List<Result> result = [];
List<GetPlacesDetails> DropOfresultDetails = [];
List<GetPlacesDetails> PickUpresultDetails = [];
List<Prediction> prediction = [];
List wishListId = [];
List wishListQuantity = [];
final geoController = GeolocatorController();
var placesServices = GooglePlacesController();

showDialogOk({String message,String msg = "You Already have an account",BuildContext context,Widget target,bool status}) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text(msg),
        content: new Text(message),
        actions: <Widget>[
          new FlatButton(
            child: new Text("Ok"),
            onPressed: () {
              if(status){
                Navigator.pop(context);
                navigateTo(context, target,replace: true);
              }else{
                Navigator.pop(context);
              }

            },
          ),
        ],
      );
    },
  );
}

showDialogYesNo(String message,BuildContext context,Widget target) {
  // flutter defined function
  showDialog(
    context: context,
    builder: (BuildContext context) {
      // return object of type Dialog
      return AlertDialog(
        title: new Text("Alert"),
        content: new Text(message),
        actions: <Widget>[
          // usually buttons at the bottom of the dialog
          new FlatButton(
            child: new Text("Try Again"),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          new FlatButton(
            child: new Text("Create Account"),
            onPressed: () {
              navigateTo(context, target);
            },
          ),
        ],
      );
    },
  );
}


goTo(BuildContext context, Widget target, {bool opaque = true}) {
  Navigator.of(context).push(PageRouteBuilder(
      opaque: opaque,
      pageBuilder: (BuildContext context, animation, secondaryAnimation) => target,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(opacity: animation, child: child);
      }));
}

Color appColors(index) {
  return [Color(0xFF8bff00), Color(0xFF9c9c9c), Colors.lightBlue[500]][index];
}

toast(String text, {bool long = false}) {
  Fluttertoast.showToast(
      msg: text,
      toastLength: long ? Toast.LENGTH_LONG : Toast.LENGTH_SHORT,
      backgroundColor: appDarkText,
      textColor: Colors.white
  );
}

bool appIsEmpty(value) {
  return value.toString() == '' || value == null || value == 'null';
}

bool appIsNotEmpty(value) {
  return value != '' && value != null;
}

var format = NumberFormat('###.0#', 'en_US');

appToDouble(value) {
  return double.parse(value);
}

appToInt(value) {
  if (appIsEmpty(value)) return 0;
  return int.parse(value);
}

Map<String, dynamic> stripNulls(dynamic v) {
  Map m = v.toMap();
  Map<String, dynamic> finalMap = v.toMap();
  for (var i in m.keys) {
    if (appIsEmpty(m[i])) {
      finalMap.remove(i);
    }
  }
  return finalMap;
}

getFileExtension(String files){
  File file = new File("$files");
  String fileEx = file.path.split(' ').last;
  if(fileEx == "jpg"){
    print("fileEx: $fileEx");
    return "1";
  }else if(fileEx == "mp4"){
    print("fileEx: $fileEx");
    return "2";
  }else{
    print("fileEx: $fileEx");
    return "0";
  }

}

getTime(String timestamp){
  String timesent = timestamp.split(' ').last;
  print("timesent: $timesent");
  return timesent;

}
getDate(String timestamp){
  String datesent = timestamp.split(' ').first;
  print("datesent: $datesent");
  return datesent;

}

getBanterChannel(String title){
  if(title.isEmpty){
    return "Banter";
  }else{
    return "Channel";
  }
}

displayImage(imagePath, {double radius = 30.0, double height,double width}) {
  return CachedNetworkImage(
      imageUrl: imagePath,
      height: height,
      width: width,
      placeholder: (context, url) {
        return radius > 0 ? CircleAvatar(
          backgroundColor: appLightGray,
          backgroundImage: AssetImage('images/truck.png'),
          radius: radius,
        ) :
        Image(
          image: AssetImage('images/truck.png'),
        );
      },
      imageBuilder: (context, image) {
        return radius > 0 ? CircleAvatar(
          backgroundColor: appLightGray,
          backgroundImage: image,
          radius: radius,
        ) :
        Image(
          image: image,
          fit: BoxFit.cover,
        );
      }
  );
}

navigateTo(BuildContext context, Widget target, {bool replace = false, PageTransitionType anim = PageTransitionType.fade, int millis = 300, bool opaque = false}) {
  if (!replace) {
    Navigator.of(context).push(PageRouteBuilder(
        opaque: opaque,
        pageBuilder: (BuildContext context, animation, secondaryAnimation) => target,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(opacity: animation, child: child);
        }));
  } else
    Navigator.pushReplacement(
        context,
        PageTransition(
            type: PageTransitionType.size,
            duration: Duration(milliseconds: 300),
            alignment: Alignment.bottomCenter,
            child: target
        )
    );
}

EdgeInsets noPadding() {
  return EdgeInsets.zero;
}

EdgeInsets appPadding(double size) {
  return EdgeInsets.all(size);
}

EdgeInsets topPadding(double size) {
  return EdgeInsets.only(top: size);
}

EdgeInsets bottomPadding(double size) {
  return EdgeInsets.only(bottom: size);
}
EdgeInsets leftPadding(double size) {
  return EdgeInsets.only(left: size);
}
EdgeInsets rightPadding(double size) {
  return EdgeInsets.only(right: size);
}
EdgeInsets horizontalPadding(double size) {
  return EdgeInsets.symmetric(horizontal: size);
}

EdgeInsets verticalPadding(double size) {
  return EdgeInsets.symmetric(vertical: size);
}

EdgeInsets noMargin() {
  return EdgeInsets.zero;
}

EdgeInsets appMargin(double size) {
  return EdgeInsets.all(size);
}

EdgeInsets topMargin(double size) {
  return EdgeInsets.only(top: size);
}

EdgeInsets bottomMargin(double size) {
  return EdgeInsets.only(bottom: size);
}
EdgeInsets leftMargin(double size) {
  return EdgeInsets.only(left: size);
}
EdgeInsets rightMargin(double size) {
  return EdgeInsets.only(right: size);
}
EdgeInsets horizontalMargin(double size) {
  return EdgeInsets.symmetric(horizontal: size);
}

EdgeInsets verticalMargin(double size) {
  return EdgeInsets.symmetric(vertical: size);
}

List<BoxShadow> appShadow(Color col, double offset, double blur, double spread) {
  return [
    BoxShadow(
        blurRadius: blur,
        color: col,
        offset: Offset(0, 2.0),
        spreadRadius: spread
    ),
  ];
}

List<BoxShadow> elevation(Color col, int elevation) {
  return [
    BoxShadow(color: col.withOpacity(0.6), offset: Offset(0.0, 4.0), blurRadius: 3.0 * elevation, spreadRadius: -1.0 * elevation),
    BoxShadow(color: col.withOpacity(0.44), offset: Offset(0.0, 1.0), blurRadius: 2.2 * elevation, spreadRadius: 1.5),
    BoxShadow(color: col.withOpacity(0.12), offset: Offset(0.0, 1.0), blurRadius: 4.6 * elevation, spreadRadius: 0.0),
  ];
}
Widget progress({double size = 30}) {
  return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(backgroundColor: appLightGray,
          valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF9c9c9c)))
  );
}

appText(String word, {double z = 14, FontWeight w = FontWeight.normal, Color col = appDarkText, TextAlign align = TextAlign.left, int maxLines = 5, int shadow = 0, String family = "Open Sans"}) {
  return Text(
    word,
    softWrap: true,
    maxLines: 1,
    overflow: TextOverflow.clip,
    textAlign: align,
    style: TextStyle(
      color: col,
      fontFamily: '$family',
      fontSize: z,
      fontWeight: w,
      shadows: shadow > 0 ? elevation(Colors.black38, shadow) : [],
    ),
  );
}
appText2(String word, {double z = 14, FontWeight w = FontWeight.normal, Color col = appDarkText, TextAlign align = TextAlign.left, int maxLines = 1000, int shadow = 0, String family = "Open Sans"}) {
  return Text(
    word,
    softWrap: true,
    maxLines: maxLines,
    overflow: TextOverflow.ellipsis,
    textAlign: align,
    style: TextStyle(
      color: col,
      fontFamily: '$family',
      fontSize: z,
      fontWeight: w,
      shadows: shadow > 0 ? elevation(Colors.black38, shadow) : [],
    ),
  );
}
TextStyle appStyle({double size = 15, Color col = appDarkText, FontWeight weight = FontWeight.w400}) {
  return TextStyle(fontFamily: 'Open Sans', fontWeight: weight, fontSize: size, color: col);
}

const appLightGray = Color(0xFFE7ECF2);
const appGray = Color(0xFFadb4b9);
const appDarkText = Color(0xFF2F2F2F);

InputDecoration textDecor({String hint, Icon icon, String prefix = '', String suffix = '', bool enabled = true, Color hintColor = Colors.grey, double hintSize = 16, bool showBorder = true, String label = '', double size = 40,double top = 12.0}) {
  return new InputDecoration(
    prefixIcon: icon,
    prefixText: prefix,
    suffixText: suffix,
    hintText: hint,
    hintStyle: appStyle(size: hintSize, col: hintColor),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: appDarkText.withOpacity(0.1), width: 1),
      borderRadius: BorderRadius.all(Radius.circular(size)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: appDarkText.withOpacity(0.1), width: 1),
      borderRadius:  BorderRadius.all(Radius.circular(size)),
    ),
    labelStyle: appStyle(size: hintSize, col: hintColor),
    labelText: label,
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.fromLTRB(20.0, top, 20.0, 12.0),
  );
}

InputDecoration textDecorNoFocus({String hint, Icon icon, String prefix = '', String suffix = '', bool enabled = true, Color hintColor = Colors.grey, double hintSize = 16, bool showBorder = true, String label = '', double size = 40,double top = 12.0}) {
  return new InputDecoration(
    focusColor: Colors.grey,
    prefixIcon: icon,
    prefixText: prefix,
    suffixText: suffix,
    hintText: hint,
    hintStyle: appStyle(size: hintSize, col: hintColor),
    labelStyle: appStyle(size: hintSize, col: hintColor),
    labelText: label,
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.fromLTRB(20.0, top, 20.0, 12.0),
  );
}

InputDecoration textDecors({String hint, Image icon, String prefix = '', String suffix = '', bool enabled = true, Color hintColor = Colors.grey, double hintSize = 16, bool showBorder = true, String label = ''}) {
  return new InputDecoration(
    prefixIcon: icon,
    prefixText: prefix,
    suffixText: suffix,
    hintText: hint,
    hintStyle: appStyle(size: hintSize, col: hintColor),
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: appDarkText.withOpacity(0.1), width: 1),
      borderRadius: BorderRadius.all(Radius.circular(40)),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: appDarkText.withOpacity(0.1), width: 1),
      borderRadius:  BorderRadius.all(Radius.circular(40)),
    ),
    labelStyle: appStyle(size: hintSize, col: hintColor),
    labelText: label,
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.fromLTRB(200.0, 12.0, 20.0, 12.0),
  );
}

InputDecoration textDecorNoBorder({String hint, String prefix = '', double hintSize = 16}) {
  return new InputDecoration(
    prefixText: prefix,
    labelText: hint,
    hintStyle: appStyle(size: hintSize),
    alignLabelWithHint: true,
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: appDarkText.withOpacity(0.4), width: 1),
      borderRadius: BorderRadius.circular(3),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: appColors(2), width: 1),
      borderRadius: BorderRadius.circular(3),
    ),
    focusColor: appColors(2),
    labelStyle: appStyle(size: hintSize),
  );
}

appWidth(con) {
  return MediaQuery.of(con).size.width;
}
appHeight(con) {
  return MediaQuery.of(con).size.height;
}

Future<bool> clearPrefs() async {
  var sp = await SharedPreferences.getInstance();
  sp.clear();
  return true;
}
Future<bool> setPref(key, value, {type = 'string'}) async {
  var sp = await SharedPreferences.getInstance();
  print("Setting $type pref $key to $value...");
  switch (type) {
    case 'string':
      sp.setString(key, value);
      break;
    case 'bool':
      sp.setBool(key, value);
      break;
    case 'int':
      sp.setInt(key, value);
      break;
    case 'list':
      List<String> ls = value;
      sp.setStringList(key, ls);
      break;
  }
  return true;
}
Future<dynamic> getPref(key, {type = 'string'}) async {
  var sp = await SharedPreferences.getInstance();
  switch (type) {
    case 'string':
      return sp.getString(key);
      break;
    case 'list':
      List<String> aList = [];
      List<String> data = sp.getStringList(key);
      if (data != null) {
        aList = data;
        return aList;
      } else {
        return aList;
      }
      break;
  }
}

Map replaceNulls(Map m) {
  for (var i in m.keys) {
    if (m[i] is String) {
      if (m[i] == null) {
        m[i] = '';
      }
    } else if (m[i] == Null) {
      m[i] = '';
    } else {
      m[i] = jsonEncode(m[i]);
    }
  }
  return m;
}

doPost(String urlAfterBase, Map body) async {
  print('Calling $base/$urlAfterBase...');
  var js = await post("", body: replaceNulls(body));
  print(js.body);
  var decoded = jsonDecode(js.body);
  return decoded;
}

doGet(String urlAfterBase) async {
  var js = await get('$base/$urlAfterBase');
  var decoded;
  try {
    decoded = jsonDecode(js.body);
  } catch(e) {
    print(e);
  }
  return decoded;
}

properCase(String txt) {
  return txt.titleCase;
}
capCase(String txt) {
  return txt.toUpperCase();
}
sentenceCase(String txt) {
  if (txt.isEmpty) return txt;
  return txt.sentenceCase;
}

extension StringExtension on String {
  static String displayTimeAgoFromTimestamp(String timestamp) {
    final year = int.parse(timestamp.substring(0, 4));
    final month = int.parse(timestamp.substring(5, 7));
    final day = int.parse(timestamp.substring(8, 10));
    final hour = int.parse(timestamp.substring(11, 13));
    final minute = int.parse(timestamp.substring(14, 16));

    final DateTime videoDate = DateTime(year, month, day, hour, minute);
    final int diffInHours = DateTime.now().difference(videoDate).inHours;

    String timeAgo = '';
    String timeUnit = '';
    int timeValue = 0;

    if (diffInHours < 1) {
      final diffInMinutes = DateTime.now().difference(videoDate).inMinutes;
      timeValue = diffInMinutes;
      timeUnit = 'minute';
    } else if (diffInHours < 24) {
      timeValue = diffInHours;
      timeUnit = 'hour';
    } else if (diffInHours >= 24 && diffInHours < 24 * 7) {
      timeValue = (diffInHours / 24).floor();
      timeUnit = 'day';
    } else if (diffInHours >= 24 * 7 && diffInHours < 24 * 30) {
      timeValue = (diffInHours / (24 * 7)).floor();
      timeUnit = 'week';
    } else if (diffInHours >= 24 * 30 && diffInHours < 24 * 12 * 30) {
      timeValue = (diffInHours / (24 * 30)).floor();
      timeUnit = 'month';
    } else {
      timeValue = (diffInHours / (24 * 365)).floor();
      timeUnit = 'year';
    }

    timeAgo = timeValue.toString() + ' ' + timeUnit;
    timeAgo += timeValue > 1 ? 's' : '';

    return timeAgo + ' ago';
  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  print('Yaaayyyyy');
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    print("data: $data");
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }

}

Future<void> _handleNotification (Map<dynamic, dynamic> message, bool dialog) async {
  var data = message['data'] ?? message;
  String expectedAttribute = data['expectedAttribute'];
  /// [...]
}