import 'package:get/get.dart';

import '../bindings/home_bindings.dart';
import '../view/home.dart';

final List<GetPage> routes = [
  GetPage(name: '/', page: () => Home(Get.find()), binding: HomeBindings()),
];
