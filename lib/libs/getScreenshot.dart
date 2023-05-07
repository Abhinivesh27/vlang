import 'dart:developer';
import 'dart:io';

class CaptureScreenshot {
  static String mainData = "";

  static void waitingFunction() async {
    String sysinfo = "no info";
    var command = await Process.run(
        "import", ["-window", "root", "/home/abhi/Documents/pic.png"]);
    log("Main Capture function called");
    //log(command.stdout.toString() + " Standered output");
    sysinfo = await command.stdout;

    mainData = sysinfo;
  }

  static void captureScreenshot() {
    //return mainData;
    waitingFunction();
  }
}
