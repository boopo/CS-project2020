import 'package:flutter_puzzle/models/rank.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper{
	static DatabaseHelper _instance;

	Database _db;

	factory DatabaseHelper() => _getInstance();

	static DatabaseHelper get instance => _getInstance();

	static DatabaseHelper _getInstance(){
		if(_instance == null){
			_instance = DatabaseHelper._internal();
		}
		return _instance;
	}

	DatabaseHelper._internal(){

	}

	Future<Database> get db async{
		if(_db != null){
			return _db;
		}
		return await open();
	}

	Future<Database> open()async{
		String databasePath = await getDatabasesPath();
		String path = join(databasePath, "puzzle.db");
		_db = await openDatabase(
			path,
			version: 1,
			onCreate: (Database db, int version) async{
				await db.execute(
					"CREATE TABLE 'rank' ("
							"'id' integer NOT NULL PRIMARY KEY AUTOINCREMENT,"
							"'level' integer,"
							"'name' text,"
							"'score' integer,"
							"'time' text"
					")"
				);
			}
		);
		return _db;
	}

	Future<int> insert(Rank rank) async{
		await db;
		return await _db.insert("rank", rank.toMap());
	}

	Future<int> delete() async{
		await db;
		return await _db.delete("rank", );
	}

	Future<List<Rank>> searchThree(int level) async{
		List<Rank> ranks = [];
		await db;
		List<Map<String, dynamic>> list = await _db.query("rank", columns: ["name", "score", "time"], where: "level = ?", whereArgs: [level], limit: 3, orderBy: "score asc");
		if(list == null || list.length == 0){
			return null;
		}
		for(Map<String, dynamic> map in list){
			ranks.add(Rank.fromMap(map));
		}
		return ranks;
	}

	Future close() async {
		await db;
		await _db.close();
	}
}