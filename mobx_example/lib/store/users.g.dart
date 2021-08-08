// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Users on _Users, Store {
  Computed<int>? _$countComputed;

  @override
  int get count => (_$countComputed ??=
          Computed<int>(() => super.count, name: '_Users.count'))
      .value;

  final _$pageAtom = Atom(name: '_Users.page');

  @override
  int get page {
    _$pageAtom.reportRead();
    return super.page;
  }

  @override
  set page(int value) {
    _$pageAtom.reportWrite(value, super.page, () {
      super.page = value;
    });
  }

  final _$isEmptyAtom = Atom(name: '_Users.isEmpty');

  @override
  bool get isEmpty {
    _$isEmptyAtom.reportRead();
    return super.isEmpty;
  }

  @override
  set isEmpty(bool value) {
    _$isEmptyAtom.reportWrite(value, super.isEmpty, () {
      super.isEmpty = value;
    });
  }

  final _$isFailedAtom = Atom(name: '_Users.isFailed');

  @override
  bool get isFailed {
    _$isFailedAtom.reportRead();
    return super.isFailed;
  }

  @override
  set isFailed(bool value) {
    _$isFailedAtom.reportWrite(value, super.isFailed, () {
      super.isFailed = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_Users.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$hasReachedMaxAtom = Atom(name: '_Users.hasReachedMax');

  @override
  bool get hasReachedMax {
    _$hasReachedMaxAtom.reportRead();
    return super.hasReachedMax;
  }

  @override
  set hasReachedMax(bool value) {
    _$hasReachedMaxAtom.reportWrite(value, super.hasReachedMax, () {
      super.hasReachedMax = value;
    });
  }

  final _$itemsAtom = Atom(name: '_Users.items');

  @override
  ObservableList<User> get items {
    _$itemsAtom.reportRead();
    return super.items;
  }

  @override
  set items(ObservableList<User> value) {
    _$itemsAtom.reportWrite(value, super.items, () {
      super.items = value;
    });
  }

  final _$initAsyncAction = AsyncAction('_Users.init');

  @override
  Future<void> init() {
    return _$initAsyncAction.run(() => super.init());
  }

  final _$refreshAsyncAction = AsyncAction('_Users.refresh');

  @override
  Future<void> refresh() {
    return _$refreshAsyncAction.run(() => super.refresh());
  }

  final _$loadPerPageAsyncAction = AsyncAction('_Users.loadPerPage');

  @override
  Future<void> loadPerPage() {
    return _$loadPerPageAsyncAction.run(() => super.loadPerPage());
  }

  final _$_UsersActionController = ActionController(name: '_Users');

  @override
  void scrollToTop() {
    final _$actionInfo =
        _$_UsersActionController.startAction(name: '_Users.scrollToTop');
    try {
      return super.scrollToTop();
    } finally {
      _$_UsersActionController.endAction(_$actionInfo);
    }
  }

  @override
  void dispose() {
    final _$actionInfo =
        _$_UsersActionController.startAction(name: '_Users.dispose');
    try {
      return super.dispose();
    } finally {
      _$_UsersActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
page: ${page},
isEmpty: ${isEmpty},
isFailed: ${isFailed},
isLoading: ${isLoading},
hasReachedMax: ${hasReachedMax},
items: ${items},
count: ${count}
    ''';
  }
}
