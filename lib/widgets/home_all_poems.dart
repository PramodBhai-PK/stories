import 'package:flutter/material.dart';
import 'package:kids_stories/models/story.dart';

import 'home_all_poem.dart';

class HomeAllPoems extends StatefulWidget {
  final List<Story>? drinkRecipeList;
  HomeAllPoems({this.drinkRecipeList});
  @override
  _HomeAllPoems createState() => _HomeAllPoems();
}

class _HomeAllPoems extends State<HomeAllPoems> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 230,
      //color: Colors.pinkAccent,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.drinkRecipeList!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 1.0),
            child: HomeAllPoem(
              story: this.widget.drinkRecipeList![index],
            ),
          );
        },
      ),
    );
  }
}
