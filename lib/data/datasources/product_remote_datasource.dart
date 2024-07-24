import 'package:chuck_interceptor/core/chuck_http_extensions.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_onlineshop_app/chuck_interceptor.dart';
import 'package:flutter_onlineshop_app/core/constants/Variables.dart';
// import 'package:flutter_onlineshop_app/core/constants/variables.dart';
import 'package:flutter_onlineshop_app/data/models/responses/product_response_model.dart';
import 'package:http/http.dart' as http;

class ProductRemoteDatasource {
  // get all products
  Future<Either<String, ProductResponseModel>> getAllProducts() async {
    final response =
        await http.get(Uri.parse('${Variables.baseUrl}/api/products'));

    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return const Left('Internal Server Error');
    }
  }

  

// get product by category
  Future<Either<String, ProductResponseModel>> getProductByCategory(
      int categoryId) async {
    final response = await http.get(
        Uri.parse('${Variables.baseUrl}/api/products?category_id=$categoryId'));

    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return const Left('Internal Server Error');
    }
  }
// get product by category
  // Future<Either<String, ProductResponseModel>> getProductsLaptop(
  //     int categoryId) async {
  //   final response = await http.get(
  //       Uri.parse('${Variables.baseUrl}/api/products?category_id=$categoryId'));

  //   if (response.statusCode == 200) {
  //     return Right(ProductResponseModel.fromJson(response.body));
  //   } else {
  //     return const Left('Internal Server Error');
  //   }
  // }

// get product by category
  Future<Either<String, ProductResponseModel>> getSpecialOfferProduct(
      int categoryId) async {
    final response = await http.get(
        Uri.parse('${Variables.baseUrl}/api/products?category_id=$categoryId'));

    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return const Left('Internal Server Error');
    }
  }

    Future<Either<String, ProductResponseModel>> getProducts(
      {String? category, String? search}) async {
    final uri = Uri.parse('${Variables.baseUrl}/api/products');
    final response = await http
        .get(
          category != null
              ? uri.replace(queryParameters: {'category': category})
              : search != null
                  ? uri.replace(queryParameters: {'search': search})
                  : uri,
        )
        .interceptWithChuck(ChuckInterceptor().intercept);

    if (response.statusCode == 200) {
      return Right(ProductResponseModel.fromJson(response.body));
    } else {
      return const Left('Something went wrong');
    }
  }
}

