enum Affordability {
  affordable,
  pricey,
  luxurious,
}

enum Complexity {
  simple,
  challenging,
  hard,
}

class Meal {
  final String id;
  final List<String> categories;
  final String title;
  final Affordability affordability;
  final Complexity complexity;
  final String imageUrl;
  final int duration;
  final List<String> ingredients;
  final List<String> steps;
  final bool isGlutenFree;
  final bool isVegan;
  final bool isVegetarian;
  final bool isLactoseFree;

  const Meal({
    required this.id,
    required this.categories,
    required this.title,
    required this.affordability,
    required this.complexity,
    required this.imageUrl,
    required this.duration,
    required this.ingredients,
    required this.steps,
    required this.isGlutenFree,
    required this.isVegan,
    required this.isVegetarian,
    required this.isLactoseFree,
  });

  factory Meal.fromJson(dynamic json) {
    return Meal(
        id: json["id"] as String,
        categories: List<String>.from(json["categories"] as List<dynamic>),
        title: json["title"] as String,
        affordability:
            _affordabilityFromString(json["affordability"] as String),
        complexity: _complexityFromString(json["complexity"] as String),
        imageUrl: json["imageUrl"] as String,
        duration: (json["duration"] as num).toInt(),
        ingredients: List<String>.from(json["ingredients"] as List<dynamic>),
        steps: List<String>.from(json["steps"] as List<dynamic>),
        isGlutenFree: json["isGlutenFree"] as bool,
        isVegan: json["isVegan"] as bool,
        isVegetarian: json["isVegetarian"] as bool,
        isLactoseFree: json["isLactoseFree"] as bool);
  }

  static Affordability _affordabilityFromString(String value) {
    return Affordability.values.firstWhere(
      (element) => element.name == value,
      orElse: () => Affordability.affordable,
    );
  }

  static Complexity _complexityFromString(String value) {
    return Complexity.values.firstWhere(
      (element) => element.name == value,
      orElse: () => Complexity.simple,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "categories": categories,
      "title": title,
      "affordability": affordability.name,
      "complexity": complexity.name,
      "imageUrl": imageUrl,
      "duration": duration,
      "ingredients": ingredients,
      "steps": steps,
      "isGlutenFree": isGlutenFree,
      "isVegan": isVegan,
      "isVegetarian": isVegetarian,
      "isLactoseFree": isLactoseFree
    };
  }
}
