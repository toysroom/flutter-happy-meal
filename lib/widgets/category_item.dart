import 'package:flutter/material.dart';
import 'package:happy_meal/models/category.dart';
import 'package:happy_meal/pages/meals.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  CategoryItem(this.category);

  void _onCategoryItemPressed(BuildContext context) {
    // final List<Meal> filteredMeals = dummyMeals.where( (meal) => meal.categories.contains(category.id) ).toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsPage(
          category: category,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _onCategoryItemPressed(context),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: category.color,
        ),
        child: Text(
          category.title,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
