
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:async';
import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:pothole/Screens/Console.dart';
import 'package:pothole/main.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:compressimage/compressimage.dart';


class SinglePothole extends StatefulWidget {
  @override
  MyHomePageState createState() => MyHomePageState();
  //SlidersState createState1() => SlidersState();
}

class MyHomePageState extends State<SinglePothole> {

  File image1;
  double _discreteValue = 1;
  var currentLocation;
  final db=Firestore.instance;
  var time= new DateTime.now();
  var urgValue;
  //String docId;


  Completer<GoogleMapController> _controller = Completer();

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

  Future<void> loc() async {
    final GoogleMapController controller = await _controller.future;


  }

  Future getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    await CompressImage.compress(imageSrc: image.path,desiredQuality: 15);
    currentLocation = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
    print(currentLocation);

    setState(() {
      image1 = image;
      _enabled=true;
    });
  }

  Future<void> createData() async{

    DocumentReference ref = await db.collection('reports').add({'uid': '$uid','geo':'$currentLocation',
      'time_s':'$time','urgency':'$urgValue','type':"Single Pothole",'status':"Not Seen",'url':""});
    print("${ref.documentID}");
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('${ref.documentID}');
    StorageUploadTask uploadTask= firebaseStorageRef.putFile(image1);
    StorageTaskSnapshot taskSnapshot= await uploadTask.onComplete;
    String downloadUrl = await firebaseStorageRef.getDownloadURL();
    await db.collection('reports').document(ref.documentID).updateData({'url': downloadUrl});
    print("${ref.documentID}");
    print("Image Uploaded");
    _showDialogOk();
  }


  bool _enabled=false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar:AppBar(
        title: Text("Single Pothole",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'SFUIDisplay',
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor: Color(0xffff2d55),


      ),
      body: Stack(
        children: <Widget>[

          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.all(23),
              child: ListView(
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.only(top: 400),
                    child: MaterialButton(
                      onPressed:() {
                        getImage();

                      },
                      child: Text('Take Picture',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'SFUIDisplay',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Color(0xffff2d55),
                      elevation: 0,
                      minWidth: 400,
                      height: 50,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),



                ],
              ),
            ),

          ),

          Padding(
            padding: EdgeInsets.only(top: 50,left: 10,right: 10,),

            child:Container(
              height: 350,

              child: image1==null?Text("                                  No Image\n\n(Please take Photo of pothole including the locality)",
              style: TextStyle(
               color: Colors.black,
                fontFamily: 'SFUIDisplay',
                fontWeight: FontWeight.bold,
                  ),
              ):Image.file(image1),
              alignment: Alignment.center,

            ),
          ),


                Padding(
            padding: const EdgeInsets.only(top: 330,left: 40,right: 40,),
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

          Padding(
            padding: EdgeInsets.only(top: 650,left:100 ,right:100 ),
            child: MaterialButton(
              onPressed: _enabled?(){
                createData();
                print("yes");
              }:null,

              child: Text('Submit',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'SFUIDisplay',
                  fontWeight: FontWeight.bold,
                ),
              ),
              color: Colors.blueAccent,
              elevation: 0,
              minWidth: 200,
              height: 50,
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
            ),
          ),

        ],
      ),
    );
  }


}

