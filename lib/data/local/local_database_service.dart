import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseService {
  static const String _databaseName = 'restaurant-app.db';
  static const String _tableName = 'restaurant';
  static const int version = 1;

  Future<void> createTables(Database database) async {
    await database.execute("""
        CREATE TABLE $_tableName(
          id TEXT PRIMARY KEY,
          name TEXT,
          description TEXT,
          pictureId TEXT,
          city TEXT,
          rating REAL
        )
      """);
  }

  Future<Database> _initializeDb() async {
    return openDatabase(_databaseName, version: version,
        onCreate: (Database database, int version) async {
      await createTables(database);
    });
  }

  Future<int> insertItem(RestaurantList restaurant) async {
    final db = await _initializeDb();

    final data = restaurant.toJson();
    final id = await db.insert(
      _tableName,
      data,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    return id;
  }

  Future<List<RestaurantList>> getAllItems() async {
    final db = await _initializeDb();

    final results = await db.query(_tableName);

    return results.map((result) => RestaurantList.fromJson(result)).toList();
  }

  Future<RestaurantList> getItemById(String id) async {
    final db = await _initializeDb();

    final results =
        await db.query(_tableName, where: "id = ?", whereArgs: [id], limit: 1);

    return results.map((result) => RestaurantList.fromJson(result)).first;
  }

  Future<int> removeItem(String id) async {
    final db = await _initializeDb();

    final results =
        await db.delete(_tableName, where: "id = ?", whereArgs: [id]);

    return results;
  }
}
