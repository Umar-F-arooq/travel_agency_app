import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:travel_agency/DBHelper/dbhelper.dart';
import 'package:travel_agency/Screens/newdriver.dart';

class AllDriverScreen extends StatefulWidget {
  const AllDriverScreen({super.key});

  @override
  State<AllDriverScreen> createState() => _AllDriverScreenState();
}

class _AllDriverScreenState extends State<AllDriverScreen> {
  List<Map<String,dynamic>> rows=[];
  fetchAllDrivers()async
  {
    rows=await DBHelper.instance.allDrivers();
    setState(() {
      
    });

  }
  void initState()
  {
    fetchAllDrivers();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Drivers'),),
      floatingActionButton: FloatingActionButton(onPressed: ()async{
       await Navigator.push(context, MaterialPageRoute(builder: (context){
              return NewDriver();
            }));
            fetchAllDrivers();
        
      },child: Text('+',style: TextStyle(fontSize: 40),),),
      body: ListView.builder(
        itemCount: rows.length,
        itemBuilder: (context,index){
          Map<String,dynamic> row=rows[index];
          return Card(
            elevation: 2,
            margin: EdgeInsets.all(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
              Text(row["name"],style: TextStyle(fontSize: 20),),
              Text("NIC: ${row["cnic"]}",style: TextStyle(fontSize: 20),)
            ],),

          );
        })
    );
  }
}