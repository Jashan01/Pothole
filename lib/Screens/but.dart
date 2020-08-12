import 'package:flutter/material.dart';

class but extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          RaisedButton(
            child: Text("Hello"),
            onPressed:(){},
          ),
          SizedBox(height:12),
          RaisedButton.icon(
            icon: const
            Icon(Icons.add,size:18),
            label:
            Text("Hello"),
            onPressed:(){},

          )
        ],
      ),
    );
  }
}