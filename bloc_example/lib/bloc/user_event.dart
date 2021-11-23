part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class UserFetched extends UserEvent {}

class UserRefreshed extends UserEvent {}
