import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlang/service/compiler/libs/whitespace.dart';
import 'package:vlang/service/compiler/models/variables.dart';
import 'package:vlang/service/controller.dart';

String kaattu(String statement, BuildContext context) {
  List<String> statements = statement.split('\n');
  print(statements);
  statements.forEach(
    (line) {
      if (line.contains("kaattu")) {
        
        if (line.contains("\"")) {
          line.replaceAll("kaattu ", "");

          List<String> printStatement = line.split("\"");
          Provider.of<CompilerController>(context, listen: false)
              .setOutput(printStatement[1]);
        }

        else if (line.contains("\$")) {

          
          List<String> printStatement = line.replaceAll("kaattu", "").split("\$");
          log("Print statement $printStatement");
          Variable variable = Provider.of<CompilerController>(context, listen: false).variables.where((element) => element.name.contains(removeWhitespace(printStatement[0]))).toList()[0];
          Provider.of<CompilerController>(context, listen: false)
              .setOutput(variable.value.toString());
        }
      }


    },
  );

  return "";
}
