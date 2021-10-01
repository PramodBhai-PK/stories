import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:kids_stories/models/user.dart';
import 'package:kids_stories/screens/home.dart';
import 'package:kids_stories/services/user_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../post_comment.dart';
import 'register.dart';

class LoginPage extends StatefulWidget {
  final int? id;
  final int? userid;
  LoginPage({this.id, this.userid});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final email = TextEditingController();
  final password = TextEditingController();

  _setSharedPrefs() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    _prefs.setInt('userId', 0);
    _prefs.setString('userName', '');
    _prefs.setString('userEmail', '');
  }

  _login(BuildContext context, User user) async {
    var _userService = UserService();
    var registeredUser = await _userService.login(user);
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
            builder: (context) => PostComment(id: this.widget.id),
          ),
        );
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomePage()));
      }
    } else if (result['result'] == false) {
      return {
        // Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginPage())),
        _showDialog()
      };
    }
  }

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.pink,
          child: AlertDialog(
            title: new Text("Login Failed"),
            content: new Text('Credential do not match with our database'),
            actions: <Widget>[
              Row(
                children: [
                  TextButton(
                    child: new Text("Retry"),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                  ),
                  TextButton(
                    child: new Text("Register"),
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignUp()));
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    _setSharedPrefs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
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
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Center(
                  child: Column(
                    children: [
                      SvgPicture.asset('assets/login.svg',
                          height: size.height * 0.35,
                          semanticsLabel: 'A red up arrow'),
                      Text('sign in to unlock many features')
                    ],
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.blue.withOpacity(0.4),
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
                            hintText: 'Enter your email',
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
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  color: Colors.blue.withOpacity(0.4),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: Icon(Icons.remove_red_eye),
                      ),
                      Expanded(
                        flex: 5,
                        child: TextFormField(
                          controller: password,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                          decoration: InputDecoration(
                              hintText: 'Enter your password',
                              border: InputBorder.none,
                              fillColor: Colors.white
                              // border: OutlineInputBorder(
                              //   borderRadius: BorderRadius.circular(15.0),
                              // ),
                              ),
                          obscureText: true,
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
                        user.email = email.text;
                        user.password = password.text;
                        _login(context, user);
                        setState(() {
                          isLoading = true;
                        });
                      },
                      child: Text(
                        "LOGIN",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    )
                  : CircularProgressIndicator(),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an account ?"),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUp()));
                        },
                        child: Text(" SignUp"))
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
