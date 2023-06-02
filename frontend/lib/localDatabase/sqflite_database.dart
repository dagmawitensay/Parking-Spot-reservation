import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class LocalDatabaseProvider {
  static final LocalDatabaseProvider _instance =
      LocalDatabaseProvider._internal();
  factory LocalDatabaseProvider() => _instance;

  static Database? localdatabase;

  Future<Database?> get database async {
    if (localdatabase != null) {
      return localdatabase;
    }

    localdatabase = await initializeDatabase();
    return localdatabase;
  }

  LocalDatabaseProvider._internal();

  Future<Database> initializeDatabase() async {
    final path = join(await getDatabasesPath(), 'parking_database.db');
    final database = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
      CREATE TABLE parking_compound (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          owner_id   INTEGER,
          name    TEXT,
          Region  TEXT,
          Zone   TEXT,
          Wereda TEXT,
          Kebele TEXT,
          price  REAL,
          available_spots INTEGER,
          total_spots   INTEGER,
          synced  INTEGER DEFAULT 0,
          sync_status TEXT DEFAULT 'created' CHECK(sync_status IN ('created','updated','deleted')) 
         ) ;

      CREATE TABLE parking_spots(
        id  INTEGER PRIMARY KEY AUTOINCREMENT,
        compound_id INTEGER,

        FOREIGN KEY(compound_id) REFERENCES parking_compound(id) ON DELETE CASCADE, ON UPDATE CASCADE
      )         
      
      CREATE TABLE reservations(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        parking_spot_id  INTEGER,
        start_time    TEXT,
        end_time  TEXT,
        
<<<<<<< HEAD
=======

        FOREIGN KEY(user_id) REFERENCES  User (id) ON DELETE CASCADE, ON UPDATE CASCADE,
>>>>>>> 1d802ade27bb303a1fdbadf33eec1c124f59a3c5
        FOREIGN KEY(parking_spot_id) REFERENCES parking_spots ON DELETE CASCADE, ON UPDATE CASCADE
      )


      CREATE TABLE reviews(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        parking_compound_id INTEGER,
        rating      INTEGER,
        comment   TEXT,
      );
      ''');
      },
      // onUpgrade: ((db, oldVersion, newVersion) async{
      //   if (oldVersion == 1 && newVersion == 2){
      //     await db.execute('ALTER TABLE parking_compound ADD COLUMN name TEXT');
      //   }
      // })

       onUpgrade: (Database db, int oldVersion, int newVersion) async {
        //
        //Iterate from the current version to the latest version and execute SQL statements
        for (int version = oldVersion; version < newVersion; version++) {
          await _performDBUpgrade(db, version + 1);
        }
      }, 
    );
    return database;
  }
   static Future<void> _performDBUpgrade(Database db, int upgradeToVersion) async {
    switch (upgradeToVersion) {
      case 2:
        await _dbUpdatesVersion_1(db);
        break;

    }
  }
static Future<void> _dbUpdatesVersion_1(Database db) async {
      // await db.execute('ALTER TABLE parking_compound ADD COLUMN name TEXT');
  }

}
