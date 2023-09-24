import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/shared/bloc_observed.dart';
import 'package:news_app/shared/styles/themes.dart';

import 'layout/news_app/cubit/cubit.dart';
import 'layout/news_app/cubit/states.dart';
import 'layout/news_app/news_layout.dart';
import 'network/local/cache_helper.dart';
import 'network/remote/dio_helper.dart';

void main() async {
  // بيتأكد ان كل حاجه هنا في الميثود خلصت و بعدين يتفح الابلكيشن
  WidgetsFlutterBinding.ensureInitialized();

  Bloc.observer = MyBlocObserver();
  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');

  runApp(MyApp(isDark: isDark,));
}

// Stateless
// Stateful

// class MyApp

class MyApp extends StatelessWidget {
  // constructor
  // build
  final bool? isDark;

  MyApp({this.isDark});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers:
      [
        BlocProvider(
          create: (context) => NewsCubit(InitialNews())
            ..getBusiness()
            ..getSports()
            ..getScience(),
        ),
        // BlocProvider(
        //   create: (BuildContext context) => NewsCubit(InitialNews())
        //     ..changeMode(
        //       fromShared: isDark,
        //     ),
        // ),
      ],
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: lightTheme,
            // dark and edit
            darkTheme: darkTheme,
            themeMode: NewsCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
            home: NewsLayout(),
          );
        },
      ),
    );
  }
}