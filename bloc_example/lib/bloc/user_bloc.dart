import 'dart:async';

import 'package:bloc_example/common/api.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  UserBloc() : super(UserState());

  ItemScrollController itemScrollController = ItemScrollController();
  ItemPositionsListener itemPositionsListener = ItemPositionsListener.create();

  void init() {
    add(UserFetched());
    trigger();
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
        add(UserFetched());
      }
    });
  }

  Future<void> refresh() async {
    add(UserRefreshed());
  }

  @override
  Stream<Transition<UserEvent, UserState>> transformEvents(
    Stream<UserEvent> events,
    TransitionFunction<UserEvent, UserState> transitionFn,
  ) {
    return super.transformEvents(
      events.throttleTime(Duration(milliseconds: 500)),
      transitionFn,
    );
  }

  @override
  Stream<UserState> mapEventToState(UserEvent event) async* {
    if (event is UserFetched) {
      yield await _mapUserFetchedToState(state);
    } else if (event is UserRefreshed) {
      yield await _mapUserRefreshedToState(state);
    }
  }

  Future<UserState> _mapUserFetchedToState(UserState state) async {
    if (state.hasReachedMax) {
      return state;
    }

    final items = await Api.users(state.page);

    if (items == null) {
      if (state.status == UserStatus.initial) {
        return state.failed();
      } else {
        return state;
      }
    }

    if (items.isEmpty) {
      if (state.status == UserStatus.initial) {
        return state.empty();
      } else {
        return state.reachedMax();
      }
    }

    return state.append(items);
  }

  Future<UserState> _mapUserRefreshedToState(UserState state) async {
    final items = await Api.users(1);

    if (items == null || items.isEmpty) {
      return state;
    }

    return state.replace(items);
  }
}
