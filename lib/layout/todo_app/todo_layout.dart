import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:udemy/shared/components/components.dart';
import 'package:udemy/shared/cubit/cubit.dart';
import 'package:udemy/shared/cubit/states.dart';

class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDatabase(),
      child: BlocConsumer<AppCubit, AppStates>(
          listener: (BuildContext context, AppStates state) {
        if (state is AppInsertDatabaseState) {
          Navigator.pop(context);
        }
      }, builder: (BuildContext context, AppStates state) {
        AppCubit cubit = AppCubit.get(context);
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            title: Text(cubit.titles[cubit.currentIndex]),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(cubit.iconFloatingAction),
            onPressed: () {
              if (cubit.isBottomSheetsShown) {
                if (formKey.currentState!.validate()) {
                  cubit.insertDatabase(
                      title: titleController.text,
                      time: timeController.text,
                      date: dateController.text);
                  cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                }
              } else {
                scaffoldKey.currentState?.showBottomSheet(
                      (context) => Container(
                        padding: EdgeInsets.all(20.0),
                        color: Colors.grey[100],
                        child: Form(
                          key: formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              defaultFormField(
                                controller: titleController,
                                keyboardType: TextInputType.text,
                                labelText: "Task Title",
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'title must not be empty';
                                  }
                                },
                                prefixIcon: Icon(Icons.title),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              defaultFormField(
                                controller: timeController,
                                onTap: () {
                                  showTimePicker(
                                    context: context,
                                    initialTime: TimeOfDay.now(),
                                  ).then((value) {
                                    timeController.text =
                                        value!.format(context).toString();
                                  });
                                },
                                keyboardType: TextInputType.datetime,
                                labelText: "Task Time",
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'time must not be empty';
                                  }
                                },
                                prefixIcon: Icon(Icons.watch_later_outlined),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              defaultFormField(
                                controller: dateController,
                                onTap: () {
                                  showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.parse('2022-12-31'),
                                  ).then((value) {
                                    dateController.text =
                                        DateFormat.yMMMd().format(value!);
                                  });
                                },
                                keyboardType: TextInputType.datetime,
                                labelText: "Task Date",
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return 'date must not be empty';
                                  }
                                },
                                prefixIcon: Icon(Icons.calendar_today),
                              ),
                            ],
                          ),
                        ),
                      ),
                      elevation: 20.0,
                    )
                    .closed
                    .then((value) {
                  cubit.changeBottomSheetState(isShow: false, icon: Icons.edit);
                });
                cubit.changeBottomSheetState(isShow: true, icon: Icons.add);
              }
            },
          ),
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changNavBar(index);
            },
            items: const [
               BottomNavigationBarItem(
                  icon: Icon( Icons.menu),
                  label:  "tasks_app"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.check_circle_outline), label: "Done"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.archive_outlined), label: "Archived"),
            ],
          ),
          body: ConditionalBuilder(
            condition: state is! AppGetDatabaseLoadingState,
            builder: (context) => cubit.screens[cubit.currentIndex],
            fallback: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      }),
    );
  }
}
