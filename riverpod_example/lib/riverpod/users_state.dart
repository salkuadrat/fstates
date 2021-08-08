part of 'users_model.dart';

class UsersState extends Equatable {
  final int page;
  final bool isEmpty;
  final bool isFailed;
  final bool isLoading;
  final bool hasReachedMax;
  final List<User> items;

  UsersState({
    this.page = 1,
    this.isEmpty = false,
    this.isFailed = false,
    this.isLoading = false,
    this.hasReachedMax = false,
    this.items = const [],
  });

  int get count => items.length;
  int get nextPage => page + 1;

  bool get isFirstPage => page == 1;
  bool get isLoadingFirst => isLoading && isFirstPage;
  bool get isLoadingMore => isLoading && page > 1;

  User item(int index) => items[index];

  UsersState reset() => copyWith(
        page: 1,
        items: [],
        isLoading: false,
        isEmpty: false,
        isFailed: false,
        hasReachedMax: false,
      );

  UsersState resetPage() => copyWith(page: 1);
  UsersState startLoading() => copyWith(isLoading: true);
  UsersState stopLoading() => copyWith(isLoading: false);
  UsersState empty() => copyWith(isEmpty: true, isFailed: false);
  UsersState failed() => copyWith(isFailed: true);
  UsersState reachedMax() => copyWith(hasReachedMax: true, isFailed: false);

  UsersState replace(List<User> items) => copyWith(
        items: items,
        page: 2,
        isEmpty: false,
        isFailed: false,
        hasReachedMax: false,
      );

  UsersState append(List<User> items) => copyWith(
        items: [...this.items, ...items],
        page: nextPage,
        isEmpty: false,
        isFailed: false,
        hasReachedMax: false,
      );

  UsersState copyWith({
    int? page,
    bool? isEmpty,
    bool? isFailed,
    bool? isLoading,
    bool? hasReachedMax,
    List<User>? items,
  }) {
    return UsersState(
      page: page ?? this.page,
      isEmpty: isEmpty ?? this.isEmpty,
      isFailed: isFailed ?? this.isFailed,
      isLoading: isLoading ?? this.isLoading,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      items: items ?? this.items,
    );
  }

  @override
  List<Object?> get props =>
      [page, items, isEmpty, isFailed, isLoading, hasReachedMax];
}