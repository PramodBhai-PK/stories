import 'package:kids_stories/models/story.dart';
import 'package:kids_stories/repository/repository.dart';

class StoryService {
   Repository? _repository;
  StoryService() {
    _repository = Repository();
  }
  getAllStories() async {
    return await _repository?.httpGet('all-stories');
  }

  getEssays() async {
    return await _repository?.httpGet('eassays');
  }
  getPoems() async {
    return await _repository?.httpGet('poems');
  }
  getStoriesByCategoryId(categoryId) async {
    return await _repository?.httpGetById('get-stories-by-category', categoryId);
  }
  postRecipe(Story story) async{
     return await _repository?.httpPost('add-stories', story.toJson());
   }
}
