import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import "../modules/image_module1.dart";
import "../modules/json_lodar.dart";

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  late Future<List<ImageModule>> _imageData;

  @override
  void initState() {
    super.initState();
    _imageData = loadImageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<List<ImageModule>>(
          future: _imageData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child:
                      CircularProgressIndicator()); // Show loading indicator while waiting
            } else if (snapshot.hasError) {
              return Center(
                  child: Text(
                      'Error: ${snapshot.error}')); // Display error message if any
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                  child: Text(
                      'No images found')); // Show message if no images are found
            } else {
            // snapshot.data!.map((imageModule) {
            //       return ProductCard(imageModule: imageModule);
            //     }).toList();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: snapshot.data!.map((imageModule) {
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ProductCard(imageModule: imageModule)
                       
                      ]); // Display images from the JSON data
                }).toList()
            );
            }
          }
        ),
      ),
    );
  }
}


class ProductCard extends StatelessWidget {
  final ImageModule imageModule;

  ProductCard({required this.imageModule});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Text(
                  imageModule.productName,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                ),
                              ),
                ),
          Image.network(
            imageModule.url,
            height: 300,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Container(
            child: Column(
              
              children: [
      
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Price: \$${imageModule.price}',
                style: TextStyle(fontSize: 16, color: Colors.green),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(
                'Old Price: \$${imageModule.oldprice}',
                style: TextStyle(fontSize: 14, color: Colors.red, decoration: TextDecoration.lineThrough),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                imageModule.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
               Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.grey.shade200),
                  ),
                  onPressed: (){},
                  child: Text("More Details",
                    style: TextStyle(
                      color: Colors.grey
                    ),
                  ),
                ),
              ),
            ),
              ],
            ),
          ),
    
        ],
      ),
    );
  }
}