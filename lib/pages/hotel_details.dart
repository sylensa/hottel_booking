import 'package:flutter/material.dart';
import 'package:hottel_booking/helper/helper.dart';

class HotelDetails extends StatefulWidget {
  @override
  _HotelDetailsState createState() => _HotelDetailsState();
}

class _HotelDetailsState extends State<HotelDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          appText(
                            "Profile Name",
                            z: 16,
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          appText("Visit Profile")
                        ],
                      )
                    ],
                  ),
                ),
              ),

              // Drawer Body Controllers
              GestureDetector(
                onTap: () {
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
                onTap: () {
                  // navigateTo(context, Carts());
                },
                child: ListTile(
                  leading: Icon(Icons.request_page),
                  title: appText("My Request", z: 15),
                ),
              ),
              GestureDetector(
                onTap: () {
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                child: Image.asset(
                  "images/crismon2.jpg",
                  fit: BoxFit.fitWidth,
                ),
              ),
              Positioned(
                  top: 30,
                  left: 0,
                  child: Container(
                    padding: appPadding(10),
                    width: appWidth(context),
                    child: Row(
                      children: [
                        IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            }),
                        Expanded(
                          child: Container(),
                        ),
                        IconButton(
                            icon: Icon(
                              Icons.favorite_border,
                              color: Colors.white,
                              size: 30,
                            ),
                            onPressed: () {}),
                      ],
                    ),
                  )),
              Positioned(
                top: 100,
                child: Container(
                  padding: appPadding(20),
                  width: appWidth(context),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              child: Row(
                                children: [
                                  Container(
                                    child: Icon(
                                      Icons.location_on,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Container(
                                    child: appText2("Accra, Ghana",
                                        z: 12,
                                        family: "Brand Regular",
                                        col: Colors.white),
                                  )
                                ],
                              ),
                            ),
                            Container(
                              child: appText2("Crismon Hotel",
                                  z: 20,
                                  family: "Brand Bold",
                                  col: Colors.white),
                            )
                          ],
                        ),
                      ),
                      Expanded(child: Container()),
                      Container(
                        child: RaisedButton(
                          onPressed: () {},
                          color: Colors.white,
                          child: Row(
                            children: [
                              Icon(
                                Icons.info,
                                color: Colors.green,
                              ),
                              appText2("781 ", family: "Brand Bold"),
                              appText2("visited"),
                            ],
                          ),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(10, appHeight(context) * 0.30, 10, 10),
                height: 250,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  child: appText2("Location",
                                      col: Colors.black, family: "Brand Bold"),
                                ),
                                Container(
                                  child: appText2("Spintex Road, Coca cola",
                                      col: Colors.grey,
                                      family: "Brand Regular"),
                                ),
                                Container(
                                  child: appText2("Accra,Ghana",
                                      col: Colors.grey,
                                      family: "Brand Regular"),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Image.asset(
                              "images/user-profile-avatar.png",
                              width: 70,
                              height: 70,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          appText2("Facilities",
                              col: Colors.black, family: "Brand Bold"),
                          appText2("(15)",
                              col: Colors.black, family: "Brand Regular"),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: 50,
                            child: RaisedButton(
                              color: Colors.lightBlueAccent[100],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              onPressed: () {},
                              child: Icon(
                                Icons.wifi,
                                color: Colors.lightBlueAccent[400],
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            child: RaisedButton(
                              color: Colors.lightBlueAccent[100],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              onPressed: () {},
                              child: Icon(
                                Icons.wifi,
                                color: Colors.lightBlueAccent[400],
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            child: RaisedButton(
                              color: Colors.lightBlueAccent[100],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              onPressed: () {},
                              child: Icon(
                                Icons.wifi,
                                color: Colors.lightBlueAccent[400],
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            child: RaisedButton(
                              color: Colors.lightBlueAccent[100],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              onPressed: () {},
                              child: Icon(
                                Icons.wifi,
                                color: Colors.lightBlueAccent[400],
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            child: RaisedButton(
                              color: Colors.lightBlueAccent[100],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              onPressed: () {},
                              child: Icon(
                                Icons.wifi,
                                color: Colors.lightBlueAccent[400],
                              ),
                            ),
                          ),
                          Container(
                            width: 50,
                            child: RaisedButton(
                              color: appColors(2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              onPressed: () {},
                              child: appText2("+9",
                                  family: "Brand Bold", col: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      child: appText2("Overview",
                          col: Colors.black, family: "Brand Bold"),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
                      padding: appPadding(10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  child: appText2("4.8",
                                      col: Colors.black, family: "Brand Bold"),
                                ),
                                Container(
                                  child: Icon(
                                    Icons.star,
                                    color: Colors.yellow,
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  child: appText2("16",
                                      col: Colors.black, family: "Brand Bold"),
                                ),
                                Container(
                                  child: appText2("Review",
                                      col: Colors.green, family: "Brand Bold"),
                                )
                              ],
                            ),
                          ),
                          Container(
                            child: Row(
                              children: [
                                Container(
                                  child: appText2("12",
                                      col: Colors.black, family: "Brand Bold"),
                                ),
                                Container(
                                  child: Icon(
                                    Icons.favorite,
                                    color: Colors.red,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border:
                              Border.all(color: Colors.grey[200], width: 1)),
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
              )
            ],
          ),
          Container(
              margin: leftMargin(20),
              child: Container(
                child:   appText2("Select Room",z: 18,family: "Brand Bold"),
              )
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    child: Column(
                      children: [
                        Container(
                          child: Row(
                            children: [
                              SizedBox(width: 20,),
                              Container(
                                  width: 100,
                                  height: 100,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.0),
                                    child: Image.asset("images/crismon2.jpg",height: 100,width: 100,fit: BoxFit.fill,),
                                  )
                              ),
                              SizedBox(width: 5,),
                              Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: appWidth(context) * 0.58,
                                      child: Row(
                                        children: [
                                          Container(
                                            child: appText2("Rose Room",
                                                family: "Brand Bold"),
                                          ),
                                          Expanded(child: Container()),
                                          Container(
                                            child: Row(
                                              children: [
                                                Container(
                                                  child: appText2("\$45", z: 16, family: "Brand Bold"),
                                                ),
                                                Container(
                                                  child: appText2("/Night",
                                                      family: "Brand Regular", col: Colors.grey),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      child: appText2("2nd Floor",
                                          family: "Brand Regular",
                                          col: Colors.grey),
                                    ),
                                    Container(
                                      child: Row(
                                        children: [
                                          Container(
                                            width: 100,
                                            child: RaisedButton(
                                              onPressed: () {},
                                              color: Colors.green[200],
                                              child: appText2("2 Bedroom",
                                                  col: Colors.green,z: 12),
                                            ),
                                          ),
                                          SizedBox(width: 5,),
                                          Container(
                                            width: 108,
                                            child: RaisedButton(
                                              onPressed: () {},
                                              color: Colors.orange[200],
                                              child: appText2("Parking Area",
                                                  col: Colors.orange,z: 12),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10,),
                        Divider(color: Colors.grey[200],thickness: 1,height: 1,),
                        SizedBox(height: 10,),
                      ],
                    ),
                  );
                }),
          )
        ],
      ),
    );
  }
}
