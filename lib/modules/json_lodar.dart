import 'dart:convert';
import 'package:flutter/services.dart';
import "./image_module1.dart";

Future<List<ImageModule>> loadImageData() async {
  final String response = await rootBundle.loadString('lib/json/products.json');
  final List<dynamic> data = json.decode(response);
  return data.map((json) => ImageModule.fromJson(json)).toList();
}
