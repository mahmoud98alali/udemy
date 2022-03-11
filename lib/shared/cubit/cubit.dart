import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:udemy/shared/cubit/states.dart';
import 'package:udemy/shared/network/local/cache_helper.dart';
import '../../modules/tasks_app/Done_Tasks/done_tasks_screen.dart';
import '../../modules/tasks_app/archived_Tasks/archived_tasks_screen.dart';
import '../../modules/tasks_app/new_Tasks/new_tasks_screen.dart';

class AppCubit extends Cubit<AppStates>{

  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  List<Map> newTasks = [];
  List<Map> doneTasks = [];
  List<Map> archivedTasks = [];

  int currentIndex = 0;
  List<Widget> screens = [
    const NewTasksScreen(),
    const DoneTasksScreen(),
    const ArchivedTasksScreen(),
  ];

  List<String> titles = ["New tasks_app", "Done tasks_app", "Archived tasks_app"];

  void changNavBar(int index){
    currentIndex = index;
    emit(AppChangeBottomNavBarState());
  }



  Database? database;

  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print("database created");
        database
            .execute(
            'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print("table created");
        }).catchError((error) {
          print("Error When Creating${error.toString()}");
        });
      },
      onOpen: (database)  {
        getDataFromDataBase(database);
        print("database opened");
      },
    ).then((value) {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

   insertDatabase({
    required String title,
    required String time,
    required String date,
  }) async {
   await database?.transaction((txn) async {
      txn
          .rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES("$title","$date","$time","new")')
          .then((value) {
            emit(AppInsertDatabaseState());
            isBottomSheetsShown = false;
            iconFloatingAction = Icons.edit;

            getDataFromDataBase(database);

        print("$value Inserted successfully");
      }).catchError((error) {
        print("Error When Inserting New Record ${error.toString()}");
      });
    });
  }

  void getDataFromDataBase(database) async
  {
    newTasks=[];
    doneTasks=[];
    archivedTasks=[];
    emit(AppGetDatabaseLoadingState());
     database!.rawQuery('SELECT * FROM tasks').then((value) {
       value.forEach((element){
        if(element['status']=='new') {newTasks.add(element);}
        else if(element['status']=='done') {doneTasks.add(element);}
        else {
          archivedTasks.add(element);
        }
       });
       emit(AppGetDatabaseState());
     });
  }


  void updateData ({
  required String status,
  required int  id,
}){

    database!.rawUpdate('UPDATE tasks SET status = ? WHERE id = ?',[status,id]).then((value) {
        getDataFromDataBase(database);
      emit(AppUpdateDatabaseState());
    });
  }


  void deleteData ({
    required int  id,
  }){

    database!.rawDelete('DELETE FROM tasks WHERE id = ?',[id])
        .then((value) {
      getDataFromDataBase(database);
      emit(AppDeleteDatabaseState());
    });
  }



  bool isBottomSheetsShown = false;
  IconData iconFloatingAction = Icons.edit;

  void changeBottomSheetState({
    required bool isShow,
    required IconData icon,}){
    isBottomSheetsShown =isShow  ;
    iconFloatingAction =icon ;
    emit(AppChangeBottomSheetState());
  }

 bool isDark = true;
  void changeMode ({bool? fromShared}){
    if(fromShared != null){
      isDark = fromShared;
      emit(AppChangeModeState());
    }else{
      isDark=!isDark;
      CacheHelper.putBoolData(key: "isDark", value: isDark).then((value) {
        emit(AppChangeModeState());
      });
    }



  }
}