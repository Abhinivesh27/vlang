import 'dart:io';

class GetRamInfo {
  static String ram() {
    ProcessResult data = Process.runSync("free", []);

    return data.stdout.toString();
  }
}
