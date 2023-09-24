import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../layout/news_app/cubit/cubit.dart';
import '../../../layout/news_app/cubit/states.dart';
import '../../../shared/component/component.dart';

class SearchScreen extends StatelessWidget {
  var searchController=TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state){},
      builder: (context,state){
        var list=NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultTextForm(
                    controller: searchController,
                    type: TextInputType.text,
                    labelText: 'Search',
                    prefix: Icons.search,
                    validate: (value){
                      if(value.isEmpty){
                        return 'search must not be empty';
                      }
                      return null;
                    },
                    onChanged: (value){
                           NewsCubit.get(context).getSearch(value);
                    }
                ),
              ),
              Expanded(child: articleBuilder(list,isSearch: true))
            ],
          ),
        );
      },
    );
  }
}
