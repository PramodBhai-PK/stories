import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection{
  setDatabase() async{
    var directory = await getApplicationDocumentsDirectory();
    var path = join(directory.path, 'db_likes');
    var database = await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database db, int version) async {
    await db.execute("CREATE TABLE likes(id INTEGER PRIMARY KEY, recipeTitle TEXT, recipePhoto TEXT, recipeIngredient TEXT, recipeDirection TEXT, cookTime TEXT )");
  }
}