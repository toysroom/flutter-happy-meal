import 'package:flutter/material.dart';
import 'package:happy_meal/models/meal.dart';
import 'package:happy_meal/services/favorites_storage.dart';

class FavoritesPage extends StatefulWidget {
  @override
  State<FavoritesPage> createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  late FavoritesStorage favoritesStorage;
  List<Meal> favoritesMeals = [];

  @override
  void initState() {
    super.initState();
    favoritesStorage = FavoritesStorage();
    loadFavorites();
  }

  loadFavorites() async {
    final temp = await favoritesStorage.loadMeals();

    setState(() {
      favoritesMeals = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favoritesMeals.length,
      itemBuilder: (context, index) {
        return Text(favoritesMeals[index].title);
      },
    );
  }
}
