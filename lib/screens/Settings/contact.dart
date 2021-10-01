import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatefulWidget {
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _msgController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    _msgController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Contact Us",style: TextStyle(
        ),),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(40),
              bottomLeft: Radius.circular(40),

            )
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top:8.0, left: 28, right: 28),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Name",style: TextStyle(fontSize: 20,),),
                    ),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Enter Your Name',
                        hintText: 'Name',
                        contentPadding: EdgeInsets.all(15.0),
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top:8.0, left: 28, right: 28),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Your Message",style: TextStyle(fontSize: 20,),),
                    ),
                    TextField(
                      minLines: 5,
                      maxLines: 15,
                      controller: _msgController,
                      decoration: InputDecoration(
                        labelText: 'Your Message',
                        hintText: 'Enter your message',
                        contentPadding: EdgeInsets.all(15.0),
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(width: 5,),
                    ElevatedButton(
                      onPressed: (){
                        _launchURL('pkyadav4488@gmail.com',_nameController.text, _msgController.text);
                      },
                      child: Text("Send",style: TextStyle(fontSize: 25,color: Colors.white),),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  _launchURL(String email, String name, String msg) async {
    var url = 'mailto:$email?subject=$name&body=$msg';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
