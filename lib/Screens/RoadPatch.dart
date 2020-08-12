import 'package:flutter/material.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pothole/main.dart';
import 'Console.dart';

class RoadPatch extends StatefulWidget {
  @override
  State <RoadPatch> createState() => MapSampleState();
}

class MapSampleState extends State<RoadPatch>{

  Completer<GoogleMapController> _controller = Completer();

  var curLoc;
  var time= new DateTime.now();
  final db=Firestore.instance;
  var urgValue;
  double _discreteValue = 1;
  var c=1;

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(0,0),

  );

  void setUrgent(var value)
  {
    urgValue=value;
  }

  void _showDialogOk() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Query Uploaded Successfully",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay'
            ),
          ),
          content: new Text("Thanks for Your Help"),

          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                  return new Console();
                }));
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> createData() async{

    DocumentReference ref = await db.collection('reports').add({'uid': '$uid','geo':'$curLoc',
      'time_s':'$time','urgency':'$urgValue','type':"Patch of Road",'status':"No"});
    print("${ref.documentID}");

    _showDialogOk();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Patch Of Road",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'SFUIDisplay',
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor: Color(0xffff2d55),


      ),
      body:
          Stack(
            children:<Widget>[
          Padding(
            padding: EdgeInsets.only(bottom: 200),
      child:Container(
       child:GoogleMap(
        mapType: MapType.normal,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
       ),
        decoration: BoxDecoration(
            border: Border.all(
              color: Color(0xffff2d55),
              width: 3,

            ),
            borderRadius: BorderRadius.horizontal(),

        ),

      )
          ),
      Padding(
        padding: EdgeInsets.only(bottom: 0,top: 685,left: 330),
      child: FloatingActionButton(
        onPressed: _goToTheLake,
        child: Icon(Icons.my_location),
        backgroundColor: Color(0xffff2d55),
      ),
      ),

      Padding(
        padding: EdgeInsets.only(bottom: 0,top:690,left: 20),
      child:MaterialButton(
        onPressed:c==1?null:((){
          createData();
          }),
        child: Text('Submit',
          style: TextStyle(
            fontSize: 18,
            fontFamily: 'SFUIDisplay',
            fontWeight: FontWeight.bold,
          ),
        ),
        color: Colors.blueAccent,
        elevation: 5,
        minWidth: 130,
        height: 50,
        textColor: Colors.white,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10)
        ),
      ),
      ),

              Padding(
                padding: const EdgeInsets.only(top: 370,left: 40,right: 40,),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 80),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Slider(
                          value: _discreteValue,
                          min: 1,
                          max: 10,
                          divisions: 9,
                          activeColor: Color(0xFFFF2d55),
                          inactiveColor: Colors.black,
                          label: _discreteValue.round().toString(),
                          onChanged: (value) {
                            setState(() {
                              _discreteValue = value;
                              setUrgent(value);
                            });
                          },
                        ),
                        Text('Choose Urgency Level',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'SFUIDisplay',
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFFF2d55),
                          ),

                        ),
                      ],
                    ),
                  ],
                ),
              ),

            ]


    ),
    );
  }
  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    var currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    setState(() {
      c=2;
    });


    curLoc=currentLocation;
    controller.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
        bearing: 192.8334901395799,
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 16)

    ));
  }
}