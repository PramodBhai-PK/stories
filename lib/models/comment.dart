class Comment{
  int? id;
  // ignore: non_constant_identifier_names
  int? story_id;
  // ignore: non_constant_identifier_names
  int? user_id;
  String? comment;
  String? uName;
  String? userPic;
  String? date;
  toJson(){
    return {
      'id' : id.toString(),
      'Name' : uName.toString(),
      'story_id' : story_id.toString(),
      'profilePic' : userPic.toString(),
      'comment' : comment.toString(),
      'user_id' : user_id.toString(),
      'created' : date.toString()
    };
  }
}