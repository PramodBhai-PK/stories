import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kids_stories/helper/constants.dart';
import 'package:kids_stories/models/story.dart';
import 'package:kids_stories/screens/story_detail.dart';
import 'package:http/http.dart' as http;

class HomeAllEssay extends StatefulWidget {
  final Story? recipe;
  HomeAllEssay({
    this.recipe,
  });
  @override
  _HomeAllEssay createState() => _HomeAllEssay();
}

class _HomeAllEssay extends State<HomeAllEssay> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      child: InkWell(
          onTap: () {
            Future<Story?> updateViews() async {
              final http.Response response = await http.post(
               Uri.parse( '${Constant.ViewsUrl}${widget.recipe!.id}'),
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
                          story: this.widget.recipe,
                        )));
          },
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Container(
                  height: 175,
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
                                image: NetworkImage(widget.recipe!.image!),)
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Text(
                this.widget.recipe!.name!,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              )
            ],
          )),
    );
  }
}
