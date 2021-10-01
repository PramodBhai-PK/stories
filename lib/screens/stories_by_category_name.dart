import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kids_stories/helper/ad_manager.dart';
import 'package:kids_stories/models/story.dart';
import 'package:kids_stories/services/story_service.dart';
import 'package:kids_stories/widgets/story_by_category.dart';

class StoriesByCategoryName extends StatefulWidget {
  final String? name;
  final String? icon;
  final int? id;
  StoriesByCategoryName({this.icon, this.id, this.name});
  @override
  _StoriesByCategoryNameState createState() => _StoriesByCategoryNameState();
}

class _StoriesByCategoryNameState extends State<StoriesByCategoryName> {
  StoryService _storyService = StoryService();
  List<Story> _storyListByCategory = [];
  bool isLoading = true;
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    super.initState();
    _getStoriesByCategory();
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
  }
  @override
  void dispose() {
    _bannerAd.dispose();
    super.dispose();
  }

  _getStoriesByCategory() async {
    var products = await _storyService.getStoriesByCategoryId(widget.id);
    var _list = json.decode(products.body);
    List<Story> results = [];
    _list["data"].forEach((data) {
      var model = Story();
      model.id = data["id"];
      model.name = data["name"];
      model.image = data["image"];
      model.views = data["views"].toString();
      model.details = data["details"];
      model.date = data['created'].toString();
      model.categoryName = data['categoryName'];
      model.author = data['Author'];
      model.authorPic = data['authorPic'];
      results.add(model);
    });
    setState(() {
      _storyListByCategory = results;
      isLoading = false;
    });
  }

  Widget getGridView() {
    if (_storyListByCategory.length > 0) {
      return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: _storyListByCategory.length,
        itemBuilder: (context, index) {
          return StoryByCategory(
            this._storyListByCategory[index],
          );
        },
      );
    } else
      return Container(
        height: MediaQuery.of(context).size.height,
        child: Image.asset(
          'assets/kidscrying.png',
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            this.widget.name!,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(40),
            bottomLeft: Radius.circular(40),
          )),
        ),
        body: Container(
          child: Center(
              child: isLoading
                  ? CircularProgressIndicator(
                      backgroundColor: Colors.deepPurpleAccent,
                      strokeWidth: 10,
                    )
                  : Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 50),
                        child: getGridView(),
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
                  )),
        ));
  }
}
