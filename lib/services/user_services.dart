import 'package:kids_stories/models/user.dart';
import 'package:kids_stories/repository/repository.dart';

class UserService {
  Repository? _repository;

  UserService() {
    _repository = Repository();
  }

  createUser(User user) async {
    return await _repository?.httpPost('new-user-registration', user.toJson());
  }

  login(User user) async {
    return await _repository?.httpPost('registered-user-login', user.toJson());
  }
}
