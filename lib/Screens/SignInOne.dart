import 'package:flutter/material.dart';
import 'package:pothole/HomeSkip.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SignUp.dart';
import 'package:pothole/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pothole/main.dart';


class SignInOne extends StatefulWidget{
  @override
  _SignIn createState() => _SignIn();
}

class _SignIn extends State<SignInOne> {

  String _email;
  String _password;
  String email;

  final formKey= GlobalKey<FormState>();
  final formKey1= GlobalKey<FormState>();

  void _showDialogNok() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Sign In Unsucessful"),
          content: new Text("Email Or Password Incorrect",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay'
            ),
          ),

          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close",
                style: TextStyle(
                  color: Color(0xffff2d55),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

  }

  bool validateAndSave() {
    final form = formKey.currentState;
    final form1 = formKey1.currentState;

    if (form1.validate()&&form.validate()) {
      form.save();
      form1.save();
      return true;
    }
    else
      return false;
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      try {
        AuthResult user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        print("Signed In with UserID: ${user.user.uid}");
        if(user.user.uid!=null)
          {
            Navigator.of(context)
                          .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                        return new HomeSkip();
                      }));
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('uid', user.user.uid);
            uid=user.user.uid;
          }
      }
      catch (e) {
        print("Error:- $e");
        _showDialogNok();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('Assets/gra_2.png'),
              fit: BoxFit.fitWidth,
              alignment: Alignment.topCenter
            )
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(top: 100),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
          ),
          child: Padding(
            padding: EdgeInsets.all(23),
            child: ListView(
              children: <Widget>[
                Padding(
                    padding: EdgeInsets.only(top:0,bottom: 20),
                    child:Center(
                      child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "FILL\n",
                                  style: TextStyle(
                                    fontFamily: 'SFUIDisplay',
                                    color: Color(0xffff2d55),
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.black38,
                                        offset: Offset(-5.0, 5.0),
                                      ),
                                    ],
                                  )

                              ),

                              TextSpan(
                                  text: "Up.",
                                  style: TextStyle(
                                    fontFamily: 'SFUIDisplay',
                                    color: Colors.black,
                                    fontSize: 80,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        blurRadius: 10.0,
                                        color: Colors.black38,
                                        offset: Offset(-5.0, 5.0),
                                      ),
                                    ],
                                  )
                              ),

                            ]
                        ),
                      ),
                    )
                ),

                Padding(
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                  child: Container(
                    color: Color(0xfff5f5f5),
                    child:Form(
                      key: formKey1,
                    child: TextFormField(
                      style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'SFUIDisplay'
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.person_outline),
                        labelStyle: TextStyle(
                          fontSize: 15
                        )
                      ),
                      validator: (value)=> value.isEmpty?"Email can't be Empty":null,
                      onSaved: (value)=>_email=value,
                    ),
                  ),
                ),
                ),
                Container(
                  color: Color(0xfff5f5f5),
                  child: Form(
                    key: formKey,
                    child: TextFormField(
                    obscureText: true,
                    style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'SFUIDisplay'
                    ),
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                      labelStyle: TextStyle(
                          fontSize: 15
                        )
                    ),
                    validator: (value)=> value.isEmpty?"Password can't be Empty":null,
                      onSaved: (value)=>_password=value,
                  ),
                ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: MaterialButton(
                    onPressed:(){
                      validateAndSubmit();

                    },
                    child: Text('SIGN IN',
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
                /*Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Center(
                    child: Text('Forgot your password?',
                    style: TextStyle(
                      fontFamily: 'SFUIDisplay',
                      fontSize: 15,
                      fontWeight: FontWeight.bold
                    ),
                    ),
                  ),
                ),*/
                Padding(
                    padding: EdgeInsets.only(top:20),
                    child:Center(
                      child: RichText(
                        text: TextSpan(
                            children: [
                              TextSpan(
                                  text: "Don't have an account?",
                                  style: TextStyle(
                                    fontFamily: 'SFUIDisplay',
                                    color: Colors.black,
                                    fontSize: 15,
                                  )
                              ),

                            ]
                        ),
                      ),
                    )
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        RaisedButton(
                          child: Text("SignUp",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'SFUIDisplay',
                              fontWeight: FontWeight.bold,
                            ),),
                          textColor: Colors.white,
                          onPressed:(){
                            formKey.currentState.reset();
                            formKey1.currentState.reset();
                            Navigator.of(context)
                                .push(MaterialPageRoute<Null>(builder: (BuildContext context) {
                              return new SignUp();
                            }));

                          },

                        color: Color(0xffff2d55),
                        ),
                        SizedBox(height:12),

                      ],

                    ),

                  ),
                ),

                Row(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(top:90,right: 20,left: 110),
                        child:Center(
                          child: RichText(
                            text: TextSpan(
                                children: [
                                  TextSpan(
                                      text: "Built By :",
                                      style: TextStyle(
                                        fontFamily: 'SFUIDisplay',
                                        color: Colors.black26,
                                        fontSize: 15,
                                      ),
                                  ),
                                  TextSpan(
                                      text: " EXCEL-RATORS",
                                      style: TextStyle(
                                        fontFamily: 'SFUIDisplay',
                                        color: Colors.black26,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                  ),

                                ]
                            ),
                          ),
                        )
                    ),
                  ],
                ),

              ],
            ),
          ),

        ),

      ],
    );
  }
}