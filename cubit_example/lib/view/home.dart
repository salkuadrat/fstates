import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import '../cubit/cubit.dart';
import '../widgets/widgets.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  
  late UsersCubit users;

  @override
  void initState() {
    super.initState();

    users = context.read<UsersCubit>();
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
      body: SafeArea(
        child: BlocBuilder<UsersCubit, UsersState>(
          builder: (context, state) {
            UsersCubit users = context.read<UsersCubit>();

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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: users.scrollToTop,
        tooltip: 'Scroll to top',
        child: Icon(Icons.arrow_upward_rounded),
      ),
    );
  }
}
