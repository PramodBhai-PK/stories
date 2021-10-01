import 'package:http/http.dart' as http;
import 'package:kids_stories/repository/db_connection.dart';
import 'package:sqflite/sqflite.dart';

class Repository {
  late DatabaseConnection _connection;
  String _baseUrl = "pkbhai.com";
  String _subUrl = "myprojects/kids-stories/api";
  //var _headers = {"Content-type": "application/x-www-form-urlencoded", "Accept": "application/json"};

  Repository() {
    _connection = DatabaseConnection();
  }

  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await _connection.setDatabase();

    return _database;
  }

  httpGet(String api) async {
    return await http.get(Uri.https(_baseUrl, "$_subUrl/$api"));
  }

  httpGetById(String api, id) async {
    return await http.get(Uri.https(_baseUrl, "$_subUrl/$api/$id"));
  }

  httpPost(String api, data) async {
    print(data);
    return await http.post(Uri.parse("https://$_baseUrl/$_subUrl/$api"),
        body: data);
  }
}
