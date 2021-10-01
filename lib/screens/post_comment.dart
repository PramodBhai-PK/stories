import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kids_stories/models/comment.dart';
import 'package:kids_stories/screens/home.dart';
import 'package:kids_stories/services/comment_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Auth/login.dart';

class PostComment extends StatefulWidget {
  final int? id;
  PostComment({this.id});
  @override
  _PostCommentState createState() => _PostCommentState();
}

class _PostCommentState extends State<PostComment> {
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final comment = TextEditingController();
  // AdmobInterstitial interstitialAd;

  @override
  void dispose() {
    //interstitialAd.dispose();
    super.dispose();
  }

  _postComment(BuildContext context, Comment comment) async {
    var _commentService = CommentService();
    var postComment = await _commentService.postComment(comment);
    var response = json.decode(postComment.body);
    if (response['result'] == true) {
      // if (await interstitialAd.isLoaded) {
      //   interstitialAd.show();
      // }
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomePage()));
    }
  }

  SharedPreferences? _prefs;
  int? _userId;

  _isLoggedIn() async {
    _prefs = await SharedPreferences.getInstance();
    int? userId = _prefs?.getInt('userId');
    if (userId == 0) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      setState(() {
        _userId = userId;
      });
    }
  }

  @override
  void initState() {
    _isLoggedIn();
    // interstitialAd = AdmobInterstitial(
    //   adUnitId: getInterstitialAdUnitId(),
    //   listener: (AdmobAdEvent event, Map<String, dynamic> args) {
    //     if (event == AdmobAdEvent.closed) interstitialAd.load();
    //   },
    // );
    // interstitialAd.load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Comment'),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(40),
              bottomLeft: Radius.circular(40),

            )
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        "Write your Comment",
                        style: TextStyle(
                            fontSize: 25,

                            fontWeight: FontWeight.bold),
                      ),
                      SvgPicture.asset('assets/post.svg',
                          height: size.height * 0.35,
                          semanticsLabel: 'A red up arrow'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: comment,
                  maxLines: 5,
                  //cursorHeight: 25.0,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    hintText: 'Comment',
                    //  border: InputBorder.none,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                  ),
                ),
              ),
              !isLoading
                  ? ElevatedButton(
                      onPressed: () {
                        var comments = Comment();
                        comments.comment = comment.text;
                        comments.story_id = widget.id;
                        comments.user_id = _userId;
                        // comments.name = '';
                        _postComment(context, comments);
                        setState(() {
                          isLoading = true;
                        });
                      },
                      child: Text(
                        "Post Comment",
                        style: TextStyle(fontSize: 20, color: Colors.white,),
                      ),
                    )
                  : CircularProgressIndicator(),
              // Container(
              //   alignment: Alignment.bottomCenter,
              //   child: AdmobBanner(
              //     adUnitId: getBannerAdUnitId(),
              //     adSize: AdmobBannerSize.MEDIUM_RECTANGLE,
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
