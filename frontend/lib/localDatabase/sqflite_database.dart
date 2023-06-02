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
    final database =
        await openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute('''
      
      CREATE TABLE User (
        id  INTEGER PRIMARY KEY AUTOINCREMENT,
        user_name TEXT,
        hash   TEXT,
        refresh_token TEXT,
        role  TEXT CHECK(role  IN ('owner', 'reserver'))
        email  TEXT NOT NULL UNIQUE,
      );

      CREATE TABLE  compound_owner (
        id  INTEGER PRIMARY KEY AUTOINCREMENT,
        first_name TEXT,
        last_name  TEXT,
        phone_no  TEXT,
        user_id  INTEGER,

        FOREIGN KEY(user_id) REFERENCES User(id) ON DELETE CASCADE, ON UPDATE CASCADE
      );

      CREATE TABLE spot_user(
        id INTEGER  PRIMARY KEY AUTOINCREMENT,
        first_name TEXT,
        last_name  TEXT,
        phone_no  TEXT,
        user_id  INTEGER,

        FOREIGN KEY(user_id) REFERENCES User(id) ON DELETE CASCADE, ON UPDATE CASCADE
      );

      CREATE TABLE parking_compound (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          owner_id   INTEGER,
          Region  TEXT,
          Zone   TEXT,
          Wereda TEXT,
          Kebele TEXT,
          price  REAL,
          available_spots INTEGER,
          total_spots   INTEGER,
          sync_status TEXT CHECK(sync_status IN ('created','updated','deleted'))

          FOREIGN KEY (owner_id) REFERENCES compound_owner (id) ON DELETE CASCADE ON UPDATE CASCADE 
         )' ;

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
        

        FOREIGN KEY(user_id) REFERENCES  User (id) ON DELETE CASCADE, ON UPDATE CASCADE,
        FOREIGN KEY(parking_spot_id) REFERENCES parking_spots ON DELETE CASCADE, ON UPDATE CASCADE
      )


      CREATE TABLE reviews(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_id INTEGER,
        parking_compound_id INTEGER,
        rating      INTEGER,
        comment   TEXT,
        
        
        FOREIGN KEY(user_id)  REFERENCES User(id) ON DELETE CASCADE, ON UPDATE CASCADE
        
      );
      ''');
    });
    
    return database;
  }
}
