import 'package:internet_connection_checker/internet_connection_checker.dart';

class Internet {
  static Future<bool> temNet() async {
    bool result = await InternetConnectionChecker().hasConnection;

    return result;
  }
}
