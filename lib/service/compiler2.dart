import 'dart:developer';
import 'dart:io';

class Compiler {
  //Local Statement Memory Queue
  static List<String> statements = [''];

  //Local Variable Memory Queue
  static List<Map<String, dynamic>> variables = [];

  //Local STDOUT MEMORY QUEUE
  static List<String> stdOut = [];

  //Tokens
  static String Display = "\nDisplay";
  static String Variable = "Data";
  static String EOF = "!";

  //flags
  static bool ADD = false;
  static bool SUB = false;

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

          //variable tokanization
          if (localBuffer1.contains(Variable)) {
            //check for duplicate variable names
            // checks for empty varibales queue
            if (variables.length != 0) {
              for (int i = 0; i > variables.length; i++) {
                // if (variables[i][localBuffer1[1].isEmpty]) {
                //   //int parsing

                //   variables.add({localBuffer1[1]: localBuffer1[3]});
                // } else {
                if (localBuffer1.contains(" add")) {
                  log("CALLED 1");
                  ADD = true;
                  log(localBuffer1.toString());
                  variables.add(
                    {
                      localBuffer1[1].substring(1):
                          int.parse(localBuffer1[3].substring(1)) +
                              int.parse(localBuffer1[5].substring(1)),
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
