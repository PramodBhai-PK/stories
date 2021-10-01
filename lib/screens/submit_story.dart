import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kids_stories/models/category.dart';
import 'package:kids_stories/screens/home.dart';
import 'package:kids_stories/services/category_service.dart';
import 'package:http/http.dart' as http;

class SubmitStory extends StatefulWidget {
  @override
  _SubmitStoryState createState() => _SubmitStoryState();
}

class _SubmitStoryState extends State<SubmitStory> {
  CategoryService _categoryService = CategoryService();
  List<Category> _categoryList = [];
  Category? dropdownValue;

  TextEditingController _nameController = TextEditingController();
  TextEditingController _styController = TextEditingController();
  TextEditingController _ttlController = TextEditingController();

  bool isLoading = false;
  File? _image;
  final _picker = ImagePicker();

  Future choiceImage() async {
    var pickedImage = await _picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
        maxHeight: 500.0,
        maxWidth: 500.0);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future cameraImage() async {
    var pickedImage = await _picker.pickImage(
        source: ImageSource.camera,
        imageQuality: 50,
        maxHeight: 500.0,
        maxWidth: 500.0);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future uploadImage() async {
    final uri =
        Uri.parse('https://pkbhai.com/myprojects/recipe/api/add-recipe');
    var request = http.MultipartRequest("POST", uri);
    request.fields['recipeTitle'] = _ttlController.text;
    request.fields['recipeIngredient'] = _styController.text;
    //request.fields['recipeDirection'] = await keyEditor2.currentState.getText();
    request.fields['category'] = dropdownValue!.id.toString();
    //request.fields['cookTime'] = cookTime.text;
    var pic = await http.MultipartFile.fromPath('recipePhoto', _image!.path);
    request.files.add(pic);

    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded');
      Navigator.pop(context);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(),
        ),
      );
    } else {
      print("Failed to upload");
      print(response);
    }
  }

  _getAllCategories() async {
    var categories = await _categoryService.getCategories();
    var _list = json.decode(categories.body);
    List<Category> results = [];
    _list['data'].forEach((data) {
      var model = Category();
      model.id = data["id"];
      model.name = data["name"];
      model.icon = data["icon"];
      results.add(model);
    });
    if (mounted) {
      setState(() {
        _categoryList = results;
      });
    }
  }

  @override
  void initState() {
    _getAllCategories();
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _nameController.dispose();
    _styController.dispose();
    _ttlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Submit Your Story",
        ),
        centerTitle: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
          bottomRight: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        )),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Center(
                child: _image == null
                    ? Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Image.asset(
                              'assets/kids.png',
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                            ),
                          ),
                          Positioned(
                            bottom: 50,
                            left: 100,
                            child: Center(
                              child: ElevatedButton(
                                style: ButtonStyle(),
                                onPressed: () {
                                  _showPicker(context);
                                },
                                child: Text(
                                  "Select Image",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            right: 75,
                            child: CircleAvatar(
                                radius: 30,
                                child: IconButton(
                                    icon: Icon(
                                      Icons.camera_alt,
                                      size: 35,
                                    ),
                                    onPressed: () {
                                      _showPicker(context);
                                    })),
                          )
                        ],
                      )
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.file(
                          _image!,
                          height: 200,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    labelText: 'Enter Your Name',
                    hintText: 'Enter Name Here',
                  ),
                  autofocus: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _ttlController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    labelText: 'Enter Story Title',
                    hintText: 'Enter Story Title',
                  ),
                  autofocus: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Text(
                    'Select Category',
                    style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: DropdownButton<Category>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 28,
                    elevation: 10,
                    isExpanded: true,
                    autofocus: true,
                    hint: Text('Select'),
                    style: TextStyle(color: Colors.deepPurple, fontSize: 20),
                    onChanged: (Category? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: _categoryList
                        .map<DropdownMenuItem<Category>>((Category? value) {
                      return DropdownMenuItem<Category>(
                        value: value,
                        child: Text(value!.name!),
                      );
                    }).toList()),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: _styController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(20.0)),
                      borderSide: BorderSide(color: Colors.blue),
                    ),
                    labelText: 'Write Story Here',
                    hintText: 'Start writing here..',
                  ),
                  autofocus: false,
                  maxLength: 1000,
                  maxLines: 10,
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  // _launchURL('pkyadav4488@gmail.com', _nameController.text,
                  //     _ttlController.text, _styController.text);
                  print(dropdownValue!.name!.toString());
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        choiceImage();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      cameraImage();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }
}
