
import 'package:sqflite/sqflite.dart';
import 'package:travel_agency/Driver/driverModel.dart';
class DBHelper
{
  DBHelper._privateConstructor();
  Database? _database;
  static DBHelper instance=DBHelper._privateConstructor();
  Future<Database> get database async{
    // if(_database==null)
    // {
    //   _database=await initializeDB();
    // }
       _database ??= await initializeDB();
    return _database!;
  
  }

  Future<Database> initializeDB() async
  {
      String path= await getDatabasesPath();
      String dbpath=path+"/travelAgency.db";
     
      Database db= await openDatabase(dbpath,
                                      version: 1,
                                      onCreate: _createDB);
      return db;
    
  }
  _createDB(Database db,int version)async
  {
    String query='''
             Create table VehicleType(id INTEGER Primary Key AutoIncrement,
                                  type TEXT)
                 ''';
    await db.execute(query);
    query='''
             Create table Vehicle(id INTEGER Primary Key AutoIncrement,
                                  type TEXT,regnum TEXT,seats INTEGER,
                                  isDeleted INTEGER
                                  )
                 ''';
             await db.execute(query);
      query='''
             Create table Driver(cnic TEXT Primary Key,
                                  name TEXT,licensenum TEXT,contact TEXT,
                                  image TEXT, isDeleted INTEGER
                                  )
                 ''';
             await db.execute(query);
        query='''
             Create table Boooking(id INTEGER Primary Key AutoIncrement,
                                  customer TEXT ,
                                  date TEXT,contact TEXT,
                                  bookingAmount INTEGER,
                                  status INTEGER
                                  )
                 ''';
             await db.execute(query);
             query='''
             Create table Expense(id INTEGER Primary Key AutoIncrement,
                                  Title TEXT
                                
                                  )
                 ''';
             await db.execute(query);
         query='''
             Create table BoookingExpenses(id INTEGER Primary Key AutoIncrement,
                                  bookingID INTEGER,
                                  Title TEXT,
                                  amount INTEGER
                                  )
                 ''';
             await db.execute(query);


  }

  Future<int> addDriver(String name,String nic,String license,String contact)async
  {
    Database db=await database;
    String query='''
          insert into Driver values ('${nic}','${name}','${license}','${contact}','',0)
                ''';
            int rowId=   await db.rawInsert(query);
            return rowId;
            
  }
  
  Future<int> insertDriver(DriverModel driver)async
  {
    Database db=await database;
    int rowId=await db.insert('Driver', driver.toMap());
            return rowId;
            
  }
  Future<List<Map<String,dynamic>>> allDrivers()async
  {
    Database db=await database;
   List<Map<String,dynamic>> rows  =await db.query('Driver');
   return rows;
  }
  Future<List<DriverModel>> getAllDrivers()async
  {
    Database db=await database;
    List<Map<String,dynamic>> rows  =await db.query('Driver');
    // List<DriverModel> driver_list=[];
    // for(int i=0;i<rows.length;i++)
    // {
    //   driver_list.add(DriverModel.fromMap(rows[i]));

    // }
    // return driver_list;
    return rows.map((row) => DriverModel.fromMap(row)).toList();

  }
  
  


}