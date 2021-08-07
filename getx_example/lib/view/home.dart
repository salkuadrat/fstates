import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../controllers/home_controller.dart';
import '../widgets/widgets.dart';

class Home extends StatelessWidget {
  final HomeController controller;

  const Home(this.controller, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () {
            if (controller.isFailed) {
              return Center(child: Text('Fetching data failed.'));
            }

            if (controller.isEmpty) {
              return Center(child: Text('No data.'));
            }

            if (controller.isLoadingFirst) {
              return Center(child: CircularProgressIndicator());
            }

            return RefreshIndicator(
              onRefresh: controller.refresh,
              child: ScrollablePositionedList.builder(
                itemScrollController: controller.itemScrollController,
                itemPositionsListener: controller.itemPositionsListener,
                itemCount: controller.count + 1,
                itemBuilder: (_, index) {
                  bool isItem = index < controller.count;
                  bool isLastIndex = index == controller.count;
                  bool isLoadingMore = isLastIndex && !controller.hasReachedMax;
                  // User Item
                  if (isItem) return UserItem(controller.item(index));
                  // Show loading more at the bottom
                  if (isLoadingMore) return LoadingMore();
                  // Default empty content
                  return Container();
                },
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.scrollToTop,
        tooltip: 'Scroll to top',
        child: Icon(Icons.arrow_upward_rounded),
      ),
    );
  }
}
