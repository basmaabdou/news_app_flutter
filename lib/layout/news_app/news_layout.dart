import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../modules/news_app/search/search_screen.dart';
import '../../shared/component/component.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';
class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (BuildContext context, state) {
        },
      builder: (BuildContext context, Object? state) {
        var cubit=NewsCubit.get(context);
        return Scaffold(

          appBar: AppBar(
            title:Text
              (
              cubit.titles[cubit.currentIndex],
            ) ,
            actions: [
              IconButton(
                  onPressed: (){
                    navigateTo(context, SearchScreen());
                  },
                  icon: const Icon(Icons.search)
              ),
              IconButton(
                  onPressed: (){
                   NewsCubit.get(context).changeMode();
                  },
                  icon: const Icon(Icons.brightness_4_outlined)
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index){
              cubit.changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.business),
                  label: 'Business',
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.sports),
                  label: 'Sports'
              ),
              BottomNavigationBarItem(
                  icon: Icon(Icons.science),
                  label: 'Science'
              ),
            ],
          ),
        );
      },
    );
  }
}
