class LogUtils {
  //dart.vm.product是否是release版本
  static bool isLog = !const bool.fromEnvironment("dart.vm.product");

  static void e(String tag, String message) {
    if (isLog) {
      print("$tag | $message");
    }
  }
}
