class CategoriesModel{

  late bool status;
  CategoriesDataModel? data;
  CategoriesModel.fromJson(Map<String,dynamic>json)
  {
    status=json['status'];
    data=CategoriesDataModel.fromJson(json['data']);
  }


}

class CategoriesDataModel
{
int? currentPage;
late List<DataModel>data=
[

];
CategoriesDataModel.fromJson(Map<String,dynamic>json)
{
  currentPage=json['current_page'];
  data=json['data'].forEach((element)=>
      data.add(DataModel.fromJson({
        'name':element['name'],
        'id':element['id'],
        'image':element['image'],
      })));
}
}
class DataModel
{
  int? id;
  String? name;
  String? image;

  DataModel.fromJson(Map<String,dynamic>json)
  {
    id=json['id'];
    name=json['name'];
    image=json['image'];
  }
}

