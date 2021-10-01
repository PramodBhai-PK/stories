import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kids_stories/models/about.dart';
import 'package:kids_stories/services/about_us_service.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUs extends StatefulWidget {
  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  bool isLoading = true;
  AboutUsService _aboutUsService = AboutUsService();
  List<AboutUsData> _aboutData = [];

  @override
  void initState() {
    super.initState();
    _getAboutUsData();
  }

  _getAboutUsData() async {
    var categories = await _aboutUsService.getAboutUs();
    var result = json.decode(categories.body);
    print(categories.body);
    result['data'].forEach((data) {
      var model = AboutUsData();
      model.id = data["id"];
      model.name = data["name"];
      model.mobile = data["mobile"].toString();
      model.email = data["email"].toString();
      model.photo = data["photo"];
      model.website = data["website"].toString();
      model.facebook = data["facebook"].toString();
      model.instagram = data["instagram"].toString();
      model.youtube = data["youtube"].toString();
      model.description = data['description'];
      setState(() {
        _aboutData.add(model);
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
        title: Text("About Us"),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(40),
              bottomLeft: Radius.circular(40),

            )
        ),
      ),
      body: Container(
          //height: 250,
          alignment: Alignment.center,
          child: isLoading
              ? CircularProgressIndicator(
            backgroundColor: Colors.deepPurple,
            strokeWidth: 10,
          )
              : ListView(
                  children: [
                    AboutUsPage(
                      aboutData: _aboutData,
                    )
                  ],
                )),
    );
  }
}

class AboutUsPage extends StatefulWidget {
  final List<AboutUsData>? aboutData;
  AboutUsPage({this.aboutData});
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        itemCount: widget.aboutData!.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: FadeInImage(
                      height: MediaQuery.of(context).size.height*0.20,
                      fit: BoxFit.fill,
                      width: MediaQuery.of(context).size.width,
                      placeholder: AssetImage('assets/kids.png'),
                      image: NetworkImage(widget.aboutData![index].photo!,)),
                ),
                Card(
                  shadowColor: Colors.pink,
                  elevation: 10,
                  child: ListTile(
                    title: Center(
                      child: Text(widget.aboutData![index].name!,
                        style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Card(
                  shadowColor: Colors.pink,
                  elevation: 10,
                  child: ListTile(
                    title: Text(widget.aboutData![index].website!),
                    leading: FaIcon(FontAwesomeIcons.chrome,color: Colors.deepPurple,size: 35,),
                    onTap: (){
                      _launchURL(widget.aboutData![index].website!);
                    },
                  ),
                ),
                Card(
                  shadowColor: Colors.pink,
                  elevation: 10,
                  child: ListTile(
                    title: Text(widget.aboutData![index].facebook!),
                    leading: FaIcon(FontAwesomeIcons.facebook,color: Colors.blue,size: 35,),
                    onTap: (){
                      _launchURL(widget.aboutData![index].facebook!);
                    },
                  ),
                ),
                Card(
                  shadowColor: Colors.pink,
                  elevation: 10,
                  child: ListTile(
                    title: Text(widget.aboutData![index].instagram!),
                    leading: FaIcon(FontAwesomeIcons.instagram,color: Colors.pink,size: 35,),
                    onTap: (){
                      _launchURL(widget.aboutData![index].instagram!);
                    },
                  ),
                ),
                Card(
                  shadowColor: Colors.pink,
                  elevation: 10,
                  child: ListTile(
                    title: Text(widget.aboutData![index].youtube!),
                    leading: FaIcon(FontAwesomeIcons.youtube,color: Colors.red,size: 35,),
                    onTap: () => {
                      _launchURL(widget.aboutData![index].youtube!)
                    },
                  ),
                ),
                Card(
                  shadowColor: Colors.pink,
                  elevation: 10,
                  child: ListTile(
                    title: Text(widget.aboutData![index].email!),
                    leading: FaIcon(FontAwesomeIcons.mailBulk,color: Colors.pink,size: 35,),
                    onTap: (){
                      _launchMail(widget.aboutData![index].email);
                    },
                  ),
                ),
                Card(
                  shadowColor: Colors.pink,
                  elevation: 10,
                  child: ListTile(
                    title: Text(widget.aboutData![index].mobile!),
                    leading: FaIcon(FontAwesomeIcons.mobile,color: Colors.black45,size: 35,),
                    onTap: (){
                      _launchMobile(widget.aboutData![index].mobile);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 100),
                  child: Column(
                    children: [
                      Text("About Us", style: TextStyle(fontSize: 21,fontWeight: FontWeight.bold),),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Html(data: widget.aboutData![index].description!,
                          style: {
                          "p" : Style(
                          fontSize: FontSize.xLarge
                          ),
                          },
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchMail(String? mail) async {
    var url = 'mailto:$mail';
  if (await canLaunch(url)) {
  await launch(url);
  } else {
  throw 'Could not launch $url';
  }
}
  _launchMobile(String? mobile) async {
    var url= 'tel:$mobile';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
