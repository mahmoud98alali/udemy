import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:udemy/layout/shop_app/shop_layout/cubit/cubit.dart';
import 'package:udemy/layout/shop_app/shop_layout/shop_layout.dart';
import 'package:udemy/layout/social_app/cubit/cubit.dart';
import 'package:udemy/layout/social_app/social_layout.dart';
import 'package:udemy/modules/shop_app/login_screen/login_screen.dart';
import 'package:udemy/shared/bloc_observer.dart';
import 'package:udemy/shared/components/components.dart';
import 'package:udemy/shared/components/contains.dart';
import 'package:udemy/shared/cubit/cubit.dart';
import 'package:udemy/shared/cubit/states.dart';
import 'package:udemy/shared/network/local/cache_helper.dart';
import 'package:udemy/shared/network/remote/dio_helper.dart';
import 'package:udemy/shared/styles/themes.dart';
import 'layout/news_app/cubit/cubit.dart';
import 'layout/news_app/news_layout.dart';
import 'layout/todo_app/todo_layout.dart';
import 'modules/ibm_app/IBM/IBMScreen.dart';
import 'modules/shop_app/on_boarding/on_boarding_screen.dart';
import 'modules/social_app/social_login/login_screen.dart';


Future<void> firebaseBackGround(RemoteMessage message) async
{ await Firebase.initializeApp();
  print(message.data.toString());
  print('.......................');

  showToast(text: 'on Background messaging', state: ToastStates.SUCCESS);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  var token = await FirebaseMessaging.instance.getToken();
  print('.......................');
  print("token =  $token");
  print('.......................');
  FirebaseMessaging.onMessage.listen((event)
  { print('on message');
    print(event.data.toString());
  print('.......................');

  showToast(text: 'on message', state: ToastStates.SUCCESS);
  }
  );

  FirebaseMessaging.onMessageOpenedApp.listen((event)
  { print('.......................');
  print(event.data.toString());
  print('.......................');

  showToast(text: 'on message opened app', state: ToastStates.SUCCESS);
  }
  );

  FirebaseMessaging.onBackgroundMessage(firebaseBackGround);

  DioHelper.init();
  await CacheHelper.init();
  Widget? widget;

  bool? isDark = CacheHelper.getData(key: "isDark");

  // bool? onBoarding = CacheHelper.getData(key: 'onBoarding');
  // token = CacheHelper.getData(key: 'token') ?? "";
  uId = CacheHelper.getData(key: 'uId') ?? "";




  if(uId !=""){
    widget =const SocialLayout();

  }else{
    widget =SocialLoginScreen();
  }

  // for market app
  // if (onBoarding != null) {
  //   if (token != "") {
  //     widget = const ShopLayout();
  //   } else {
  //     widget =  ShopLoginScreen();
  //   }
  // } else {
  //   widget = OnBoardingScreen();
  // }
  //

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
        BlocProvider(create: (BuildContext context) => SocialCubit()..getUserData()..getPosts()),
      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter APK',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
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
