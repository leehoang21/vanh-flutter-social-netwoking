import 'package:get/get.dart';

mixin GetArguments<T> {
  late final T? arguments = Get.arguments as T?;
}
