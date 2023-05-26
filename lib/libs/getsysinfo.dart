import 'dart:developer';
import 'dart:io';

import 'package:vlang/main.dart';

class GetSystemInfo {
  static String getSysInfo() {
    //String sysinfo = "no info";
    ProcessResult sysinfo = Process.runSync("uname", ["-a"]);
    return sysinfo.stdout.toString();
  }
}
