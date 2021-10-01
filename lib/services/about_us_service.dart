import 'package:kids_stories/repository/repository.dart';

class AboutUsService {
  Repository? _repository;
  AboutUsService() {
    _repository = Repository();
  }
  getAboutUs() async {
    return await _repository?.httpGet('about-us');
  }
}