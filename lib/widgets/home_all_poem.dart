import 'package:flutter/material.dart';
import 'package:kids_stories/models/story.dart';
import 'package:kids_stories/screens/story_detail.dart';

class HomeAllPoem extends StatefulWidget {
  final Story? story;
  HomeAllPoem({
    this.story,
  });
  @override
  _HomeAllPoem createState() => _HomeAllPoem();
}

class _HomeAllPoem extends State<HomeAllPoem> {
  double rating = 5.0;
  int starCount = 5;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
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
                child: Container(
                  height: 165,
                  child: Stack(
                    children: [
                      Card(
                        elevation: 9,
                        shadowColor: Colors.red,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: new ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: FadeInImage(
                              fit: BoxFit.fill,
                              height: 150,
                              width: 200,
                              placeholder: AssetImage('assets/kids.png'),
                              image: NetworkImage(widget.story!.image!),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(
                  this.widget.story!.name!,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              )
            ],
          )),
    );
  }
}
