import 'dart:io';

class Processess {
  static String active() {
    ProcessResult data = Process.runSync("ps", []);

    return data.stdout.toString();
  }

  static String all() {
    ProcessResult data = Process.runSync("ps", ["aux"]);

    return data.stdout.toString();
  }
}
