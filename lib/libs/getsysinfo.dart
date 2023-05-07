import 'dart:developer';
import 'dart:io';

import 'package:vlang/main.dart';

class GetSystemInfo {
  static String mainData = "";

  static void waitingFunction() async {
    String sysinfo = "no info";
    var command = await Process.run("uname", ["-a"]);
    log(command.stdout.toString() + " Standered output");
    sysinfo = await command.stdout;

    mainData = sysinfo;
  }

  static String getSysInfo() {
    waitingFunction();
    String sysinfo = "no info";
    sysinfo = mainData;
    return mainData;
  }
}
