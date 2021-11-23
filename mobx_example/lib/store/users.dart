import 'package:mobx/mobx.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../common/api.dart';
import '../models/user.dart';

part 'users.g.dart';

class Users = _Users with _$Users;

abstract class _Users with Store {
  @observable
  int page = 1;

  @observable
  bool isEmpty = false;

  @observable
  bool isFailed = false;

  @observable
  bool isLoading = false;

  @observable
  bool hasReachedMax = false;

  @observable
  ObservableList<User> items = ObservableList.of([]);

  @computed
  int get count => items.length;

  bool get isFirstPage => page == 1;
  bool get isLoadingFirst => isLoading && isFirstPage;
  bool get isLoadingMore => isLoading && page > 1;

  User item(int index) => items.elementAt(index);

  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  @action
  Future<void> init() async {
    await refresh();
    trigger();
  }

  @action
  Future<void> refresh() async {
    page = 1;
    await loadPerPage();
  }

  @action
  Future<void> loadPerPage() async {
    if (!isLoading) {
      isLoading = true;

      final newItems = await Api.users(page);

      if (newItems == null) {
        if (isFirstPage) {
          isFailed = true;
        }
      } else {
        if (newItems.isEmpty) {
          if (isFirstPage) {
            isEmpty = true;
          } else {
            hasReachedMax = true;
          }
        } else {
          if (isFirstPage) {
            items.clear();
          }

          items.addAll(newItems);
          page = page + 1;

          isEmpty = false;
          hasReachedMax = false;
        }

        isFailed = false;
      }

      isLoading = false;
    }
  }

  @action
  void scrollToTop() {
    itemScrollController.scrollTo(
      index: 0,
      duration: Duration(milliseconds: 300),
    );
  }

  void trigger() {
    itemPositionsListener.itemPositions.addListener(() {
      final pos = itemPositionsListener.itemPositions.value;
      final lastIndex = count - 1;

      final isAtBottom = pos.last.index == lastIndex;
      final isLoadMore = isAtBottom && !hasReachedMax;

      // load data from the next page
      if (isLoadMore) {
        loadPerPage();
      }
    });
  }

  @action
  void dispose() {
    page = 1;
    isEmpty = false;
    isFailed = false;
    isLoading = false;
    hasReachedMax = false;
    items.clear();
  }
}
