import 'package:riverpod/riverpod.dart';
import 'riverpod/users_model.dart';

final usersModelProvider = StateNotifierProvider<UsersModel, UsersState>(
  (ref) => UsersModel(),
);
