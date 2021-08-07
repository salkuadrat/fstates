import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../common/api.dart';
import '../models/user.dart';

class HomeController extends GetxController {
  final _page = 1.obs;
  final _users = <User>[].obs;
  final _isEmpty = false.obs;
  final _isFailed = false.obs;
  final _isLoading = false.obs;
  final _hasReachedMax = false.obs;

  HomeController();

  int get page => _page.value;
  int get count => _users.length;
  bool get isFirstPage => page == 1;
  bool get isEmpty => _isEmpty.value;
  bool get isFailed => _isFailed.value;
  bool get isLoading => _isLoading.value;
  bool get isLoadingFirst => isLoading && isFirstPage;
  bool get hasReachedMax => _hasReachedMax.value;
  List<User> get users => _users.toList();

  User item(int index) => _users[index];

  late ItemScrollController itemScrollController;
  late ItemPositionsListener itemPositionsListener;

  @override
  void onInit() {
    _init();
    super.onInit();
  }

  Future<void> _init() async {
    itemScrollController = ItemScrollController();
    itemPositionsListener = ItemPositionsListener.create();
    await _loadPerPage();
    trigger();
  }

  Future<void> _loadPerPage() async {
    if (!isLoading) {
      startLoading();

      final items = await Api.users(page);

      if (items == null) {
        if (isFirstPage) {
          _isFailed.value = true;
        }
      } else {
        if (items.isEmpty) {
          if (page == 1) {
            _isEmpty.value = true;
          } else {
            _hasReachedMax.value = true;
          }
        } else {
          _users.addAll(items);
          _page.value = _page.value + 1;

          _isEmpty.value = false;
          _hasReachedMax.value = false;
        }

        _isFailed.value = false;
      }

      stopLoading();
    }
  }

  Future<void> refresh() async {
    _page.value = 1;
    _users.clear();
    await _loadPerPage();
  }

  void startLoading() {
    _isLoading.value = true;
  }

  void stopLoading() {
    _isLoading.value = false;
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
      final lastIndex = count - 1;

      final isAtBottom = pos.last.index == lastIndex;
      final isLoadMore = isAtBottom && !hasReachedMax;

      // load data from the next page
      if (isLoadMore) {
        _loadPerPage();
      }
    });
  }
}
