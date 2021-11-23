part of 'user_bloc.dart';

enum UserStatus { initial, success, failed, empty }

class UserState extends Equatable {
  final int page;
  final bool hasReachedMax;
  final List<User> items;
  final UserStatus status;

  int get count => items.length;
  int get nextPage => page + 1;

  User item(int index) => items[index];

  UserState({
    this.page = 1,
    this.items = const [],
    this.hasReachedMax = false,
    this.status = UserStatus.initial,
  });

  UserState failed() => copyWith(status: UserStatus.failed);
  UserState empty() => copyWith(status: UserStatus.empty, hasReachedMax: true);
  UserState reachedMax() => copyWith(hasReachedMax: true);

  UserState append(List<User> items) => copyWith(
        status: UserStatus.success,
        items: [...this.items, ...items],
        page: nextPage,
        hasReachedMax: false,
      );

  UserState replace(List<User> items) => copyWith(
        status: UserStatus.success,
        items: items,
        page: 2,
        hasReachedMax: false,
      );

  UserState copyWith({
    UserStatus? status,
    List<User>? items,
    int? page,
    bool? hasReachedMax,
  }) {
    return UserState(
      status: status ?? this.status,
      items: items ?? this.items,
      page: page ?? this.page,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  List<Object> get props => [status, page, items, hasReachedMax];
}
