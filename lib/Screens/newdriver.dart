import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:travel_agency/DBHelper/dbhelper.dart';

class NewDriver extends StatefulWidget {
  const NewDriver({super.key});

  @override
  State<NewDriver> createState() => _NewDriverState();
}

class _NewDriverState extends State<NewDriver> {
  TextEditingController nicController=TextEditingController();
  TextEditingController nameController=TextEditingController();
  TextEditingController licensenumConroller=TextEditingController();
  TextEditingController contactController=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('New Driver'),),
      body: Padding(padding: EdgeInsets.all(10),
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Name',
              labelText: 'Name'
            ),
          ),
          SizedBox(height: 10,),
          TextFormField(
            controller: nicController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'NIC',
              labelText: 'NIC'
            ),
          ),
          SizedBox(height: 10,),
           TextFormField(
            controller: licensenumConroller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'License#',
              labelText: 'License#'
            ),
          ),
          SizedBox(height: 10,),
           TextFormField(
            controller: contactController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Contact',
              labelText: 'Contact'
            ),
          ),
          SizedBox(height: 10,),
          ElevatedButton(onPressed: ()async{
          int rowId= await DBHelper.instance.addDriver(nameController.text, nicController.text, 
                                        licensenumConroller.text, contactController.text);
                              if(rowId>0)
                              {
                                print('Data inserted..');
                              
                              }
                              else{
                                print('Error in insertion');
                              }

          }, child: Text('Save'))

        ],
      ),
      ),
    );
  }
}