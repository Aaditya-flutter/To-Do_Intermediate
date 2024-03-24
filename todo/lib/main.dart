import 'package:flutter/material.dart';
import 'todo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

dynamic database;
List<TaskData> dbList = [];

Future insertTask(TaskData obj) async {
  final localDB = await database;

  localDB.insert(
    "Tasks",
    obj.taskMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}

Future<List<TaskData>> getTasksData() async {
  final localDB = await database;

  List<Map<String, dynamic>> taskdataObjMap = await localDB.query("Tasks");

  return List.generate(
    taskdataObjMap.length,
    (index) {
      return TaskData(
        id: taskdataObjMap[index]['id'],
        title: taskdataObjMap[index]['title'],
        description: taskdataObjMap[index]['description'],
        date: taskdataObjMap[index]['date'],
      );
    },
  );
}

Future deleteTask(TaskData obj) async {
  final localDB = await database;

  await localDB.delete(
    "Tasks",
    where: "id = ?",
    whereArgs: [obj.id],
  );
}

Future updateTask(TaskData obj) async{
  final localDB = await database;

  await localDB.update(
    "Tasks",
    obj.taskMap(),
    where: "id = ?",
    whereArgs: [obj.id],
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  database = openDatabase(
    join(await getDatabasesPath(), "todoDB1.db"),
    version: 1,
    onCreate: (db, version) async {
      await db.execute(
        '''CREATE TABLE Tasks(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          title TEXT,
          description TEXT,
          date TEXT
        )''',
      );
    },
  );

  dbList = await getTasksData();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(89, 57, 241, 1),
          primary: const Color.fromRGBO(89, 57, 241, 1),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromRGBO(89, 57, 241, 1),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Color.fromRGBO(89, 57, 241, 1),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const Todo(),
    );
  }
}
