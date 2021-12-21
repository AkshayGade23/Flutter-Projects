import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatefulWidget {
  final List<Meal> availablemeals;
  static const String routeName = '/category_meals';
  CategoryMealsScreen(this.availablemeals);
  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String cateTitle;
  List<Meal> displayedMeal;
  var _loaded = false;

  @override
  void didChangeDependencies() {
    if (!_loaded) {
      final routeArgus =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      cateTitle = routeArgus['title'];
      final cateId = routeArgus['id'];
      displayedMeal = widget.availablemeals.where((meal) {
        return meal.categories.contains(cateId);
      }).toList();
    }
  }

  void _removeMeal(mealId) {
    setState(() {
      displayedMeal.removeWhere((meal) => meal.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          cateTitle,
        ),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
            id: displayedMeal[index].id,
            title: displayedMeal[index].title,
            imageUrl: displayedMeal[index].imageUrl,
            duration: displayedMeal[index].duration,
            complexity: displayedMeal[index].complexity,
            affordability: displayedMeal[index].affordability,
          );
        },
        itemCount: displayedMeal.length,
      ),
    );
  }
}
