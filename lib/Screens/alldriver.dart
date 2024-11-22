import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:travel_agency/DBHelper/dbhelper.dart';
import 'package:travel_agency/Screens/newdriver.dart';

class AllDriverScreen extends StatefulWidget {
  const AllDriverScreen({super.key});

  @override
  State<AllDriverScreen> createState() => _AllDriverScreenState();
}

class _AllDriverScreenState extends State<AllDriverScreen> {
  List<Map<String,dynamic>> rows=[];
  List<Map<String,dynamic>> filterList=[];
  int selection=1; // 1 for all , 2 for working , 3 for left
  fetchAllDrivers()async
  {
    rows=await DBHelper.instance.allDrivers();
    filterList=rows;
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  GestureDetector(
                    onTap: (){
                      selection=1;
                      setState(() {
                        filterList=rows;
                        
                      });
                    },
                    child: Container(height: 50,width: 100,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5),
                      color: selection==1?Colors.blue:Colors.grey
                    ),
                    child: Center(child: Text('All',style: TextStyle(color: Colors.white,fontSize: 30),)),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){
                      selection=2;
                      setState(() {
                        filterList=rows.where((element) => element["isDeleted"]==0).toList();
                        
                      });
                    },
                    child: Container(height: 50,width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5),
                      color: selection==2?Colors.blue:Colors.grey
                    ),
                    child: Center(child: Text('Working',style: TextStyle(color: Colors.white,fontSize: 30),)),
                    ),
                  ),
                  
                  GestureDetector(
                    onTap: (){
                      selection=3;
                      setState(() {
                        filterList=rows.where((element) => element["isDeleted"]==1).toList();
                        
                      });
                    },
                    child: Container(height: 50,width: 150,
                    decoration: BoxDecoration(
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(5),
                      color: selection==3?Colors.blue:Colors.grey
                    ),
                    child: Center(child: Text('Left',style: TextStyle(color: Colors.white,fontSize: 30),)),
                    ),
                  ),
                  
                ],
              ),
            ),
            SizedBox( height: 10,),
            Expanded(child: Container(
              child: listView(),
            ))
          ],
        ),
      )
      
     
    );
  }

  ListView listView() {
    return ListView.builder(
      itemCount: filterList.length,
      itemBuilder: (context,index){
        Map<String,dynamic> row=filterList[index];
        return Card(
          color: row["isDeleted"]==0?const Color.fromARGB(255, 227, 203, 232):const Color.fromARGB(255, 233, 148, 142),
          elevation: 2,
          margin: EdgeInsets.all(5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                Text(row["name"],style: TextStyle(fontSize: 20),),
                Text("NIC: ${row["cnic"]}",style: TextStyle(fontSize: 20),)
              ],),
              SizedBox(width: 5,),
              IconButton(onPressed: ()async{
              await showDialog(
                barrierDismissible:false ,
                context: context, 
               
                  builder: (BuildContext context){
                    return AlertDialog(
                      title: Text('Are you sure to delete?'),
                      actions: [
                        TextButton(onPressed: ()async{
                         await DBHelper.instance.delteDriver(row["cnic"]);
                         Navigator.pop(context);

                        }, child: Text('Yes')),
                        TextButton(onPressed: (){
                          Navigator.pop(context);

                        }, child: Text('No')),


                      ],
                    );

                  }
               
               );
               fetchAllDrivers();
              }, icon: Icon(Icons.delete))
            ],
          ),

        );
      });
  }
}