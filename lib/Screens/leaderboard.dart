/*import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pothole/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SinglePothole.dart';
import 'RoadPatch.dart';
import 'dart:async';
import 'package:pothole/main.dart';
import 'dart:io';



Image image1;
String url;
var first;

class Exist extends StatefulWidget {
  @override
  _ExistState createState() => _ExistState();
}

class _ExistState extends State<Exist> {

  Future getPosts() async{
    var firestore=Firestore.instance;

    QuerySnapshot qn = await firestore.collection("reports").where("uid", isEqualTo: '$uid' ).getDocuments();

    return qn.documents;
  }

  var documentId;

  /*Future<void> getAddress(var location) async{
    print("122233---$location");
    final coordinates = new Coordinates(location.latitude,location.longitude);

    var addresses = await Geocoder.google("AIzaSyABgM0z71Xzf6z2pv0An2Cgm_YpWYTl0dA").findAddressesFromCoordinates(coordinates);
    first = addresses.first;
    print(" heyyyy ---${first.addressLine}");

  }*/

  Future<void> getImage1() async
  {
    //Image imageTemp;
    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child(documentId);
    String downloadUrl = await firebaseStorageRef.getDownloadURL();
    print("URL:- $downloadUrl");
    url=downloadUrl;


  }

  navigateToDetail(DocumentSnapshot post){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> DetailPage(post: post,)));
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Existing Queries",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'SFUIDisplay',
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor: Color(0xffff2d55),
      ),



      body: Container(
        child: FutureBuilder(
          future: getPosts(),
          builder: (_,snapshot)
          {
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(
                child: Text("Loading..."),
              );
            }
            else
            {
              return ListView.builder(

                  itemCount:snapshot.data.length,
                  itemBuilder: (_, index){

                    return ListTile(
                      title: Text(snapshot.data[index].data["time_s"],
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'SFUIDisplay',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        documentId=snapshot.data[index].documentID;
                        print(documentId);
                        //getAddress(snapshot.data[index].data["geo"]);
                        getImage1();
                        if(snapshot.data[index].data["type"]=="Patch of Road")
                          url=null;
                        image1=null;
                        navigateToDetail(snapshot.data[index]);
                      },
                      contentPadding: EdgeInsets.only(top: 3,bottom: 3,left: 20,right: 3),

                    );
                  }
              );
            }
          },
        ),
      ),

    );
  }


/*List<DocumentSnapshot> documentList;

   Future<void> getDocList() async{

    documentList=(await Firestore.instance.collection('reports').
    where("uid", isEqualTo: '$uid' ).getDocuments()).documents;
    print(documentList[1].data);

  } */


}


class DetailPage extends StatefulWidget{

  final DocumentSnapshot post;

  DetailPage({this.post,});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text(widget.post.data["time_s"],
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
        children: <Widget>[
          Container(
            child: Card(
              child: ListTile(
                title: Text("Type:  ${widget.post.data["type"]}\n\nUrgency Level:  ${widget.post.data["urgency"]}\n\n${widget.post.data["geo"]}\n\nStatus:  ${widget.post.data["status"]}",
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'SFUIDisplay',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                //subtitle: Text("${widget.post.data["type"]}\n${widget.post.data["urgency"]}\n${widget.post.data["geo"]}"),
              ),
            ),
          ),



          Padding(
            padding: EdgeInsets.only(top: 250,left: 10,right: 10,),

            child:Container(
              height: 350,

              child: image1==null?Text("No Image"):image1,
              alignment: Alignment.center,

            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 670,left: 250,right: 10,),

            child:
            FloatingActionButton.extended(
                onPressed: (){
                  setState(() {
                    image1=Image.network(url);
                  });
                },
                label: Text("Show Image")
            ),

          ),


        ],
      ),
    );
  }
}*/