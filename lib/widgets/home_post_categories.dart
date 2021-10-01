import 'package:flutter/material.dart';
import 'package:kids_stories/models/category.dart';
import 'home_post_category.dart';

class HomePostCategories extends StatefulWidget {
  final List<Category>? categoryList;
  HomePostCategories({this.categoryList});
  @override
  _HomePostCategories createState() => _HomePostCategories();
}

class _HomePostCategories extends State<HomePostCategories> {
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 120,
        child:
            // GridView.builder(
            //   gridDelegate:
            //       SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,),
            //   physics: NeverScrollableScrollPhysics(),
            //   scrollDirection: Axis.vertical,
            //   itemCount: 6,
            //   itemBuilder: (context, index) {
            //     if (this.widget.categoryList!.length != 0) {
            //       return Padding(
            //         padding: const EdgeInsets.all(8.0),
            //         child: index == 5
            //             ? InkWell(
            //                 onTap: () {
            //                   Navigator.push(
            //                       context,
            //                       MaterialPageRoute(
            //                           builder: (context) => CategoryList()));
            //                 },
            //                 child: Column(
            //                   children: [
            //                     Container(
            //                       decoration: BoxDecoration(
            //                         border: Border.all(width: 2, color: Colors.blue),
            //                         borderRadius: BorderRadius.circular(60),
            //                       ),
            //                       child: CircleAvatar(
            //                           radius: 42,
            //                           backgroundColor: Colors.transparent,
            //                           child: Center(
            //                               child: Text(
            //                             'more',
            //                             style:
            //                                 TextStyle(color: Colors.red, fontSize: 30),
            //                           ))),
            //                     ),
            //                     Text('...',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: Colors.black),)
            //                   ],
            //                 ))
            //             : HomePostCategory(
            //
            //
            //
            //               ),
            //       );
            //     } else
            //       return Container();
            //   },
            // ),
            ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: this.widget.categoryList!.length,
                itemBuilder: (context, index) {
                 return HomePostCategory(
                  id: this.widget.categoryList![index].id,
                  name: this.widget.categoryList![index].name,
                  icon: this.widget.categoryList![index].icon,
                );
        }));
  }
}

class AllCategories extends StatefulWidget {
  final List<Category>? categoryList;
  AllCategories({this.categoryList});
  @override
  _AllCategoriesState createState() => _AllCategoriesState();
}

class _AllCategoriesState extends State<AllCategories> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        // scrollDirection: Axis.horizontal,
        itemCount: widget.categoryList!.length,
        itemBuilder: (context, index) {
          return AllCategory(
            id: this.widget.categoryList![index].id,
            name: this.widget.categoryList![index].name,
            icon: this.widget.categoryList![index].icon,
          );
        },
      ),
    );
  }
}
