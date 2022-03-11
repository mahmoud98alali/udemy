import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/shop_app/shop_layout/cubit/cubit.dart';
import 'package:udemy/layout/shop_app/shop_layout/shop_layout.dart';
import 'package:udemy/modules/shop_app/login_screen/login_screen.dart';
import 'package:udemy/shared/bloc_observer.dart';
import 'package:udemy/shared/components/contains.dart';
import 'package:udemy/shared/cubit/cubit.dart';
import 'package:udemy/shared/cubit/states.dart';
import 'package:udemy/shared/network/local/cache_helper.dart';
import 'package:udemy/shared/network/remote/dio_helper.dart';
import 'package:udemy/shared/styles/themes.dart';
import 'layout/news_app/cubit/cubit.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();

  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: "isDark");

  bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  token = CacheHelper.getData(key: 'token') ?? "";
print(token);
print('...................');



  Widget? widget;

  if (onBoarding != null) {
    if (token != "") {
      widget = const ShopLayout();
    } else {
      widget =  ShopLoginScreen();
    }
  } else {
    widget = OnBoardingScreen();
  }
  // if(isDark==null){
  //   isDark= false;
  // }else{
  //   isDark = CacheHelper.getData(key: "isDark");
  // }
  //

  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        isDark: isDark,
        startWidget: widget,
      ));
    },
    blocObserver: MyBlocObserver(),
  );

  HttpOverrides.global = MyHttpOverrides();
}

class MyApp extends StatelessWidget {
  final bool? isDark;
  final Widget? startWidget;

   MyApp({this.isDark, this.startWidget});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => NewsCubit()
              ..getBusiness()
              ..getSport()
              ..getScience()),
        BlocProvider(
          create: (BuildContext context) => AppCubit()
            ..changeMode(
              fromShared: isDark,
            ),
        ),
        BlocProvider(create: (BuildContext context) => ShopCubit()..getHomeData()..getCategoriesData()..getFavorites()..getUserData()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter APK',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode:
                AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: startWidget,
          );
        },
      ),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
