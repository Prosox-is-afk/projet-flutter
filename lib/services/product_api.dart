import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductApi {
  static const String _baseUrl = 'https://api.escuelajs.co/api/v1';

  Future<List<Product>> fetchProducts() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/products'));

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        return data
            .map((item) => Product.fromJson(item as Map<String, dynamic>))
            .toList();
      } else {
        // Pour debug, garde ça au début
        print('Erreur HTTP ${response.statusCode}: ${response.body}');
        throw Exception('Erreur HTTP ${response.statusCode}');
      }
    } catch (e, stack) {
      print('Erreur dans fetchProducts: $e');
      print(stack);
      throw Exception('Erreur lors du chargement des produits');
    }
  }
}
