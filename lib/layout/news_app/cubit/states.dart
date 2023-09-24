abstract class NewsStates {}

class InitialNews extends NewsStates{}

class ChangeNews extends NewsStates{}

class ChangeBottomNavBar extends NewsStates{}


class NewsGetBusinessLoadingState extends NewsStates{}

class NewsGetBusinessSuccessState extends NewsStates{}

class NewsGetBusinessErrorState extends NewsStates{
  final error;

  NewsGetBusinessErrorState(this.error);
}

class NewsSelectBusinessItemState extends NewsStates{}

class NewsSetDesktopState extends NewsStates{}


class NewsGetSportsLoadingState extends NewsStates{}

class NewsGetSportsSuccessState extends NewsStates{}

class NewsGetSportsErrorState extends NewsStates{
  final error;

  NewsGetSportsErrorState(this.error);
}


class NewsGetScienceLoadingState extends NewsStates{}

class NewsGetScienceSuccessState extends NewsStates{}

class NewsGetScienceErrorState extends NewsStates{
  final error;

  NewsGetScienceErrorState(this.error);
}


class NewsGetSearchLoadingState extends NewsStates{}

class NewsGetSearchSuccessState extends NewsStates{}

class NewsGetSearchErrorState extends NewsStates{
  final error;

  NewsGetSearchErrorState(this.error);
}
class NewsChangeMode extends NewsStates{}