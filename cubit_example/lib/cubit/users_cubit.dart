import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../common/api.dart';
import '../models/user.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  UsersCubit() : super(UsersState());

  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  Future<void> init() async {
    await refresh();
    trigger();
  }

  Future<void> refresh() async {
    emit(state.resetPage());
    await loadPerPage();
  }

  Future<void> loadPerPage() async {
    if (!state.isLoading) {
      startLoading();

      final items = await Api.users(state.page);

      if (items == null) {
        if (state.isFirstPage) {
          failed();
        }
      } else {
        if (items.isEmpty) {
          if (state.isFirstPage) {
            empty();
          } else {
            reachedMax();
          }
        } else {
          if (state.isFirstPage) {
            emit(state.replace(items: items));
          } else {
            emit(state.append(items: items));
          }
        }
      }

      stopLoading();
    }
  }

  void failed() {
    emit(state.failed());
  }

  void empty() {
    emit(state.empty());
  }

  void reachedMax() {
    emit(state.reachedMax());
  }

  void startLoading() {
    emit(state.startLoading());
  }

  void stopLoading() {
    emit(state.stopLoading());
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

  void dispose() {
    emit(state.reset());
  }
}
