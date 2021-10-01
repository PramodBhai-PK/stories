import 'package:flutter/material.dart';
import 'package:kids_stories/models/story.dart';


import 'recipe_of_day.dart';

class RecipesOfDay extends StatefulWidget {
  final List<Story>? dayRecipeList;
  RecipesOfDay({this.dayRecipeList});
  @override
  _RecipesOfDay createState() => _RecipesOfDay();
}

class _RecipesOfDay extends State<RecipesOfDay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.dayRecipeList!.length,
        itemBuilder: (context, index) {
          return
            Center(
              child: RecipeOfDay(
               story: this.widget.dayRecipeList![index],
              ),
            );
        },
      ),
    );
  }
}
