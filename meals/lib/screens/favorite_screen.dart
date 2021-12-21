import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class FavoritesScreen extends StatefulWidget {
  final List<Meal> favoriteMeals;
  var mealitem;
  FavoritesScreen(this.favoriteMeals);

  Widget mealHandler(index, Function fff) {
    mealitem = MealItem(
      id: favoriteMeals[index].id,
      title: favoriteMeals[index].title,
      imageUrl: favoriteMeals[index].imageUrl,
      duration: favoriteMeals[index].duration,
      complexity: favoriteMeals[index].complexity,
      affordability: favoriteMeals[index].affordability,
      fff: fff,
    );
    return mealitem;
  }

  // static void buildervvv(Function function) {}
  @override
  _FavoritesScreenState createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  void favoriteScreenReBuilder() {
    //
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (widget.favoriteMeals.isEmpty) {
      return Center(
        child: Text('you have no favorites yet - try adding some.'),
      );
    } else {
      return ListView.builder(
        itemBuilder: (ctx, index) {
          return widget.mealHandler(index, favoriteScreenReBuilder);
        },
        itemCount: widget.favoriteMeals.length,
      );
    }
  }
}
