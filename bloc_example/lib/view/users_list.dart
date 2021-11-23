import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class UsersList extends StatefulWidget {
  const UsersList({Key? key}) : super(key: key);

  @override
  _UsersListState createState() => _UsersListState();
}

class _UsersListState extends State<UsersList> {
  late UserBloc users;

  @override
  void initState() {
    super.initState();
    users = context.read<UserBloc>();
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      users.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bloc Example'),
      ),
      body: BlocBuilder<UserBloc, UserState>(
        builder: (_, state) {
          switch (state.status) {
            case UserStatus.failed:
              return Center(child: Text('Fetching data failed.'));
            case UserStatus.empty:
              return Center(child: Text('No data.'));
            case UserStatus.success:
              return RefreshIndicator(
                onRefresh: users.refresh,
                child: ScrollablePositionedList.builder(
                  itemScrollController: users.itemScrollController,
                  itemPositionsListener: users.itemPositionsListener,
                  itemCount: state.count + 1,
                  itemBuilder: (_, index) {
                    bool isItem = index < state.count;
                    bool isLastIndex = index == state.count;
                    bool isLoadingMore = isLastIndex && !state.hasReachedMax;
                    // User Item
                    if (isItem) return UserItem(state.item(index));
                    // Show loading more at the bottom
                    if (isLoadingMore) return LoadingMore();
                    // Default empty content
                    return Container();
                  },
                ),
              );
            default:
              return Center(child: CircularProgressIndicator());
          }
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
