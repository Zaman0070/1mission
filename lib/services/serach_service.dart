import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marketplace_app/product_list.dart';
import 'package:provider/provider.dart';
import 'package:search_page/search_page.dart';
import 'package:sizer/sizer.dart';

import '../product_details.dart';
import '../provider/product_provider.dart';

class Product {
  final String title, description, category, price, brand, image;
  final num postDate;
  final DocumentSnapshot documentSnapshot;

  Product(
      {this.title,
      this.documentSnapshot,
      this.category,
      this.price,
      this.description,
      this.postDate,
      this.brand,
      this.image});
}

class SearchService {
  search({context, productList, provider}) {
    var provider = Provider.of<ProductProvider>(context, listen: false);
    showSearch(
      context: context,
      delegate: SearchPage<Product>(
        onQueryUpdate: (s) => print(s),
        items: productList,
        searchLabel: 'Search Product',
        suggestion: ProductList(),
        failure: Center(
          child: Text('No Product found :('),
        ),
        filter: (product) => [
          product.title,
          product.description,
          product.category,
          product.brand
        ],
        builder: (product) => Column(
          children: [
            ListTile(
              onTap: () {
                provider.getProductDetails(product.documentSnapshot);
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => ProductDetailScreen()));
              },
              leading: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                      height: 6.h,
                      width: 6.h,
                      child: Image.network(
                        product.image,
                        fit: BoxFit.cover,
                      ))),
              title: Text(product.title),
              subtitle: Text(product.brand),
              trailing: Text('QAR ${product.price}'),
            ),
            Divider(),
          ],
        ),
      ),
    );
  }
}

//17.30