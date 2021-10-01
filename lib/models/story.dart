class Story{
  int? id;
  String? name;
  String? details;
  String? views;
  String? language;
  String? image;
  String? date;
  String? categoryName;
  String? author;
  String? authorPic;

  toMap() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['details'] = details;
    map['Language'] = language;
    map['views'] = views;
    map['created'] = date;
    map['categoryName'] = categoryName;
    map['Author'] = author;
    map['authorPic'] = authorPic;
    return map;
  }

  toJson() {
    return {
      'id': id.toString(),
      'name': name.toString(),
      'image': image,
      'details': details.toString(),
      'Language': language,
      'views': views.toString(),
      'created' : date.toString(),
      'categoryName' : categoryName,
      'Author' : author,
      'authorPic': authorPic,
    };
  }
  }