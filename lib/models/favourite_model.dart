
class FavouriteModel {


  bool status;
  dynamic message;
  Data data;

   FavouriteModel.fromJson(Map<String, dynamic> json) {
    status= json["status"];
    message = json["message"];
    data= Data.fromJson(json["data"]);

  }

}

class Data {
  Data({

    this.listData,

    this.total,
  });


  List<FavouriteData> listData;

  int total;

   Data.fromJson(Map<String, dynamic> json) {

       listData= List<FavouriteData>.from(json["data"].map((x) => FavouriteData.fromJson(x)));

       total= json["total"];

   }


}

class FavouriteData {
  FavouriteData({
    this.id,
    this.product,
  });

  int id;
  Product product;

   FavouriteData.fromJson(Map<String, dynamic> json) {
     id= json["id"];
     product= Product.fromJson(json["product"]);
   }
}

class Product {
  Product({
    this.id,
    this.price,
    this.oldPrice,
    this.discount,
    this.image,
    this.name,
    this.description,
  });

  int id;
  dynamic price;
  dynamic oldPrice;
  int discount;
  String image;
  String name;
  String description;

   Product.fromJson(Map<String, dynamic> json){
     id= json["id"];
     price= json["price"];
     oldPrice= json["old_price"];
     discount= json["discount"];
     image= json["image"];
     name= json["name"];
     description= json["description"];
   }

}
