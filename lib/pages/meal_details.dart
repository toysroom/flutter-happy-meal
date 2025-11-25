import 'package:flutter/material.dart';
import 'package:happy_meal/models/meal.dart';
import 'package:happy_meal/services/favorites_storage.dart';

class MealDetailsPage extends StatefulWidget {
  final Meal meal;

  MealDetailsPage({required this.meal});

  @override
  State<MealDetailsPage> createState() => _MealDetailsPageState();
}

class _MealDetailsPageState extends State<MealDetailsPage> {
  late FavoritesStorage favoritesStorage;
  bool isFavorite = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    favoritesStorage = FavoritesStorage();
  }

  void _handleToogleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    favoritesStorage.saveMeal(widget.meal);

    final messanger = ScaffoldMessenger.of(context);
    messanger.hideCurrentSnackBar();
    messanger.showSnackBar(
      SnackBar(
        content: Text("piatto aggiunto o tolto"),
        duration: Duration(
          seconds: 2,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.meal.title),
        actions: [
          IconButton(
            onPressed: _handleToogleFavorite,
            icon: Icon(
              (isFavorite) ? Icons.star : Icons.star_border,
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Image.network(widget.meal.imageUrl),
          Container(
            padding: EdgeInsets.all(16),
            child: Text("Ingredients"),
          ),
          for (var ingredient in widget.meal.ingredients)
            Text(
              ingredient,
              style: TextStyle(fontSize: 20),
            ),
          Container(
            padding: EdgeInsets.all(16),
            child: Text("Steps"),
          ),
          for (var step in widget.meal.steps)
            Text(
              step,
              style: TextStyle(fontSize: 20),
            ),
        ]),
      ),
    );
  }
}
