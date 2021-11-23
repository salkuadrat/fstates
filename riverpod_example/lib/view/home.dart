import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../providers.dart';
import '../widgets/widgets.dart';

class Home extends ConsumerWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final users = ref.read(usersProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('Riverpod Example'),
      ),
      body: Consumer(
        builder: (_, watch, __) {
          final state = ref.watch(usersProvider);

          if (state.isFailed) {
            return Center(child: Text('Fetching data failed.'));
          }

          if (state.isEmpty) {
            return Center(child: Text('No data.'));
          }

          if (state.isLoadingFirst) {
            return Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: users.refresh,
            child: ScrollablePositionedList.builder(
              itemScrollController: users.itemScrollController,
              itemPositionsListener: users.itemPositionsListener,
              itemCount: state.count + 1,
              itemBuilder: (_, index) {
                bool isItem = index < state.count;
                bool isLastIndex = index == state.count;
                bool isLoadingMore = isLastIndex && state.isLoadingMore;
                // User Item
                if (isItem) return UserItem(state.item(index));
                // Show loading more at the bottom
                if (isLoadingMore) return LoadingMore();
                // Default empty content
                return Container();
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: users.scrollToTop,
        tooltip: 'Scroll to top',
        child: Icon(Icons.arrow_upward_rounded),
      ),
    );
  }
}
