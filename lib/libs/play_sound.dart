import 'dart:io';

class Play {
  static void sound(String url) {
    Process.run("play", [url]);
  }
}
