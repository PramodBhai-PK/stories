import 'package:flutter/material.dart';
import 'package:kids_stories/models/story.dart';
import 'package:kids_stories/screens/story_detail.dart';

class RecipeOfDay extends StatefulWidget {
  final Story? story;
  RecipeOfDay({
    this.story,
  });

  @override
  _RecipeOfDayState createState() => _RecipeOfDayState();
}

class _RecipeOfDayState extends State<RecipeOfDay> {
 
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 280,
      child: InkWell(
          onTap: () {
            // ignore: missing_return
            // Future<Story> updateViews() async {
            //   final http.Response response = await http.post(
            //     '$uRL${widget.story!.id}',
            //   );
            //   if (response.statusCode == 200) {
            //     print(response);
            //   } else {
            //     throw Exception('Failed to update views.');
            //   }
            // }
            // updateViews();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StoryDetail(
                          story: this.widget.story,
                        )));
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Center(
                  child: Container(
                    height: 225,
                    child: Card(
                      elevation: 9,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: new ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            widget.story!.image!,
                            fit: BoxFit.fill,
                            height: 370,
                            width: 350,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                this.widget.story!.name!,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          ),
          ),
    );
  }
}
