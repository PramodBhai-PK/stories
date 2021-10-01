import 'package:flutter/material.dart';
import 'package:kids_stories/models/story.dart';


import 'home_all_essay.dart';

class HomeAllEssays extends StatefulWidget {
  final List<Story>? recipeList;
  HomeAllEssays({this.recipeList});
  @override
  _HomeAllEssays createState() => _HomeAllEssays();
}

class _HomeAllEssays extends State<HomeAllEssays> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      //color: Colors.pinkAccent,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.recipeList!.length,
          itemBuilder: (context, index) {
            return 
            HomeAllEssay(recipe: this.widget.recipeList![index],);
          },
        ),
    );
  }
}
