import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:okapy_dashboard/core/data/remote_data_source/api_requests.dart';
import 'package:okapy_dashboard/core/data/remote_data_source/network_urls.dart';
import 'package:okapy_dashboard/product/data/product_model.dart';

class ProductController extends ChangeNotifier {
  final _apiRequests = ApiRequests();

  String _errorMessage = "";
  String get errorMessage => _errorMessage;
  List<ProductModel> _products = [];
  List<ProductModel> get products => _products;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  ProductModel? _productDetails;
  ProductModel? get productDetails => _productDetails;

  List<Category> _productCategories = [];
  List<Category> get productCategories => _productCategories;

  Category _selectedCategory = Category();
  Category get selectedCategory => _selectedCategory;
  set selectedCategory(Category category) {
    _selectedCategory = category;
    notifyListeners();
  }

  void setSelectedCategory(Category category) {
    print("Category ${category.name}");
    _selectedCategory = category;
    notifyListeners();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  Uint8List? _image;
  Uint8List? get image => _image;

  void selectImage(Uint8List? img) {
    _image = img;
  }

  Future getProducts() async {
    try {
      const url = NetworkUrl.methodProduct;

      final response = await _apiRequests.getRequest(url: url);
      List responseList = response!.data;
      if (response.statusCode == HttpStatus.ok) {
        _products = responseList
            .map((product) => ProductModel.fromJson(product))
            .toList();

        notifyListeners();
      } else {
        _errorMessage = response.data;
        print("$_errorMessage");
      }
      return products;
    } catch (error) {
      _errorMessage = error.toString();
      print("$_errorMessage");
    }
  }

  Future getCategories() async {
    try {
      const url = NetworkUrl.methodProductCategory;
      final response = await _apiRequests.getRequest(url: url);
      List responseList = response!.data;
      if (response.statusCode == HttpStatus.ok) {
        _productCategories = responseList
            .map((category) => Category.fromJson(category))
            .toList();
        print("Category $responseList");
        notifyListeners();
        return productCategories;
      } else {
        _errorMessage = response.data;
        print("$_errorMessage");
        return null;
      }
    } catch (error) {
      _errorMessage = error.toString();
      print("$_errorMessage");
      return null;
    }
  }

  Future createCategory() async {
    _isLoading = true;
    const url = NetworkUrl.methodProductCategory;
    try {
      final data = {
        "name": nameController.text,
      };
      print("data is $data");
      final response = await _apiRequests.postRequest(url: url, data: data);
      print("response is $response");
      if (response!.statusCode == HttpStatus.created) {
        _isLoading = false;
        return true;
      } else {
        print(response.statusCode);
        _errorMessage = response.data;
        print(_errorMessage);
        _isLoading = false;
        notifyListeners();

        return false;
      }
    } catch (error, s) {
      _errorMessage = error.toString();
      print("$error, $s");
      _isLoading = true;
      return false;
    }
  }

  Future createProduct() async {
    _isLoading = true;
    const url = NetworkUrl.methodProduct;

    if (nameController.text.isEmpty ||
        priceController.text.isEmpty ||
        descriptionController.text.isEmpty) {
      _errorMessage =
          "Please make sure to fill in name, price and description ";
      return false;
    } else {
      try {
        final data = {
          "name": nameController.text,
          "description": descriptionController.text,
          "price": priceController.text,
          "partner": selectedCategory.partner.toString(),
          "category": selectedCategory.id.toString(),
        };
        print("data is $data");
        final response = await _apiRequests.postRequest(url: url, data: data);
        print("response is $response");
        if (response!.statusCode == HttpStatus.created) {
          _isLoading = false;
          return true;
        } else {
          print(response.statusCode);
          _errorMessage = response.data;
          print(_errorMessage);
          _isLoading = false;
          notifyListeners();

          return false;
        }
      } catch (error, s) {
        _errorMessage = error.toString();
        print("$error, $s");
        _isLoading = true;
        return false;
      }
    }
  }

  void setTextControllersToNull() {
    nameController = TextEditingController();
    descriptionController = TextEditingController();
    priceController = TextEditingController();
  }

  Future<ProductModel?> viewProduct(ProductModel product) async {
    try {
      _productDetails = null;

      _productDetails = product;
      print("selected active ${_productDetails!.isActive}");
    } catch (error, s) {
      _errorMessage = error.toString();
      print("$error, $s");
      return null;
    }
  }

  Future editProduct() async {
    final url = "${NetworkUrl.methodProduct}${_productDetails!.id}/";

    _isLoading = true;
    print("data ${_productDetails!.isActive}");
    try {
      final data = {
        "name": nameController.text,
        "description": descriptionController.text,
        "price": priceController.text,
        "category": selectedCategory.id.toString(),
        "is_active": "${_productDetails!.isActive}",
      };

      final response = await _apiRequests.patchRequest(url: url, data: data);
      if (response!.statusCode == HttpStatus.ok) {
        _isLoading = false;
        return true;
      } else {
        _isLoading = false;
        _errorMessage = response.data;
        return false;
      }
    } catch (error) {
      _isLoading = false;
      _errorMessage = error.toString();
      notifyListeners();
      return false;
    }
  }

  Future deleteProduct(ProductModel product) async {
    final url = "${NetworkUrl.methodProduct}${product.id}/";
    _isLoading = true;
    try {
      final data = {"is_deleted": true};
      final response = await _apiRequests.patchRequest(url: url, data: data);
      if (response!.statusCode == HttpStatus.ok) {
        _isLoading = false;

        return true;
      } else {
        _isLoading = false;

        print(response.statusCode);
        _errorMessage = response.data;
        print(_errorMessage);
        return false;
      }
    } catch (error, stackTrace) {
      _isLoading = false;
      _errorMessage = error.toString();
      debugPrint("$error, $stackTrace");
      notifyListeners();
      return false;
    }
  }

  getAllActiveProducts() {
    return products.where((product) => product.isActive == true).length;
  }

  getAllInactiveProducts() {
    return products.where((product) => product.isActive == false).length;
  }
}
