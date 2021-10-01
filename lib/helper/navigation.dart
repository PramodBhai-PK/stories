import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kids_stories/screens/Settings/settings.dart';
import 'package:kids_stories/screens/category_list.dart';
import 'package:kids_stories/screens/favorite_list.dart';
import 'package:kids_stories/screens/submit_story.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../screens/Auth/login.dart';

class NavigationDrawer extends StatefulWidget {
  final int? userId;
  NavigationDrawer({this.userId});
  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  SharedPreferences? _prefs;
  String _loginLogoutMenuText = "Log In";
  IconData _loginLogoutIcon = Icons.login;

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

  @override
  void initState() {
    _isLoggedIn();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
      children: [
        UserAccountsDrawerHeader(
          currentAccountPicture: Image.asset('assets/kids.png'),
          accountName: Text(
            "Kid's Stories",
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),
          accountEmail: Text('A way of Learning'),
        ),
        _loginLogoutMenuText == 'Log In'
            ? Container()
            : InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    size: 20,
                    color: Colors.blue,
                  ),
                  title: Text(
                    'My Profile',
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
          onTap: () => Navigator.of(context).pop(),
          child: ListTile(
            leading: Icon(
              Icons.home,
              size: 20,
              color: Colors.blue,
            ),
            title: Text(
              'Home',
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
                MaterialPageRoute(builder: (context) => CategoryList()));
            //
          },
          child: ListTile(
            leading: Icon(
              Icons.category,
              size: 20,
              color: Colors.blue,
            ),
            title: Text(
              'Categories',
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
                MaterialPageRoute(builder: (context) => FavoriteList()));
            //
          },
          child: ListTile(
            leading: Icon(Icons.favorite, size: 25, color: Colors.pink),
            title: Text(
              'Favorite',
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
                MaterialPageRoute(builder: (context) => SubmitStory()));
          },
          child: ListTile(
            leading: Icon(
              FontAwesomeIcons.font,
              size: 20,
              color: Colors.blue,
            ),
            title: Text(
              'Your Story',
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
                MaterialPageRoute(builder: (context) => SettingPage()));
          },
          child: ListTile(
            leading: Icon(
              Icons.star,
              size: 20,
              color: Colors.blue,
            ),
            title: Text(
              'Settings',
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
          onTap: () async{
            Navigator.pop(context);
            _prefs =
                await SharedPreferences.getInstance();
            _prefs?.setInt('userId', 0);
            _prefs?.setString('userName', '');
            _prefs?.setString('userEmail', '');
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => LoginPage()));
            setState(() {

            });
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
        SizedBox(
          height: 50,
        ),
      ],
    ));
  }
}
