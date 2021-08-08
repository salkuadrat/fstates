import 'package:riverpod/riverpod.dart';
import 'riverpod/users_model.dart';

final usersProvider = StateNotifierProvider<UsersModel, UsersState>(
  (ref) => UsersModel(),
);
