import 'dart:io';

class GetTemprature {
  static String processor() {
    ProcessResult data =
        Process.runSync("sensors", ["coretemp-isa-0000", "-A"]);
    return data.stdout.toString();
  }

  static String wifi() {
    ProcessResult data =
        Process.runSync("sensors", ["iwlwifi_1-virtual-0", "-A"]);
    return data.stdout.toString();
  }

  static String allSensors() {
    ProcessResult data = Process.runSync("sensors", ["-A"]);
    return data.stdout.toString();
  }
}
