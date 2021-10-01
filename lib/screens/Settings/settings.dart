import 'package:flutter/material.dart';
import 'package:kids_stories/helper/theme_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../Auth/login.dart';
import 'about_us.dart';
import 'contact.dart';

class SettingPage extends StatefulWidget {
  const SettingPage({Key? key}) : super(key: key);

  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isSwitched = false;
  String textValue = "Dark Mode";
  SharedPreferences? _prefs;
  String _loginLogoutMenuText = "Log In";
  IconData _loginLogoutIcon = Icons.exit_to_app;

  _isLoggedIn() async {
    _prefs = await SharedPreferences.getInstance();
    int? userId = _prefs?.getInt('userId');
    if (userId == 0) {
      setState(() {
        _loginLogoutMenuText = "Log In";
        _loginLogoutIcon = Icons.person;
      });
    } else {
      setState(() {
        _loginLogoutMenuText = "Log Out";
        _loginLogoutIcon = Icons.exit_to_app;
      });
    }
  }

  void toggleSwitch(bool value) {
    if (isSwitched == false) {
      setState(() {
        isSwitched = true;
        ThemeService().switchTheme();
        textValue = "Light Mode";
      });
    } else {
      setState(() {
        isSwitched = false;
        ThemeService().switchTheme();
        textValue = "Dark Mode";
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _isLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Settings",
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(textValue,
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold)),
                  Switch(
                    value: isSwitched,
                    onChanged: toggleSwitch,
                    activeColor: Colors.blue,
                    activeTrackColor: Colors.yellow,
                    inactiveThumbColor: Colors.redAccent,
                    inactiveTrackColor: Colors.orange,
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutUs()));
              },
              child: ListTile(
                leading: Icon(
                  Icons.info,
                  size: 20,
                  color: Colors.blue,
                ),
                title: Text(
                  'About Us',
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  size: 20,
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.black54,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactUs()));
              },
              child: ListTile(
                leading: Icon(
                  Icons.contact_mail,
                  size: 20,
                  color: Colors.blue,
                ),
                title: Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  size: 20,
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.black54,
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pop();
                _launchUrl();
              },
              child: ListTile(
                leading: Icon(
                  Icons.star,
                  size: 20,
                  color: Colors.blue,
                ),
                title: Text(
                  'Rate Us',
                  style: TextStyle(fontSize: 20),
                ),
                trailing: Icon(
                  Icons.arrow_forward,
                  size: 20,
                ),
              ),
            ),
            Divider(
              thickness: 1,
              color: Colors.black54,
            ),
            InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: ListTile(
                  title: Text(
                    _loginLogoutMenuText,
                    style: TextStyle(fontSize: 20),
                  ),
                  leading: Icon(
                    _loginLogoutIcon,
                    size: 20,
                    color: Colors.blue,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  _launchUrl() async {
    var url =
        'https://play.google.com/store/apps/details?id=com.dizitaltrends.kids_stories';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
