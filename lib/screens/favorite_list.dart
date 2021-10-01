import 'package:flutter/material.dart';
import 'package:kids_stories/helper/db_helper.dart';
import 'package:kids_stories/models/favorite.dart';
import 'package:kids_stories/widgets/all_favarote.dart';

class FavoriteList extends StatefulWidget {
  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  List<Favorite>? _favoriteList = [];

  bool isLoading = true;

  @override
  void initState() {
    DBHelper.getAll().then((value) {
      setState(() {
        _favoriteList = value!;
        isLoading = false;
        //print(_favoriteList);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(30),
                  bottomLeft: Radius.circular(30))),
          title: Text("Favorite List"),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(
                backgroundColor: Colors.indigo,
                strokeWidth: 10,
              ))
            : Container(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 48.0),
                  child: AllFavoriteHome(
                    favoriteList: _favoriteList,
                    //categoryList: _categoryList,
                  ),
                ),
              ));
  }
}
