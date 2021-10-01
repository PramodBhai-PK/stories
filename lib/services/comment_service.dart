import 'package:kids_stories/models/comment.dart';
import 'package:kids_stories/repository/repository.dart';

class CommentService{
   Repository? _repository;
  CommentService(){
    _repository = Repository();
  }
  allComments() async{
    return await _repository?.httpGet('all-comments');
  }
  commentsByArticle(storyId) async{
    return await _repository?.httpGetById('get-comments-by-story', storyId);
  }
  postComment(Comment comment) async {
    return await _repository?.httpPost('comment', comment.toJson());
  }

}