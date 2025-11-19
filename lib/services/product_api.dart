import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductApi {
  static const String baseUrl = 'https://api.escuelajs.co/api/v1/products';

  Future<List<Product>> fetchProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data.map((item) => Product.fromJson(item)).toList();
    } else {
      throw Exception('Erreur lors du chargement des produits');
    }
  }

  Future<Product> fetchProductById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/products/$id'));

    if (response.statusCode == 200) {
      return Product.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Erreur lors du chargement du produit avec l\'ID $id');
    }
  }
}
