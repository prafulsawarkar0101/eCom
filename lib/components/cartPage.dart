import 'dart:ffi';

import 'package:ecom/main.dart';
import 'package:ecom/modules/image_module1.dart';
import 'package:ecom/modules/json_lodar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import '../modules/cart.dart';
import '../modules/cart.dart';

class ProductCatelogList extends StatefulWidget {
  @override
  _ProductCatelogListState createState() => _ProductCatelogListState();
}

class _ProductCatelogListState extends State<ProductCatelogList> {
  late Future<List<ImageModule>> _imageData;

  Future<List<ImageModule>> getCartProducts() async {
    List<int> selectedId = await getIdList();

    List<ImageModule> finalModList = [];
    List<ImageModule> imgDataf = await loadImageData();

    for (int x = 0; x < selectedId.length; x++) {
      for (int y = 0; y < imgDataf.length; y++) {
        if (imgDataf[y].id == selectedId[x]) {
          finalModList.add(imgDataf[y]);
        }
      }
    }

    return finalModList;
  }

  @override
  void initState() {
    super.initState();
    _imageData = getCartProducts();
  }

  void popIterm(int v) {
    setState(() {
      removeId(v);
      _imageData = getCartProducts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: FutureBuilder<List<ImageModule>>(
            future: _imageData,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height - 150,
                  child: Center(child: Text('Cart is empty')),
                );
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
                            Card(
                              elevation: 2,
                              margin: EdgeInsets.all(10),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          imageModule.productName,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          'Price: \$${imageModule.price}',
                                          style: TextStyle(
                                              fontSize: 14, color: Colors.grey),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0),
                                        child: Text(
                                          'Old Price: \$${imageModule.oldprice}',
                                          style: TextStyle(
                                              fontSize: 10,
                                              color: Colors.red,
                                              decoration:
                                                  TextDecoration.lineThrough),
                                        ),
                                      ),
                                      Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0, vertical: 14),
                                          child: ElevatedButton(
                                            onPressed: () {
                                              popIterm(imageModule.id);
                                            },
                                            child: Text(
                                              "Remove",
                                              style: TextStyle(
                                                  color: Colors.black),
                                            ),
                                            style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll<
                                                          Color>(
                                                      Colors.grey.shade200),
                                            ),
                                          )),
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
                            )
                          ]); //
                    }).toList());
              }
            }),
      ),
    );
  }
}


class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<int>> cartList;
  @override
  void initState() {
    // TODO: implement initState

    super.initState();
    cartList = getIdList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back))
          ],
          title: const Text("Your Cart"),
          automaticallyImplyLeading: false,
          forceMaterialTransparency: false,
        ),
        body: ProductCatelogList());
  }
}
