import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/flashcard.dart';
import '../models/flashcard_set.dart';

class DatabaseService {
  static final DatabaseService _instance = DatabaseService._();
  static Database? _database;

  DatabaseService._();

  factory DatabaseService() => _instance;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    final path = join(await getDatabasesPath(), 'flashcards.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE flashcard_sets (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE
      )
    ''');

    await db.execute('''
      CREATE TABLE flashcards (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question TEXT,
        answer TEXT,
        setName TEXT
      )
    ''');
  }

  //zestawy
  Future<void> createFlashcardSet(String name) async {
    final db = await database;
    await db.insert('flashcard_sets', {'name': name});
  }

  Future<List<FlashcardSet>> getFlashcardSets() async {
    final db = await database;
    final result = await db.query('flashcard_sets');
    return result.map((e) => FlashcardSet.fromMap(e)).toList();
  }

  Future<void> deleteFlashcardSet(String name) async {
    final db = await database;
    await db.delete('flashcard_sets', where: 'name = ?', whereArgs: [name]);
    await db.delete('flashcards', where: 'setName = ?', whereArgs: [name]);
  }


  //fiszki
  Future<int> addFlashcard(Flashcard card) async {
    final db = await database;
    return await db.insert('flashcards', card.toMap());
  }

  Future<List<Flashcard>> getFlashcards() async {
    final db = await database;
    final maps = await db.query('flashcards');
    return maps.map((map) => Flashcard.fromMap(map)).toList();
  }

  Future<List<Flashcard>> getFlashcardsBySet(String setName) async {
    final db = await database;
    final maps = await db.query(
      'flashcards',
      where: 'setName = ?',
      whereArgs: [setName],
    );
    return maps.map((map) => Flashcard.fromMap(map)).toList();
  }

  Future<void> deleteFlashcard(int id) async {
    final db = await database;
    await db.delete('flashcards', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> deleteFlashcardsBySet(String setName) async {
    final db = await database;
    await db.delete('flashcards', where: 'setName = ?', whereArgs: [setName]);
  }

  Future<List<String>> getAllSetNames() async {
    final db = await database;
    final result = await db.rawQuery('SELECT DISTINCT setName FROM flashcards');
    return result
        .map((e) => e['setName'] as String)
        .where((name) => name.trim().isNotEmpty)
        .toSet()
        .toList();
  }
}
