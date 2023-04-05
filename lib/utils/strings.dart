import 'dart:convert';

import 'app_localizations.dart';

class StringUtils {
  static String enumName(String enumToString) {
    List<String> paths = enumToString.split(".");
    return paths[paths.length - 1];
  }

  static String numberZeroPad(int number) {
    if (number.toString().length == 1) {
      return "0$number";
    } else {
      return number.toString();
    }
  }
}


extension Base64Convert on String{
  String toBase64(){
    final str = this;
    final bytes = utf8.encode(str);
    final base64Str = base64.encode(bytes);
    return base64Str;
  }

  String base64ToString(){
    final base64Str = this;
    final bytes = base64.decode(base64Str);
    final str = utf8.decode(bytes);
    return str;
  }
}
