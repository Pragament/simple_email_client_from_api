import 'package:flutter/foundation.dart';

void printInDebug(dynamic content) {
  if (kDebugMode) {
    print(content);
  }
}
