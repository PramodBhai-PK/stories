// ignore: non_constant_identifier_names
final String TABLE_FAVORITE = 'tbl_favorite';
// ignore: non_constant_identifier_names
final String COLUMN_ID = 'id';
// ignore: non_constant_identifier_names
final String COLUMN_STORY_ID = 'storyId';
// ignore: non_constant_identifier_names
final String COLUMN_IS_FAVORITE = 'isFavorite';
// ignore: non_constant_identifier_names
final String COLUMN_TITLE = 'title';
// ignore: non_constant_identifier_names
final String COLUMN_DETAILS = 'details';
// ignore: non_constant_identifier_names
final String COLUMN_AUTHOR = 'author';
// ignore: non_constant_identifier_names
final String COLUMN_VIEWS = 'views';
// ignore: non_constant_identifier_names
final String COLUMN_IMAGE = 'image';
// ignore: non_constant_identifier_names
final String COLUMN_CATEGORY = 'categoryName';
// ignore: non_constant_identifier_names
final String COLUMN_DATE = 'date';
// // ignore: non_constant_identifier_names
// final String COLUMN_INGREDIENTS = 'details';
// // ignore: non_constant_identifier_names
// final String COLUMN_DIRECTIONS = 'author';
// // ignore: non_constant_identifier_names
// final String COLUMN_COOKTIME = 'date';
// // ignore: non_constant_identifier_names
// final String COLUMN_IMAGE = 'image';
// // ignore: non_constant_identifier_names
// final String COLUMN_STORY_VIEWS = 'views';
// // ignore: non_constant_identifier_names
// final String COLUMN_CATEGORY = 'categoryName';

class Favorite {
  int? id;
  int? storyId;
  int? isFavorite;
  String? title;
  String? details;
  String? author;
  String? date;
  String? image;
  String? views;
  String? categoryName;

  Favorite(
      {this.id,
      this.storyId,
      this.isFavorite,
      this.title,
      this.details,
      this.author,
      this.date,
      this.image,
      this.views,
      this.categoryName});

  factory Favorite.fromJson(Map<String, dynamic> json) {
    return Favorite(
        id: json[COLUMN_ID],
        storyId: json[COLUMN_STORY_ID],
        isFavorite: json[COLUMN_IS_FAVORITE],
        title: json[COLUMN_TITLE],
        details: json[COLUMN_DETAILS],
        author: json[COLUMN_AUTHOR],
        views: json[COLUMN_VIEWS],
        image: json[COLUMN_IMAGE],
        categoryName: json[COLUMN_CATEGORY],
        date: json[COLUMN_DATE]);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data[COLUMN_ID] = id;
    data[COLUMN_STORY_ID] = storyId;
    data[COLUMN_IS_FAVORITE] = isFavorite;
    data[COLUMN_TITLE] = title;
    data[COLUMN_DETAILS] = details;
    data[COLUMN_AUTHOR] = author;
    data[COLUMN_DATE] = date.toString();
    data[COLUMN_IMAGE] = image;
    data[COLUMN_VIEWS] = views;
    data[COLUMN_CATEGORY] = categoryName.toString();
    return data;
  }

  @override
  String toString() {
    return 'Favorite{id: $id, storyId: $storyId, isFavorite: $isFavorite, title: $title, details: $details, views: $views, author: $author, date: $date, image: $image, categoryName:$categoryName}';
  }
}
