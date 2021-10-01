import 'package:flutter/material.dart';
import 'package:kids_stories/models/story.dart';
import 'package:kids_stories/screens/story_detail.dart';


class StorySearch extends SearchDelegate<String?>{
  final List<Story>? stories;
  StorySearch({this.stories});

  @override
  List<Widget> buildActions(BuildContext context) {
   return [
     IconButton(icon: Icon(Icons.close), onPressed: (){
       query = "";
     })
   ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
      close(context, null);
    });
  }

  @override
  Widget buildResults(BuildContext context) {
    final recipeSearchList = query.isEmpty ? stories! : stories!.where((recipe){
      return recipe.name!.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return ListView.builder(
        itemCount: recipeSearchList.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>StoryDetail(story: recipeSearchList[index],)));
              },
              leading: Image.network(recipeSearchList[index].image!,height: 80,width: 80,fit: BoxFit.fill,),
              title: Text(recipeSearchList[index].name!),

            ),
          );
        });
    //throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final recipeSearchList = query.isEmpty ? stories! : stories!.where((recipe){
      return recipe.name!.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return ListView.builder(
        itemCount: recipeSearchList.length,
        itemBuilder: (context, index){
          return Padding(
            padding: const EdgeInsets.all(5.0),
            child: ListTile(
              onTap: (){
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (context)=>StoryDetail(story: recipeSearchList[index],)));
              },
              leading: Image.network(recipeSearchList[index].image!,height: 80,width: 80,fit: BoxFit.fill,),
              title: Text(recipeSearchList[index].name!),

            ),
          );
        });
  }

}