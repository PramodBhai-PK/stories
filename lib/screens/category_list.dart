import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:kids_stories/helper/ad_manager.dart';
import 'package:kids_stories/models/category.dart';
import 'package:kids_stories/services/category_service.dart';
import 'package:kids_stories/widgets/home_post_categories.dart';


class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {

  List<Category> _categoryList = [];
  CategoryService _categoryService = CategoryService();

  bool isLoading = true;
  late BannerAd _bannerAd;
  bool _isBannerAdReady = false;

  @override
  void initState() {
    super.initState();
    _getAllCategories();
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

  _getAllCategories() async {
    var categories = await _categoryService.getCategories();
    var result = json.decode(categories.body);
   // print(categories.body);
    result['data'].forEach((data) {
      var model = Category();
      model.id = data["id"];
      model.name = data["name"];
      model.icon = data["icon"];
      setState(() {
        _categoryList.add(model);
        isLoading = false;
      });
    });
    //print(result);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Category List"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(40),
              bottomLeft: Radius.circular(40),

            ),
        ),
      ),
      body: isLoading ? Center(child: CircularProgressIndicator(backgroundColor: Colors.indigo,strokeWidth: 10,)) : Container(
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom:48.0),
              child: AllCategories(
                categoryList: _categoryList,
              ),
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
      )
    );
  }
}
