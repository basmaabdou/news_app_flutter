

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../layout/news_app/cubit/cubit.dart';
import '../../modules/news_app/web_view/web_view_screen.dart';

Widget defaultButton({
   double width=double.infinity,
   Color background=Colors.blue,
   bool isUpperCase=true,
   double raduis=0.0,
   required final function,
   required String text,
})=>
    Container(
      width: width,
      child: MaterialButton(
        onPressed: function,
        child: Text(
          isUpperCase ? text.toUpperCase() : text ,
          style: TextStyle(
            color: Colors.white,
      ),
    ),
  ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(raduis),
        color: background,
      ),
);

Widget defaultTextForm({
  required TextEditingController controller,
  required TextInputType type,
  bool isPassword=false,
  required String labelText,
  required final validate,
  required IconData prefix,
  final  suffixPressed,
  final onChanged,
  final onSubmit,
  final suffix,
  final onTap,
  bool isEnabled=true,
})=>TextFormField(
  controller: controller,
  keyboardType: type,
  onChanged:onChanged ,
  onFieldSubmitted: onSubmit,
  validator: validate,
  obscureText: isPassword,
  onTap: onTap,
  enabled: isEnabled,

  decoration: InputDecoration(
    labelText: labelText,
    border: OutlineInputBorder(),
    prefixIcon: Icon(
        prefix
    ),
    suffixIcon: suffix != null ? IconButton(
      onPressed: suffixPressed,
      icon: Icon(
          suffix
      ),
    ) : null,

  ),

);

Widget defaultTextButton({
  required final  function ,
  required String text
})=>TextButton(
    onPressed: function,
    child: Text(text.toUpperCase())
);

Widget myDivider()=>Padding(
  padding: const EdgeInsetsDirectional.only(start: 10,end: 10),
  child:   Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);


Widget buildNewsItem(article ,context,index) => InkWell(

  onTap: (){
          //enter on webView
    navigateTo(context, WebViewScreen(article['url']));

  },

  child:   Padding(



    padding: const EdgeInsets.all(20.0),



    child: Row(



      children: [



        Container(



          width: 160,



          height: 160,



          decoration: BoxDecoration(



            borderRadius:BorderRadius.circular(10),



            image: DecorationImage(



              image: NetworkImage('${article['urlToImage']}'),



              fit: BoxFit.cover,



            ),



          ),



        ),



        SizedBox(width: 20,),



        Expanded(



          child: Container(



            height: 160,



            child: Column(



              mainAxisSize: MainAxisSize.min,



              crossAxisAlignment: CrossAxisAlignment.start,



              children: [



                Expanded(



                  child: Text(



                    '${article['title']}',



                    maxLines: 3,



                    overflow: TextOverflow.ellipsis,



                    style: Theme.of(context).textTheme.bodyText1,



                  ),



                ),



                SizedBox(height: 10,),



                Text(



                  '${article['publishedAt']}',



                  style: Theme.of(context).textTheme.bodyText2,



                ),



              ],



            ),



          ),



        )



      ],



    ),



  ),

) ;

 // have listView
Widget articleBuilder(list,{isSearch=false}) => ConditionalBuilder(

  condition: list.length>0 ,

  builder: (context)=>ListView.separated(

      physics: BouncingScrollPhysics(),

      itemBuilder: (context,index)=>buildNewsItem(list[index],context,index),

      separatorBuilder:  (context,index)=>myDivider() ,

      itemCount: 10

  ),

  fallback: (context)=>isSearch  ? Container() : Center(child: CircularProgressIndicator()),

);

//to navigate between screen
void navigateTo(context,Widget)=>Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=>Widget)
);

void navigateFinish(context,Widget)=>Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=>Widget),
    (route) => false
);

void messageToast({
  required String msg,
  required ToastStates state
})=>
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 5,
        backgroundColor: ChooseToastColor(state),
        textColor: Colors.white,
        fontSize: 16.0
        );

enum ToastStates{SUCCESS,ERROR,WARNING}

Color ChooseToastColor(ToastStates state){
  Color color;

  switch(state){
    case ToastStates.SUCCESS:
      color=Colors.green;
      break;
    case ToastStates.ERROR:
      color=Colors.red;
      break;
    case ToastStates.WARNING:
      color=Colors.amber;
      break;
  }
  return color;

}




