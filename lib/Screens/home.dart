import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:travel_agency/Screens/alldriver.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ABC Travel Agency Home'),),
      body: Padding(padding: EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(height: 50,
          width: 200,
            child: ElevatedButton(onPressed: ()
            {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return AllDriverScreen();
              }));
            
            }, child:Text('Driver',style: TextStyle(fontSize:30 ),)),
          )
        ],
      ),
      ),
    );
  }
}