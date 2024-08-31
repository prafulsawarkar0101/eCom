class ImageModule{
  
  final String url;
  final String productName ;
  final String price;
  final String oldprice;
  final String description ;
  final String category;
  final int id;
  ImageModule({
  required this.url, 
  required this.productName,
  required this.price,
  required this.description,
  required this.category,
  required this.oldprice,
  required this.id,


  });

  factory ImageModule.fromJson(Map<String, dynamic> json){
    return ImageModule(
      url:json["image"], 
      productName: json["title"],
      price: json["price"].toString(),
      oldprice: json["oldPrice"].toString(),
      description: json["description"],
      category: json["category"],
      id : json['_id']

      
      );
  }
}