import 'dart:convert';

import 'package:flutter_application_1/models/category.dart';
import 'package:flutter_application_1/models/product.dart';
import 'package:http/http.dart' as http;

class ProductService {
  static const String _baseUrl = 'https://dummyjson.com';
  
  Future<List<Product>> getProducts({int limit=10}) async{

  final url =Uri.parse("$_baseUrl/products?limit=$limit");

 final response = await http.get(url);
  
  if(response.statusCode != 200){
    throw Exception('Error consultando Productos Error ${response.statusCode}');
  }
  final Map<String, dynamic> data = jsonDecode(response.body);
  final List<dynamic> jsonList = data['products'];
  return jsonList.map((j) => Product.fromJson(j)).toList();
  }


  Future<List<Category>> getCategory() async {
  final url= Uri.parse('$_baseUrl/products/categories');
  final response = await http.get(url);
  if(response.statusCode != 200){
    throw Exception('Error consultando Productos Error ${response.statusCode}');
  }
  final List<dynamic> jsonList = json.decode(response.body);

  return jsonList.map((j)=>Category.fromJson(j)).toList();


}

Future<Product> getProductById(int id) async{
  final url= Uri.parse('$_baseUrl/products/$id');
  final response = await http.get(url);
  if(response.statusCode != 200){ 
    throw Exception('Error consultando Productos Error ${response.statusCode}');
  }
  return Product.fromJson(jsonDecode(response.body));
}


Future<List<Product>> getProductsByCategory(String slug) async {
  final url = Uri.parse("$_baseUrl/products/category/$slug");
  final response = await http.get(url);
  
  if(response.statusCode != 200) {
  throw Exception('Error Consultando las Categorias: ${response.statusCode}');
  }
  final Map<String, dynamic> data = jsonDecode(response.body);
  final List<dynamic> jsonList = data['products'];
return jsonList.map((j)=>Product.fromJson(j)).toList();

}

}