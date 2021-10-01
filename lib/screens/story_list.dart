import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kids_stories/helper/ad_manager.dart';
import 'package:kids_stories/helper/constants.dart';
import 'package:kids_stories/models/story.dart';
import 'package:kids_stories/screens/story_detail.dart';
import 'package:kids_stories/services/story_service.dart';
import 'package:http/http.dart' as http;

class StoryList extends StatefulWidget {
  @override
  _StoryListState createState() => _StoryListState();
}

class _StoryListState extends State<StoryList> {
  List<Story> _popularList = [];
  StoryService _storyService = StoryService();
  bool isLoading = true;
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;


  _getAllStories() async {
    var allRecipes = await _storyService.getAllStories();
    var result = json.decode(allRecipes.body);
    result['data'].forEach((data) {
      var model = Story();
      model.id = data['id'];
      model.name = data['name'];
      model.details = data['details'];
      model.language = data['Language'];
      model.views = data['views'].toString();
      model.image = data['image'];
      model.date = data['created'].toString();
      model.categoryName = data['categoryName'];
      model.author = data['Author'];
      model.authorPic = data['authorPic'];
      setState(() {
        _popularList.add(model);
        isLoading = false;
      });
    });
  }

  @override
  void initState() {
    _bannerAd = BannerAd(
      adUnitId: AdManager.bannerAdUnitId,
      request: AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (_) {
          setState(() {
            _isBannerAdReady = true;
          });
        },
        onAdFailedToLoad: (ad, err) {
          print('Failed to load a banner ad: ${err.message}');
          _isBannerAdReady = false;
          ad.dispose();
        },
      ),
    );
    _bannerAd.load();
    _getAllStories();
    super.initState();
  }
  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Popular Stories'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        )),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: Container(
                child: isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.deepPurple,
                          strokeWidth: 5,
                        ),
                      )
                    : ListView.builder(
                        itemCount: _popularList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Future<Story?> updateViews() async {
                                final http.Response response = await http.post(
                                  Uri.parse(
                                      '${Constant.ViewsUrl}${_popularList[index].id}'),
                                );
                                if (response.statusCode == 200) {
                                  print(response);
                                } else {
                                  throw Exception('Failed to update views.');
                                }
                              }

                              updateViews();
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return StoryDetail(
                                  story: _popularList[index],
                                );
                              }));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(20),
                                        child: Image.network(
                                          _popularList[index].image!,
                                          fit: BoxFit.fill,
                                          width: MediaQuery.of(context).size.width,
                                          height: 180,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 180,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Colors.black54,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    height: 180,
                                    child: Center(
                                      child: Text(
                                        _popularList[index].name!,
                                        style: TextStyle(
                                            fontSize: 25,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      )),
          ),
          if (_isBannerAdReady)
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: _bannerAd.size.width.toDouble(),
                height: _bannerAd.size.height.toDouble(),
                child: AdWidget(ad: _bannerAd),
              ),
            ),
        ],
      ),
    );
  }
}
