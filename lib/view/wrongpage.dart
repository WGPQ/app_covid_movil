import 'package:flutter/material.dart';

import 'images.dart';

class FailPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Image(image: AssetImage(error)),
            ),
          ),
          Text("NO SE PUDO CARGAR \n CORRECTAMENTE LA PAGINA",style: TextStyle(fontSize: 25.0,fontStyle:FontStyle.italic),)
        ],
      ),
    );
  }
}
