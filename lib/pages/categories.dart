import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:happy_meal/models/category.dart';
import 'package:happy_meal/widgets/category_item.dart';
import 'package:http/http.dart' as http;

class CategoriesPage extends StatefulWidget {
  @override
  State<CategoriesPage> createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  late Future<List<Category>> _listCategories;

  @override
  void initState() {
    super.initState();
    _listCategories = _fetchCategories();
  }

  Future<List<Category>> _fetchCategories() async {
    Uri url = Uri.https('www.toysroom.it', '/categories.json');

    var response = await http.get(url);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception("Errore nel caricamento dei dati");
    }

    var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
    List<Category> categories =
        jsonResponse.map((el) => Category.fromJson(el as dynamic)).toList();

    return categories;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _listCategories,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (snapshot.hasError) {
          return SizedBox(
            width: double.infinity,
            // color: Colors.orange,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  snapshot.error.toString(),
                ),
                SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                  onPressed: _fetchCategories,
                  child: Text("Ricarica"),
                )
              ],
            ),
          );
        }

        final categories = snapshot.data;

        if (categories == null || categories.isEmpty) {
          return Center(
            child: Text("nessua categoria presente"),
          );
        }

        return GridView.builder(
          padding: EdgeInsets.all(24),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 24,
            mainAxisSpacing: 24,
            childAspectRatio: 3 / 2,
          ),
          itemCount: categories.length,
          itemBuilder: (context, index) {
            return CategoryItem(categories[index]);
          },
        );
      },
    );
  }
}
