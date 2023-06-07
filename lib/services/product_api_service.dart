
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvvm_provider_dio/models/product_model.dart';

class ProductApiService {

   // Firestore instance
   final CollectionReference _productsCollection = FirebaseFirestore.instance.collection('product');

    // Get all products
    Future<List<ProductModel>> getProducts() async {
      final snapshot = await _productsCollection.get();
      return snapshot.docs.map((doc) {
        final data = doc;
        return ProductModel(
          name: data['name'],
          description: data['description'],
          price: data['price'],
        );
      }).toList();
    }
}