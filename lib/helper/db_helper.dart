import 'package:kids_stories/models/favorite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as Path;

class DBHelper {
  // ignore: non_constant_identifier_names
  static final String CREATE_TABLE_FAVORITE = '''CREATE TABLE $TABLE_FAVORITE(
  $COLUMN_ID          INTEGER PRIMARY KEY AUTOINCREMENT,
  $COLUMN_STORY_ID   INTEGER,
  $COLUMN_IS_FAVORITE INTEGER,
  $COLUMN_TITLE       TEXT,
  $COLUMN_DETAILS TEXT,
  $COLUMN_AUTHOR  TEXT,
  $COLUMN_VIEWS    TEXT,
  $COLUMN_DATE    TEXT,
  $COLUMN_CATEGORY    TEXT,
  $COLUMN_IMAGE       TEXT
  )''';

  static Future<Database> open() async {
    // ignore: non_constant_identifier_names
    final BASEPATH = await getDatabasesPath();
    // ignore: non_constant_identifier_names
    final DBPATH = Path.join(BASEPATH, 'story.db');
    return openDatabase(DBPATH, version: 2, onCreate: (db, version) async {
      await db.execute(CREATE_TABLE_FAVORITE);
    });
  }

  // ignore: missing_return
  static Future<int?> insert(Favorite favorite) async {
    final db = await open();
    getSingle(favorite.storyId!).then((value) {
      if (value != null) {
        return db.delete(TABLE_FAVORITE,
            where: '$COLUMN_STORY_ID=?', whereArgs: [favorite.storyId]);
      } else {
        return db.insert(TABLE_FAVORITE, favorite.toJson());
      }
    });
  }

  static Future<Favorite?> getSingle(int? storyId) async {
    final db = await open();
    List<Map<String, dynamic>> mapList = await db.query(TABLE_FAVORITE,
        where: '$COLUMN_STORY_ID=?', whereArgs: [storyId], limit: 1);
    if (mapList.length > 0) {
      return Favorite.fromJson(mapList.first);
    } else {
      return null;
    }
  }

  static Future<List<Favorite>?> getAll() async {
    final db = await open();
    List<Map<String, dynamic>> mapList = await db.query(TABLE_FAVORITE);
    if (mapList.length > 0) {
      return List.generate(
          mapList.length, (index) => Favorite.fromJson(mapList[index]));
    } else {
      return null;
    }
  }
}
