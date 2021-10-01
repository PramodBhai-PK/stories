import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kids_stories/helper/constants.dart';
import 'package:kids_stories/models/story.dart';
import 'package:kids_stories/screens/story_detail.dart';
import 'package:http/http.dart' as http;

class StoryByCategory extends StatefulWidget {
  final Story story;
  StoryByCategory(this.story);
  @override
  _StoryByCategoryState createState() => _StoryByCategoryState();
}

class _StoryByCategoryState extends State<StoryByCategory> {
  double rating = 5.0;
  int starCount = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {
          Future<Story?> updateViews() async {
            final http.Response response = await http.post(
              Uri.parse('${Constant.ViewsUrl}${widget.story.id}')
            );
            if (response.statusCode == 200) {
              print(response);
            } else {
              throw Exception('Failed to update views.');
            }
          }

          updateViews();
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => StoryDetail(
                        story: this.widget.story,
                      )));
        },
        child: Column(
          children: [
            Container(
              height: 150,
              width: 400,
              child: Card(
                elevation: 9,
                shadowColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: new ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: FadeInImage.assetNetwork(
                      fit: BoxFit.fill,
                        height: 250,
                        width: MediaQuery.of(context).size.width / 2,
                        placeholder: 'assets/kids.png',
                        image: widget.story.image!)
                    // Image.network(
                    //   widget.story.image!,
                    //   fit: BoxFit.fill,
                    //   // height: 250,
                    //   width: MediaQuery.of(context).size.width / 2,
                    // ),
                  ),
                ),
              ),
            ),
            Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  this.widget.story.name!,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold,),
                ))
          ],
        ),
      ),
    );
  }
}
