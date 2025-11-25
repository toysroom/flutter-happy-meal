import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:happy_meal/models/category.dart';
import 'package:happy_meal/models/meal.dart';
import 'package:happy_meal/pages/meal_details.dart';
import 'package:http/http.dart' as http;

class MealsPage extends StatefulWidget {
  final Category category;

  MealsPage({required this.category});

  @override
  State<MealsPage> createState() => _MealsPageState();
}

class _MealsPageState extends State<MealsPage> {
  late Future<List<Meal>> _listMeals;

  @override
  initState() {
    super.initState();
    _listMeals = _fetchMeals();
  }

  Future<List<Meal>> _fetchMeals() async {
    Uri url = Uri.https('www.toysroom.it', '/meals.json');

    var response = await http.get(url);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception("Errore nel caricamento dei dati");
    }

    var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;

    List<Meal> meals =
        jsonResponse.map((el) => Meal.fromJson(el as dynamic)).toList();

    List<Meal> filteredMeals = meals.where((meal) {
      return meal.categories.contains(widget.category.id);
    }).toList();

    return filteredMeals;
  }

  Widget _buildMealItem(BuildContext context, Meal meal) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => MealDetailsPage(meal: meal)),
        );
      },
      child: Card(
        child: Stack(
          children: [
            Image.network(meal.imageUrl),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.black54,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Column(
                  children: [
                    Text(
                      meal.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w700),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _mealItemCharacteristic(
                            "${meal.duration.toString()} min", Icons.schedule),
                        _mealItemCharacteristicSeparator(),
                        _mealItemCharacteristic(
                            meal.complexity.name, Icons.work),
                        _mealItemCharacteristicSeparator(),
                        _mealItemCharacteristic(
                            meal.affordability.name, Icons.attach_money),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mealItemCharacteristic(String title, IconData icon) {
    return Row(children: [
      Icon(
        icon,
        color: Colors.white,
        size: 16,
      ),
      SizedBox(
        width: 4,
      ),
      Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
    ]);
  }

  Widget _mealItemCharacteristicSeparator() {
    return SizedBox(
      width: 16,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.category.title),
      ),
      body: FutureBuilder(
        future: _listMeals,
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
                    onPressed: _fetchMeals,
                    child: Text("Ricarica"),
                  )
                ],
              ),
            );
          }

          final meals = snapshot.data;

          if (meals == null || meals.isEmpty) {
            return Center(
              child: Text("nessu piatto presente"),
            );
          }

          return ListView.builder(
            itemCount: meals.length,
            itemBuilder: (context, index) {
              return _buildMealItem(context, meals[index]);
            },
          );
        },
      ),
    );
  }
}
