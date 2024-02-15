import 'package:bloc_example/imports.dart';

abstract class HomeState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomeInit extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final dynamic result;
  final bool? isDeleted;

  HomeLoaded({this.result,this.isDeleted});
}

class HomeError extends HomeState {
  final dynamic error;

  HomeError({this.error});
}