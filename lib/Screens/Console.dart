import 'package:flutter/material.dart';
import 'package:pothole/Home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SinglePothole.dart';
import 'RoadPatch.dart';
import 'dart:async';
import 'package:pothole/main.dart';
import 'Exist.dart';
import 'package:url_launcher/url_launcher.dart';


_launchURL() async {
  const url = 'https://pothole-1579544238956.web.app';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw 'Could not launch $url';
  }
}


class Console extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("CONSOLE",
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'SFUIDisplay',
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor: Color(0xffff2d55),
      ),

      floatingActionButton : FloatingActionButton.extended(
        onPressed: () async{
          Navigator.of(context)
              .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
            return new Home();
          }));
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.remove('uid');
        },

        label: Text('LogOut',
          style: TextStyle(
            fontSize: 15,
            fontFamily: 'SFUIDisplay',
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blueAccent,

      ),
      drawer:
      Drawer(
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:[ Text("MENU",
                style: TextStyle(
                  fontSize: 25,
                  fontFamily: 'SFUIDisplay',
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
                  Text("\n\nLogged In as:\n",
                    style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'SFUIDisplay',
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text("$userEmail",
                    style: TextStyle(
                      fontSize: 18,
                      fontFamily: 'SFUIDisplay',
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
              ],
            ),

              decoration: BoxDecoration(
                color: Color(0xffff2d55),
              ),

            ),
            ListTile(
              title: Text('Help',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'SFUIDisplay',
                  fontWeight: FontWeight.bold,
                ),),
              onTap: () {
                _launchURL();

              },
            ),
            ListTile(
              title: Text('Contact Us',
                style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'SFUIDisplay',
                  fontWeight: FontWeight.bold,
                ),),
              onTap: () {
                // Update the state of the app.
                // ...
                _launchURL();
              },
            ),
          ],
        ),

      ),
      body: Stack(
        children: <Widget>[


          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(top: 150),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsets.all(23),
              child: ListView(
                children: <Widget>[

                  Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: MaterialButton(
                      onPressed:(){
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new SinglePothole();
                        }));

                      },
                      child: Text('SINGLE POTHOLE',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'SFUIDisplay',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Color(0xffff2d55),
                      elevation: 5,
                      minWidth: 400,
                      height: 50,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 200),
                    child: MaterialButton(
                      onPressed:(){
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new RoadPatch();
                        }));

                      },
                      child: Text('PATCH OF ROAD',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'SFUIDisplay',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Color(0xffff2d55),
                      elevation: 5,
                      minWidth: 400,
                      height: 50,
                      textColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(top: 100),
                    child: MaterialButton(
                      onPressed:(){
                        Navigator.of(context)
                            .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                          return new Exist();
                        }));

                      },
                      child: Text('EXISTING QUERIES',
                        style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'SFUIDisplay',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      color: Color(0xffff2d55),
                      elevation: 5,
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
            height: 100,

            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xffff2d55),
                  width: 3,
                
              ),
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                    image: AssetImage('Assets/pothole.png'),

                    fit: BoxFit.fitWidth,
                    alignment: Alignment.center,
                )
            ),

          ),
         ),


          Padding(
            padding: EdgeInsets.only(top: 300,left: 10,right: 10,),
            child:Container(
              height: 100,

              decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffff2d55),
                    width: 3,

                  ),
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                      image: AssetImage('Assets/patch.png'),

                      fit: BoxFit.fitWidth,
                      alignment: Alignment.center,
                  )
              ),

            ),
          ),



        ],
      ),
    );
  }
}