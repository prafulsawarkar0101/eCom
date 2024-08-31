import 'package:flutter/material.dart';
import '../modules/image_module1.dart';

class AboutProduct extends StatelessWidget {
  final ImageModule product;

  AboutProduct({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Image.network(
                product.url,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),
            
            Text(
              product.productName,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
      
            Text(
              "Category: ${product.category}",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
      
            Row(
              children: [
                Text(
                  "\$${product.price}",
                  style: TextStyle(fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
                ),
                SizedBox(width: 10),
                if (product.oldprice.isNotEmpty)
                  Text(
                    "\$${product.oldprice}",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
              ],
            ),
            SizedBox(height: 16),
      
            Text(
              product.description,
              style: TextStyle(fontSize: 16),
            ),
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){

        Navigator.pop(context);

      },
      child: Icon(Icons.arrow_back),
      backgroundColor: Colors.black,
      
      ),
    );
  }
}
