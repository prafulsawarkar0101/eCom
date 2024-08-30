import 'package:flutter/material.dart';
import '../modules/image_module1.dart';

class ProductCardHome extends StatelessWidget {
  final ImageModule imageModule;

  ProductCardHome({required this.imageModule});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          // Image section
          Container(
            width: 100, // Set the width of the image container
            height: double.infinity, // Full height of the card
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageModule.url),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.horizontal(left: Radius.circular(5)),
            ),
          ),
          // Description section
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    imageModule.productName,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Price: \$${imageModule.price}',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Old Price: \$${imageModule.oldprice}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.red,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () {
                      // Define your onPressed action here
                    },
                    child: Text('Buy Now'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
