import 'dart:convert';

import 'package:http/http.dart' as http;

import '../../models/product_model.dart';

class ApiService {

  static const String baseUrl =
      'http://10.0.2.2:3000/api';

  // GET PRODUCTS
  Future<List<ProductModel>>
      getProducts() async {

    final response =
        await http.get(
      Uri.parse(
        '$baseUrl/products',
      ),
    );

    if (response.statusCode == 200) {

      List data =
          jsonDecode(
        response.body,
      );

      return data
          .map(
            (e) =>
                ProductModel
                    .fromJson(e),
          )
          .toList();
    }

    return [];
  }

  // ADD PRODUCT
  Future<bool> addProduct(
      ProductModel product) async {

    final response =
        await http.post(

      Uri.parse(
        '$baseUrl/products',
      ),

      headers: {
        'Content-Type':
            'application/json',
      },

      body: jsonEncode({

        "name": product.name,

        "description":
            product.description,

        "price": product.price,

        "imageUrl":
            product.imageUrl,

        "category":
            product.category,

        "stock": product.stock,
      }),
    );

    return response.statusCode ==
        201;
  }

  // UPDATE PRODUCT
  Future<bool> updateProduct(
      ProductModel product) async {

    final response =
        await http.put(

      Uri.parse(
        '$baseUrl/products/${product.id}',
      ),

      headers: {
        'Content-Type':
            'application/json',
      },

      body: jsonEncode({

        "id": product.id,

        "name": product.name,

        "description":
            product.description,

        "price": product.price,

        "imageUrl":
            product.imageUrl,

        "category":
            product.category,

        "stock": product.stock,
      }),
    );

    return response.statusCode ==
        200;
  }

  // DELETE PRODUCT
  Future<bool> deleteProduct(
      int id) async {

    final response =
        await http.delete(

      Uri.parse(
        '$baseUrl/products/$id',
      ),
    );

    return response.statusCode ==
        200;
  }
}