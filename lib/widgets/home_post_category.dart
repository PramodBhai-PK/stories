import 'package:flutter/material.dart';
import 'package:kids_stories/screens/stories_by_category_name.dart';

class HomePostCategory extends StatefulWidget {
  final int? id;
  final String? name;
  final String? icon;
  HomePostCategory({this.name, this.icon, this.id});
  @override
  _HomePostCategoryState createState() => _HomePostCategoryState();
}

class _HomePostCategoryState extends State<HomePostCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => StoriesByCategoryName(
                    name: widget.name, id: widget.id, icon: widget.icon),
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 42,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: FadeInImage(
                        fit: BoxFit.cover,
                          width: 80,
                          height: 80,
                          placeholder: AssetImage('assets/place_cat.png'),
                          image: NetworkImage(this.widget.icon!)),
                    )),
                Text(
                  this.widget.name!,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                )
              ],
            ),
          ),
        ));
  }
}

class AllCategory extends StatefulWidget {
  final int? id;
  final String? name;
  final String? icon;
  AllCategory({this.name, this.icon, this.id});
  @override
  _AllCategoryState createState() => _AllCategoryState();
}

class _AllCategoryState extends State<AllCategory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 300,
      width: MediaQuery.of(context).size.width,
      child: InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StoriesByCategoryName(
                          name: widget.name,
                          id: widget.id,
                          icon: widget.icon,
                        )));
          },
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    child: Card(
                      elevation: 2,
                      shadowColor: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(
                            widget.icon!,
                            fit: BoxFit.fill,
                            height: MediaQuery.of(context).size.width / 2.5,
                            width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(
                    widget.name!,
                    style: TextStyle(
                        fontSize: 23,
                        fontWeight: FontWeight.bold,),
                  )
                ],
              ),
            ),
          )),
    );
  }
}
