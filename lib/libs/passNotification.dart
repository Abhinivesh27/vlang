import 'dart:developer';
import 'dart:io';

import 'package:vlang/main.dart';

class PassNotification {
  static void waitingFunction(
      bool needIcon, String title, String details) async {
    String sysinfo = "no info";
    var command = await Process.run("notify-send", [title, details]);
    //log(command.stdout.toString() + " Standered output");
  }

  static tell({
    bool needIcon = false,
    required String title,
    required String details,
  }) {
    log("Call Logged 1");
    waitingFunction(needIcon, title, details);
  }
}
