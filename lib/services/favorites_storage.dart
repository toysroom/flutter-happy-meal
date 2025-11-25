import 'dart:convert';

import 'package:happy_meal/models/meal.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FavoritesStorage {
  Future<List<Meal>> loadMeals() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList("_favorites_key");
    
    if (favorites == null) {
      return [];
    }

    final meals = <Meal>[];
    for (final el in favorites) {
      final mealDecoded = jsonDecode(el) as Map<String, dynamic>;
      meals.add(Meal.fromJson(mealDecoded));
    }
    return meals;
  }

  saveMeal(Meal meal) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? favorites = prefs.getStringList("_favorites_key");

    if (favorites == null) {
      favorites = [];
    }

    // favorites ??= [];

    final meals = <Meal>[];
    if (favorites.isNotEmpty) {
      for (final el in favorites) {
        final mealDecoded = jsonDecode(el) as Map<String, dynamic>;
        meals.add(Meal.fromJson(mealDecoded));
      }
    }
    meals.add(meal);

    final payload = meals.map((meal) => jsonEncode(meal.toJson())).toList();
    prefs.setStringList("_favorites_key", payload);
  }

  removeMeal(Meal meal) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList("_favorites_key");

    final meals = <Meal>[];
    if (favorites != null) {
      for (final el in favorites) {
        final mealDecoded = jsonDecode(el) as Map<String, dynamic>;
        meals.add(Meal.fromJson(mealDecoded));
      }
      meals.removeWhere((element) => element.id == meal.id);
    }
    final payload = meals.map((meal) => jsonEncode(meal.toJson())).toList();
    prefs.setStringList("_favorites_key", payload);
  }


  Future<bool> getMeal(Meal meal) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList("_favorites_key");

    if (favorites == null) {
      return false;
    }

    final meals = <Meal>[];
    if (favorites.isNotEmpty) {
      for (final el in favorites) {
        final mealDecoded = jsonDecode(el) as Map<String, dynamic>;
        meals.add(Meal.fromJson(mealDecoded));
      }
    }

    return meals.any((element) => element.id == meal.id);
  }
}
