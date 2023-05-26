import 'dart:developer';
import 'dart:io';

import 'package:vlang/libs/getScreenshot.dart';
import 'package:vlang/libs/get_temprature.dart';
import 'package:vlang/libs/getraminfo.dart';
import 'package:vlang/libs/launchUrl.dart';
import 'package:vlang/libs/passNotification.dart';
import 'package:vlang/libs/play_sound.dart';
import 'package:vlang/libs/processes.dart';
import '../libs/getsysinfo.dart';

class Compiler {
  //Local Statement Memory Queue
  static List<String> statements = [''];

  //Local Variable Memory Queue
  static List<Map<String, dynamic>> variables = [];

  //Local STDOUT MEMORY QUEUE
  static List<String> stdOut = [];

  //Tokens
  static String Display = "\ndisplay";
  static String Variable = "data";
  static String EOF = "!";

  //flags
  static bool ADD = false;
  static bool SUB = false;

  //built-in feature tokens
  static String GetSysInfo = "LapInfo()";
  static String capture = "captureScreen()";
  static String tell = "tell";
  static String view = "view";
  static String play = "play -";
  static String getRamInfo = "getRamInfo()";
  static String getTemprature = "temperature";
  static String getProcesses = "process -";
  //
  //main function
  static List<String> compile(String code) {
    statements = [];
    variables = [];
    stdOut = [];
    //lexical analysis

    //seperate individual statements
    statements = code.split(EOF);

    //statement itration
    statements.forEach(
      (element) {
        //eleminating delimeter EOF
        if (element.isNotEmpty) {
          element = element.substring(0, element.length);
          List<String> localBuffer1 = element.split(" ");

          log("ELEMENT " + element.toString());
          //function tokanization
          if (element.contains(GetSysInfo)) {
            stdOut.add(GetSystemInfo.getSysInfo());
            log("New getsys info called");
          }
          if (element.contains(capture)) {
            log("CAPTURE CALLED");
            CaptureScreenshot.captureScreenshot();
            stdOut.add("Screen shot captured");
          }
          if (element.contains(tell)) {
            List<String> notifyArray = ["No data", "From VLang"];

            notifyArray = element.split(" - ");

            PassNotification.tell(
              title: notifyArray[1],
              details: notifyArray[2],
            );

            stdOut.add("Notification sent");
          }

          if (element.contains(view)) {
            List<String> notifyArray = ["No data", "From VLang"];

            notifyArray = element.split(" - ");

            Launch.url(notifyArray[1]);

            stdOut.add("${notifyArray[1]} launched");
          }

          if (element.contains(play)) {
            //
            List<String> notifyArray = ["No data", "From VLang"];

            notifyArray = element.split(" - ");

            Play.sound(notifyArray[1]);

            stdOut.add("Stream started");
          }
          //
          if (element.contains(getRamInfo)) {
            //
            List<String> notifyArray = ["No data", "From VLang"];

            stdOut.add(GetRamInfo.ram());
          }

          //processes
          if (element.contains(getProcesses)) {
            log("Called GET PROCESSESS");
            List<String> tempArray = ["No data"];
            tempArray = element.split(" - ");
            //processor
            if (tempArray[1] == "active") {
              String buffer3 = Processess.active();

              stdOut.add(buffer3);
              buffer3 = "";
            }
            if (tempArray[1] == "all") {
              String buffer3 = Processess.all();

              stdOut.add(buffer3);
              buffer3 = "";
            }
          }
          //

          //sensors
          if (element.contains(getTemprature)) {
            List<String> tempArray = ["No data"];
            tempArray = element.split(" - ");
            //processor
            if (tempArray.contains("processor")) {
              String buffer3 = GetTemprature.processor();

              stdOut.add(buffer3);
              buffer3 = "";
            } else if (tempArray.contains("all")) {
              String buffer3 = GetTemprature.allSensors();

              stdOut.add(buffer3);
              buffer3 = "";
            } else if (tempArray.contains("wifi")) {
              String buffer3 = GetTemprature.wifi();

              stdOut.add(buffer3);
              buffer3 = "";
            }
          }
          //
          //
          //
          //variable tokanization
          //
          //
          //
          if (localBuffer1.contains(Variable)) {
            //check for duplicate variable names
            // checks for empty varibales queue
            if (variables.length != 0) {
              for (int i = 0; i > variables.length; i++) {
                // if (variables[i][localBuffer1[1].isEmpty]) {
                //   //int parsing

                //   variables.add({localBuffer1[1]: localBuffer1[3]});
                // } else {
                if (localBuffer1.contains("add")) {
                  log("CALLED 1");
                  ADD = true;
                  log(localBuffer1.toString());
                  variables.add(
                    {
                      localBuffer1[1]: int.parse(localBuffer1[3]) +
                          int.parse(localBuffer1[5]),
                    },
                  );
                } else if (localBuffer1.contains(capture)) {
                  // GetSystemInfo.getSysInfo();
                  CaptureScreenshot.captureScreenshot();
                  stdOut.add("Screen snhot captured");
                  //variables.add({"getSysInfo": GetSysInfo});

                  //
                  //
                } else if (localBuffer1.contains(GetSysInfo)) {
                  // GetSystemInfo.getSysInfo();
                  stdOut.add(GetSystemInfo.getSysInfo());
                  //variables.add({"getSysInfo": GetSysInfo});

                  log("Get Sysinfo line 72 called");
                  //
                  //
                } else if (localBuffer1.contains("sub")) {
                  log("CALLED sub");
                  SUB = true;
                  log(localBuffer1.toString());
                  variables.add(
                    {
                      localBuffer1[1]: int.parse(localBuffer1[3]) -
                          int.parse(localBuffer1[5]),
                    },
                  );
                } else if (localBuffer1.contains("div")) {
                  log("CALLED Div");
                  SUB = true;
                  log(localBuffer1.toString());
                  variables.add(
                    {
                      localBuffer1[1]: int.parse(localBuffer1[3]) /
                          int.parse(localBuffer1[5]),
                    },
                  );
                } else if (localBuffer1.contains("mul")) {
                  log("CALLED MUl");
                  SUB = true;
                  log(localBuffer1.toString());
                  variables.add(
                    {
                      localBuffer1[1]: int.parse(localBuffer1[3]) *
                          int.parse(localBuffer1[5]),
                    },
                  );
                } else {
                  log("CALLED #");
                  variables[i] = {localBuffer1[1]: localBuffer1[3]};
                }
              }
            } else {
              log(localBuffer1.toString());
              if (localBuffer1.contains("add")) {
                log("CALLED 2");
                ADD = true;
                log(localBuffer1.toString());
                variables.add(
                  {
                    localBuffer1[1]: int.parse(localBuffer1[3]) +
                        int.parse(
                          localBuffer1[5],
                        ),
                  },
                );
              } else if (localBuffer1.contains(capture)) {
                // GetSystemInfo.getSysInfo();
                CaptureScreenshot.captureScreenshot();
                stdOut.add("Screen snhot captured");
                //variables.add({"getSysInfo": GetSysInfo});

                log("Capture called");
                //
                //
              } else if (localBuffer1.contains(GetSysInfo)) {
                // GetSystemInfo.getSysInfo();
                stdOut.add(GetSystemInfo.getSysInfo());
                //variables.add({"getSysInfo": GetSysInfo});

                log("Get Sysinfo line 72 called");
                //
                //
              } else if (localBuffer1.contains("div")) {
                log("CALLED Div");
                SUB = true;
                log(localBuffer1.toString());
                variables.add(
                  {
                    localBuffer1[1]:
                        int.parse(localBuffer1[3]) / int.parse(localBuffer1[5]),
                  },
                );
              } else if (localBuffer1.contains("sub")) {
                log("CALLED SUB 23");
                SUB = true;
                log(localBuffer1.toString());
                variables.add(
                  {
                    localBuffer1[1]: (int.parse(localBuffer1[3]) -
                        int.parse(
                          localBuffer1[5],
                        )),
                  },
                );
                log("Variables" + variables.toString());
              } else if (localBuffer1.contains("mul")) {
                log("CALLED MUl");
                SUB = true;
                log(localBuffer1.toString());
                variables.add(
                  {
                    localBuffer1[1]:
                        int.parse(localBuffer1[3]) * int.parse(localBuffer1[5]),
                  },
                );
              } else {
                log('CALLED &');
                variables.add({localBuffer1[1]: localBuffer1[3]});
              }
            }
          }

          //INT PARSING
          // else if (localBuffer1.contains("ADD")) {
          //   ADD = true;
          // }
          //STDOUT Display tokanization

          else if (localBuffer1.contains(Display)) {
            dynamic DisplayBuffer;

            //DISPLAY Token itration
            variables.forEach((element) {
              DisplayBuffer = element[localBuffer1[1]];
            });

            //STDOUT formating
            //stdOut.add(variables.toString());
            if (DisplayBuffer != null) {
              String localBuffer2 = DisplayBuffer.toString();
              log(ADD.toString());
              if (localBuffer2.contains("\"")) {
                log("CALLED 6");
                stdOut.add(DisplayBuffer.split("\"").toList()[1]);
              } else if (ADD || SUB) {
                log("CALLED 5");
                stdOut.add(DisplayBuffer.toString());
              } else if (localBuffer2.contains(capture)) {
                //get screen capture

                CaptureScreenshot.captureScreenshot();
              } else if (localBuffer2.contains(GetSysInfo)) {
                //get sys info implementation

                stdOut.add(GetSystemInfo.getSysInfo());
              } else {
                log("CALLED 4");
                stdOut.add(localBuffer2.toString());
              }
            }
          }
        }
      },
    );

    return stdOut;
  }
}
