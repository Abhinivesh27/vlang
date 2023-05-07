import 'dart:io';

class Launch {
  static void url(String url) async {
    Process.run("google-chrome", [url]);
  }
}
