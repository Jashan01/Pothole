import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pothole/Screens/SignInOne.dart';
import 'SignInOne.dart';

class SignUp extends StatefulWidget{
  @override
  _Sign createState() => _Sign();
}

class _Sign extends State<SignUp> {

  String _email;
  String _password;

  final formKey= GlobalKey<FormState>();
  final formKey1= GlobalKey<FormState>();

  void _showDialogOk() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Sign In Sucessful",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay'
            ),
          ),
          content: new Text("Your Account\nHas Been Created\nSuccessfully"),

          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showDialogNok() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Sign In Unsucessful",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'SFUIDisplay'
            ),
          ),
          content: new Text("Enter Valid Email\n\nMake Sure Password has minimum\n6 characters"),

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
        AuthResult user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        print("Created Account with UserID: ${user.user.uid}");
        if(user.user.uid!=null)
          {
            _showDialogOk();
          }

      }
      catch (e) {
        print("Error:- $e");
        _showDialogNok();
      }
      formKey.currentState.reset();
      formKey1.currentState.reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text("Sign Up",
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
          decoration: BoxDecoration(
              color: Color(0xffff2d55),

          ),
        ),

        Padding(
          padding: EdgeInsets.all(20),
          child:
            Container(
              child:
              Text("Create a\nNew Account",
              style: TextStyle(
                fontFamily: 'SFUIDisplay',
                color: Colors.white,
                fontSize: 40,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black38,
                    offset: Offset(-5.0, 5.0),
                  ),
                ],
              ),
              ),
            ),
        ),

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
                            labelText: 'Enter Email',
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
                          labelText: 'Enter Password',
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
                    onPressed: (){
                      validateAndSubmit();
                    },//since this is only a UI app
                    child: Text('SIGN UP',
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

      ],
    ),
    );
  }
}