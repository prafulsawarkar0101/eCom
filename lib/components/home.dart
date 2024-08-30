import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import "../modules/image_module1.dart";
import "../modules/json_lodar.dart";
import '../components/productCard.dart';

class ImageSliderScreen extends StatefulWidget {
  @override
  _ImageSliderScreenState createState() => _ImageSliderScreenState();
}

class _ImageSliderScreenState extends State<ImageSliderScreen> {
  late Future<List<ImageModule>> _imageData;

  @override
  void initState() {
    super.initState();
    _imageData = loadImageData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<ImageModule>>(
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
            return SingleChildScrollView(
              child: Column(children: [
                CarouselSlider(
                  options: CarouselOptions(
                    height: 400.0,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 2,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    scrollDirection: Axis.horizontal,
                  ),
                  items: snapshot.data!.map((imageModule) {
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.network(
                            imageModule.url,
                   
                          ),
                          Padding(
                            padding: const EdgeInsets.all(4),
                            child: Text(imageModule.productName.toString()),
                          )
                        ]); // Display images from the JSON data
                  }).toList(),
                ),
                Center(
                    child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text("Best Sales",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                      )),
                )),
                Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: snapshot.data!.map((imageModule) {
                      return Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ProductCard(imageModule: imageModule)
                          ]); // Display images from the JSON data
                    }).toList())
              ]),
            );
          }
        },
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
      elevation: 2,
      margin: EdgeInsets.all(10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  imageModule.productName,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Price: \$${imageModule.price}',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  'Old Price: \$${imageModule.oldprice}',
                  style: TextStyle(
                      fontSize: 10,
                      color: Colors.red,
                      decoration: TextDecoration.lineThrough),
                ),
              ),
              Padding(
                padding:  EdgeInsets.symmetric(horizontal: 8.0,vertical: 8
                ),
                child:ElevatedButton(onPressed: (){

                },
                child: Text("Add to Bag",
                style: TextStyle(
                  color: Colors. black
                ),),
                style:  ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.grey.shade200),
                ),

              


                
                )
              ),
            ],
          ),
          Image.network(
            imageModule.url,
            height: 150,
            width: 120,
            fit: BoxFit.cover,
          ),
        ],
      ),
    );
  }
}
