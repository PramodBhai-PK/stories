import 'package:flutter/material.dart';
import 'package:kids_stories/models/favorite.dart';
import 'package:kids_stories/models/story.dart';
import 'package:kids_stories/screens/story_detail.dart';

class AllFavoriteHome extends StatefulWidget {
  final List<Favorite>? favoriteList;
  AllFavoriteHome({required this.favoriteList});
  @override
  _AllFavoriteHomeState createState() => _AllFavoriteHomeState();
}

class _AllFavoriteHomeState extends State<AllFavoriteHome> {
  @override
  void initState() {
    print(widget.favoriteList!.length);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.favoriteList!.length > 0
        ? Container(
            child: ListView.builder(
              // scrollDirection: Axis.horizontal,
              itemCount: widget.favoriteList!.length,
              itemBuilder: (context, index) {
                Story myStory = Story();
                myStory.id = this.widget.favoriteList![index].storyId;
                myStory.name = this.widget.favoriteList![index].title;
                myStory.details = this.widget.favoriteList![index].details!;
                myStory.author = this.widget.favoriteList![index].author;
                myStory.date = this.widget.favoriteList![index].date;
                myStory.image = this.widget.favoriteList![index].image;
                myStory.views = '**';
                myStory.categoryName = '';
                return AllFavorite(story: myStory);
              },
            ),
          )
        : Image.asset('assets/no-food.png');
  }
}

class AllFavorite extends StatefulWidget {
  final Story? story;
  AllFavorite({this.story});
  @override
  _AllFavoriteState createState() => _AllFavoriteState();
}

class _AllFavoriteState extends State<AllFavorite> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 300,
      width: MediaQuery.of(context).size.width,
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StoryDetail(
                          story: widget.story,
                        )));
          },
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Card(
                      elevation: 2,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage(
                                fit: BoxFit.fill,
                                height: MediaQuery.of(context).size.width / 2.5,
                                width: MediaQuery.of(context).size.width,
                                placeholder: AssetImage('assets/cook.png'),
                                image: NetworkImage(widget.story!.image!))),
                      ),
                    ),
                  ),
                  Text(
                    widget.story!.name!,
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
