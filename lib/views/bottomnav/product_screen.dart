// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:mvvm_provider_dio/viewmodels/product_viewmodel.dart';
import 'package:provider/provider.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {

    // Load products
    final productViewModel = Provider.of<ProductViewModel>(context, listen: true);
    productViewModel.loadProducts();

    return Consumer<ProductViewModel>(
      builder: (context, product, child) {
        return ListView.builder(
          itemCount: product.products.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(product.products[index].name.toString()),
              subtitle: Text(product.products[index].description.toString()),
              trailing: Text(product.products[index].price.toString()),
            );
          },
        );
      }
    );
  }
}