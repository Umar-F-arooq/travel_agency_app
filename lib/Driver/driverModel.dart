class DriverModel
{
  late String nic,name,license,contact,image;
  late int isDeleted;
  DriverModel({
    required this.contact,
    required this.name,
    required this.nic,
    required this.license,
    this.image="",
    this.isDeleted=0
  });
  DriverModel.fromMap(Map<String,dynamic> row){
    nic=row["cnic"];
    name=row["name"];
    license=row["licensenum"];
    contact=row["contact"];
    image=row["image"];
    isDeleted=row["isDeleted"];
  }
  Map<String,dynamic> toMap()
  {
    return {
      "cnic":nic,
      "name":name,
      "licensenum":license,
      "contact":contact,
      "image":image,
      "isDeleted":isDeleted
    };
  }
}