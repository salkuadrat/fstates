import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../state/users_state.dart';
import '../widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late UsersState users;

  @override
  void initState() {
    super.initState();

    users = context.read<UsersState>();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      users.init();
    });
  }

  @override
  void dispose() {
    users.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Provider Example'),
      ),
      body: Consumer<UsersState>(
        builder: (context, users, __) {
          if (users.isFailed) {
            return Center(child: Text('Fetching data failed.'));
          }

          if (users.isEmpty) {
            return Center(child: Text('No data.'));
          }
          
          if (users.isLoadingFirst) {
            return Center(child: CircularProgressIndicator());
          }

          return RefreshIndicator(
            onRefresh: users.refresh,
            child: ScrollablePositionedList.builder(
              itemScrollController: users.itemScrollController,
              itemPositionsListener: users.itemPositionsListener,
              itemCount: users.count + 1,
              itemBuilder: (_, index) {
                bool isItem = index < users.count;
                bool isLastIndex = index == users.count;
                bool isLoadingMore = isLastIndex && users.isLoadingMore;
                // User Item
                if (isItem) return UserItem(users.item(index));
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
