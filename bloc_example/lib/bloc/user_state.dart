part of 'user_bloc.dart';

enum UserStatus { initial, success, failure, empty }

class UserState extends Equatable {

  final int page;
  final bool hasReachedMax;
  final List<User> users;
  final UserStatus status;

  int get count => users.length;
  User item(int index) => users[index];

  UserState({
    this.page = 1,
    this.users = const [],
    this.hasReachedMax = false,
    this.status = UserStatus.initial,
  });

  UserState copyWith({
    UserStatus? status,
    List<User>? users,
    int? page,
    bool? hasReachedMax,
  }) {
    return UserState(
      status: status ?? this.status,
      users: users ?? this.users,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, page, users, hasReachedMax];
}