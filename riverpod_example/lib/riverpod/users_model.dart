import 'package:equatable/equatable.dart';
import 'package:riverpod/riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../common/api.dart';
import '../models/user.dart';

part 'users_state.dart';

class UsersModel extends StateNotifier<UsersState> {
  UsersModel() : super(UsersState()) {
    init();
  }

  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  Future<void> init() async {
    await refresh();
    trigger();
  }

  Future<void> refresh() async {
    state = state.resetPage();
    await loadPerPage();
  }

  Future<void> loadPerPage() async {
    if (!state.isLoading) {
      state = state.startLoading();

      final items = await Api.users(state.page);

      if (items == null) {
        if (state.isFirstPage) {
          state = state.failed();
        }
      } else {
        if (items.isEmpty) {
          if (state.isFirstPage) {
            state = state.empty();
          } else {
            state = state.reachedMax();
          }
        } else {
          if (state.isFirstPage) {
            state = state.replace(items);
          } else {
            state = state.append(items);
          }
        }
      }

      state = state.stopLoading();
    }
  }

  void scrollToTop() {
    itemScrollController.scrollTo(
      index: 0,
      duration: Duration(milliseconds: 300),
    );
  }

  void trigger() {
    itemPositionsListener.itemPositions.addListener(() {
      final pos = itemPositionsListener.itemPositions.value;
      final lastIndex = state.count - 1;

      final isAtBottom = pos.last.index == lastIndex;
      final isLoadMore = isAtBottom && !state.hasReachedMax;

      // load data from the next page
      if (isLoadMore) {
        loadPerPage();
      }
    });
  }

  @override
  void dispose() {
    state = state.reset();
    super.dispose();
  }
}
