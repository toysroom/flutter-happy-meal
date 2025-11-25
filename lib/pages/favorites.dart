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


  void _removeMeal(Meal meal) {
    favoritesStorage.removeMeal(meal);
    loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: favoritesMeals.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(favoritesMeals[index].title),
          subtitle: Text('Duration: ${favoritesMeals[index].duration.toString()} min'),
          leading: Image.network(favoritesMeals[index].imageUrl, width: 100, height: 100, fit: BoxFit.contain,),
          trailing: IconButton(onPressed: () =>_removeMeal(favoritesMeals[index]), icon: Icon(Icons.delete)),
        );
      },
    );
  }
}
