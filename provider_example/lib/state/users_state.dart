import 'package:flutter/foundation.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../common/api.dart';
import '../models/user.dart';

class UsersState extends ChangeNotifier {
  int _page = 1;
  List<User> _items = [];

  bool _isEmpty = false;
  bool _isFailed = false;
  bool _isLoading = false;
  bool _hasReachedMax = false;

  ItemScrollController _itemScrollController = ItemScrollController();
  ItemPositionsListener _itemPositionsListener = ItemPositionsListener.create();

  int get page => _page;
  int get count => _items.length;
  List<User> get items => _items;

  bool get isEmpty => _isEmpty;
  bool get isFailed => _isFailed;
  bool get isLoading => _isLoading;
  bool get hasReachedMax => _hasReachedMax;

  bool get isFirstPage => _page == 1;
  bool get isLoadingFirst => _isLoading && isFirstPage;
  bool get isLoadingMore => _isLoading && _page > 1;

  ItemScrollController get itemScrollController => _itemScrollController;
  ItemPositionsListener get itemPositionsListener => _itemPositionsListener;

  User item(int index) => _items[index];

  Future<void> init() async {
    await refresh();
    trigger();
  }

  Future<void> refresh() async {
    _page = 1;
    await loadPerPage();
  }

  Future<void> loadPerPage() async {
    if (!_isLoading) {
      startLoading();

      final items = await Api.users(_page);

      if (items == null) {
        if (isFirstPage) {
          _isFailed = true;
        }
      } else {
        if (items.isEmpty) {
          if (isFirstPage) {
            _isEmpty = true;
          } else {
            _hasReachedMax = true;
          }
        } else {
          // if first page, replace _items with items
          // if loading more, add all items to _items
          _items = isFirstPage ? items : [..._items, ...items];
          _page = _page + 1;
          
          _isEmpty = false;
          _hasReachedMax = false;
        }

        _isFailed = false;
      }

      notifyListeners();
      stopLoading();
    }
  }

  void startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  void stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  void scrollToTop() {
    _itemScrollController.scrollTo(
      index: 0,
      duration: Duration(milliseconds: 300),
    );
  }

  void trigger() {
    _itemPositionsListener.itemPositions.addListener(() {
      final pos = _itemPositionsListener.itemPositions.value;
      final lastIndex = count - 1;

      final isAtBottom = pos.last.index == lastIndex;
      final isLoadMore = isAtBottom && !hasReachedMax;

      // load data from the next page
      if (isLoadMore) {
        loadPerPage();
      }
    });
  }

  @override
  void dispose() {
    _page = 1;
    _items = [];
    _isEmpty = false;
    _isFailed = false;
    _isLoading = false;
    super.dispose();
  }
}
