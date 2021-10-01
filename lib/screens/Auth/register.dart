import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:kids_stories/models/user.dart';
import 'package:kids_stories/screens/home.dart';
import 'package:kids_stories/screens/post_comment.dart';
import 'package:kids_stories/services/user_services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login.dart';

class SignUp extends StatefulWidget {
  final int? id;
  SignUp({this.id});
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isLoading = false;
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey<ScaffoldMessengerState>();
  final name = TextEditingController();

  final email = TextEditingController();

  final password = TextEditingController();

  _register(BuildContext context, User user) async {
    var _userService = UserService();
    var registeredUser = await _userService.createUser(user);
    var result = json.decode(registeredUser.body);
    if (result['result'] == true) {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setInt('userId', result['user']['id']);
      _prefs.setString('userName', result['user']['name']);
      _prefs.setString('userEmail', result['user']['email']);

      if (this.widget.id != null) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PostComment(
                      id: this.widget.id,
                    )));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    } else {
      _showSnackMessage(Text(
        'Failed to register the user!',
        style: TextStyle(color: Colors.red),
      ));
    }
  }

  _showSnackMessage(message) {
    var snackBar = SnackBar(
      content: message,
    );
    _scaffoldKey.currentState?.showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('SignUp'),
        actions: [
          IconButton(
              icon: Icon(Icons.home),
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomePage()));
              })
        ],
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
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Center(
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/register.svg',
                          height: size.height * 0.35,
                          semanticsLabel: 'A red up arrow'),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 1),
                child: Card(
                  color: Colors.blue.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Icon(Icons.person),
                      ),
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          controller: name,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'User Name',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 1),
                child: Card(
                  color: Colors.blue.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Icon(Icons.email),
                      ),
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          controller: email,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Email',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 1),
                child: Card(
                  color: Colors.blue.withOpacity(0.4),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Icon(Icons.star),
                      ),
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          controller: password,
                          obscureText: true,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          decoration: InputDecoration(
                            hintText: 'Password',
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              !isLoading
                  ? ElevatedButton(
            
                      onPressed: () {
                        var user = User();
                        user.name = name.text;
                        user.email = email.text;
                        user.password = password.text;
                        _register(context, user);
                        setState(() {
                          isLoading = true;
                        });
                      },
                      child: Text(
                        "SIGNUP",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )
                  : CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Already have an account ?"),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                        child: Text(" Login")),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
