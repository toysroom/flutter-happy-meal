import 'package:flutter/material.dart';
import 'package:happy_meal/pages/categories.dart';
import 'package:happy_meal/pages/favorites.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedPageIndex = 0;

  void onSelectPage(int index) {
    setState(() {
      selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesPage();
    String activePageTitle = 'Categorie';

    if (selectedPageIndex == 1) {
      activePage = FavoritesPage();
      activePageTitle = 'Preferiti';
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedPageIndex,
        onTap: onSelectPage,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: "Categorie",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Preferiti",
          ),
        ],
      ),
    );
  }
}
