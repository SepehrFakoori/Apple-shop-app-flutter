part of 'category_bloc.dart';

abstract class CategoryState {}

class CategoryInitState extends CategoryState {}

class CategoryResponseState extends CategoryState {
  var response;
  CategoryResponseState(this.response);
}

class CategoryLoadingState extends CategoryState {}
