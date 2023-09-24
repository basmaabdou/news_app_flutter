import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';

import '../../../modules/news_app/buisness/buisness.dart';
import '../../../modules/news_app/science/science.dart';
import '../../../modules/news_app/sports/sports.dart';
import '../../../network/local/cache_helper.dart';
import '../../../network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>{
  NewsCubit(NewsStates initialState) : super(InitialNews());

  static NewsCubit get(context) => BlocProvider.of(context);

  List<String> titles=[
    'Buisness',
    'Sports',
    'Science',
    'Settings'
  ];
  List<Widget> screens=[
     BuisnessScreen(),
     SportScreen(),
     ScienceScreen(),
  ];
  int currentIndex=0;
  void changeIndex(index){
     currentIndex=index;
     // if(index==1)
     //   getSport();
     // if(index==2)
     //   getScience();
     emit(ChangeBottomNavBar());
  }

  List<dynamic> business = [];
  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());

    DioHelper.getApiData(
      url: 'v2/top-headlines',
      query:
      {
        'sources':'techcrunch',
        'apiKey':'28988366cd504af9b749397e49c45648'
      },
    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      business = value.data['articles'];


      print(business[0]['title']);
      emit(NewsGetBusinessSuccessState());
    }).catchError((error){
      print('yalahwwwwy');
      print(error.toString());
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }


  List<dynamic> sports = [];

  void getSports()
  {
    emit(NewsGetSportsLoadingState());

    if(sports.length == 0)
    {
      DioHelper.getApiData(
        url: 'v2/top-headlines',
        query:
        {
          'sources':'techcrunch',
          'apiKey':'28988366cd504af9b749397e49c45648'
        },
      ).then((value)
      {
        //print(value.data['articles'][0]['title']);
        sports = value.data['articles'];
        print(sports[0]['title']);

        emit(NewsGetSportsSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetSportsErrorState(error.toString()));
      });
    } else
    {
      emit(NewsGetSportsSuccessState());
    }
  }

  List<dynamic> science = [];

  void getScience()
  {
    emit(NewsGetScienceLoadingState());

    if(science.length == 0)
    {
      DioHelper.getApiData(
        url: 'v2/top-headlines',
        query:
        {
          'sources':'techcrunch',
          'apiKey':'28988366cd504af9b749397e49c45648'
        },
      ).then((value)
      {
        //print(value.data['articles'][0]['title']);
        science = value.data['articles'];
        print(science[0]['title']);

        emit(NewsGetScienceSuccessState());
      }).catchError((error){
        print(error.toString());
        emit(NewsGetScienceErrorState(error.toString()));
      });
    } else
    {
      emit(NewsGetScienceSuccessState());
    }
  }

  List<dynamic> search = [];

  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());

    search=[];

    DioHelper.getApiData(
      url: 'v2/everything',
      query:
      {
        'q':'$value',
        'apiKey':'28988366cd504af9b749397e49c45648',
      },
    ).then((value)
    {
      //print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);

      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print(error.toString());
      emit(NewsGetSearchErrorState(error.toString()));
    });
  }
// to make the screen take the same color when run
  bool isDark=false;
  void changeMode( { bool? fromShared}){
    if(fromShared != null){
      isDark=fromShared;
      emit(NewsChangeMode());
    }else {
      isDark = !isDark;
      CacheHelper.putBoolean(key: 'isDark', value: isDark).then((value) {
        emit(NewsChangeMode());
      });
    }
  }
}