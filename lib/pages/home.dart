import 'package:carousel_pro/carousel_pro.dart';
import 'package:flutter/material.dart';
import 'package:hottel_booking/helper/helper.dart';
import 'package:hottel_booking/pages/hotel_details.dart';
import 'package:hottel_booking/pages/tracking.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List  imgList = [
    AssetImage('images/crismon1.jpg'),
    AssetImage('images/crismon2.jpg'),
    AssetImage('images/crismon3.jpg'),
    AssetImage('images/crismon4.jpg'),
    AssetImage('images/crismon5.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appColors(2),
        title: appText2("Home",col: Colors.white,family: "Brand Bold",z: 18),
        centerTitle: true,
        actions: [
          Container(
            margin: appMargin(10),
              child: Icon(
                Icons.person_pin,
                color: Colors.white,
              )
          ),
        ],
      ),

      drawer: Container(
        color: Colors.white,
        width: 255,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                height: 165,
                child: DrawerHeader(
                  decoration: BoxDecoration(
                    color: appColors(2),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        "images/user_icon.png",
                        height: 65,
                        width: 65,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          appText("Profile Name", z: 16,),
                          SizedBox(height: 6,),
                          appText("Visit Profile")
                        ],
                      )
                    ],
                  ),
                ),
              ),

              // Drawer Body Controllers
              GestureDetector(
                onTap:(){
                  // navigateTo(context, History());
                },
                child: ListTile(
                  leading: Icon(Icons.history),
                  title: appText("History", z: 15),
                ),
              ),
              ListTile(
                leading: Icon(Icons.person),
                title: appText("Visit Profile", z: 15),
              ),
              GestureDetector(
                onTap: (){
                  // navigateTo(context, Carts());
                },
                child: ListTile(
                  leading: Icon(Icons.request_page),
                  title: appText("My Request", z: 15),
                ),
              ),
              GestureDetector(
                onTap: (){
                  // navigateTo(context, ServiceType());
                },
                child: ListTile(
                  leading: Icon(Icons.design_services),
                  title: appText("Service", z: 15),
                ),
              ),
              ListTile(
                leading: Icon(Icons.info),
                title: appText("About", z: 15),
              ),
              ListTile(
                leading: Icon(Icons.settings),
                title: appText("Settings", z: 15),
              ),

              ListTile(
                leading: Icon(Icons.support),
                title: appText("Support", z: 15),
              ),
              ListTile(
                leading: Icon(Icons.logout),
                title: appText("Logout", z: 15),
              ),
            ],
          ),
        ),
      ),

      body: Container(
        padding: appPadding(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: appText2(" Welcome to Crismon Hotel",family: "Brand Bold",z: 20),
            ),
            SizedBox(height: 10,),
            Container(
              child: Row(
                children: [
                  Container(
                    child: Icon(Icons.star,color: Colors.yellow,),
                  ),
                  Container(
                    child: Icon(Icons.star,color: Colors.yellow,),
                  ),
                  Container(
                    child: Icon(Icons.star,color: Colors.yellow,),
                  ),
                  Container(
                    child: Icon(Icons.star,color: Colors.yellow,),
                  ),
                  Container(
                    child: Icon(Icons.star,color: Colors.yellow,),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Container(
              child: Row(
                children: [
                  Container(
                    width: appWidth(context) * 0.67,
                    child: appText2("Tema, Accra Ghana - ",family: "Brand-Regular",col: Colors.grey,maxLines: 2),
                  ),
                  GestureDetector(
                    onTap: (){
                      navigateTo(context, TrackingMap());
                    },
                    child: Container(
                      child: appText2("Show on Map",family: "Brand Bold",col: appColors(2)),
                    ),
                  ),
                ],
              )
            ),
            SizedBox(height: 10,),
            Container(
              child: Row(
                children: [
                  Container(
                    padding: appPadding(5),
                    child: appText2("6.5",col: Colors.white,family: "Brand Bold"),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: appColors(2)
                    ),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    child: appText2("Pleasant",family: "Brand Bold",col: appColors(2)),
                  ),
                  SizedBox(width: 10,),
                  Container(
                    child: appText2("5 reviews",family: "Brand-Regular",col: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10,),
            Center(
              child: SizedBox(
                height: 250.0,
                width: 400.0,
                child: Carousel(
                  boxFit: BoxFit.fitWidth,
                  autoplay: true,
                  animationCurve: Curves.fastOutSlowIn,
                  animationDuration: Duration(milliseconds: 1000),
                  dotSize: 6.0,
                  dotIncreasedColor: Color(0xFFA9A9A9),
                  dotBgColor: Colors.transparent,
                  dotColor: Colors.grey[400],
                  dotPosition: DotPosition.bottomCenter,
                  dotVerticalPadding: 10.0,
                  showIndicator: true,
                  indicatorBgPadding: 7.0,
                  images: imgList,
                ),
              ),
            ),
            Container(
              width: appWidth(context),
              child: RaisedButton(
                onPressed: (){
                  navigateTo(context, HotelDetails());
                },
                child: Container(
                  padding: appPadding(15),
                  child: appText2("Reserved for tonight",z: 16,col: Colors.white),
                ),
                color: appColors(2),
              ),
            )
          ],
        ),
      ),
    );
  }
}
