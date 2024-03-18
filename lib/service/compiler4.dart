import 'dart:developer';
import 'package:vlang/service/compiler/libs/kaattu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlang/service/compiler/libs/whitespace.dart';
import 'package:vlang/service/controller.dart';

class Compiler {
  List<Map<String, dynamic>> variables = [];
  List<String> statements = [];

  static void compile(String code, BuildContext context) {
    //module1 --> LEXICAL ANALYSIS
    tokenize(code, context).forEach((element) {
      log("${element.value} --> ${element.type}");
    });

    //module2 --> SYNTAX ANALYSIS
    !syntaxAnalyzer(code, context) ? execution_unit(code, context) : () {};
  }

  //tokenizer - LEXICAL ANALYSIS
  static List<Token> tokenize(String statement, BuildContext context) {
    List<Token> tokens = [];
    final keywordPattern =
        RegExp(r"^(sey|kaattu|niruttu|kootu|kazhi|peruku|vagu)");
    final numberPattern = RegExp(r"[-+]?\d+(\.\d*)?");
  //set variable
    statement.split("\n").forEach(
      (element) {
        if (element.contains("maatri")) {
          int varIndex = element.indexOf("maatri");
          List<String> rawInput = element.split("=");
          print("EDITED -> " + rawInput[0].replaceRange(0, 6, ""));

          Provider.of<CompilerController>(context, listen: false).setVariable(
              rawInput[0].replaceRange(0, 6, ""),
              rawInput[1].replaceAll("\"", "").replaceAll("!", ""));

          print(rawInput);
        } else {}
      },
    );
    for (final line in statement.split('\n')) {
      final match = keywordPattern.firstMatch(line);
      if (match != null) {
        if (match.group(0)! == "sey") {
          tokens.add(Token(type: "START OF PROGRAM", value: "sey"));
        } else if (match.group(0)! == "kaattu") {
          tokens.add(Token(type: "PRINT", value: "kaattu"));
        } else if (match.group(0)! == "niruttu") {
          tokens.add(Token(type: "END OF PROGRAM", value: "niruttu"));
        } else if (match.group(0)! == "kootu") {
          calculateSumAfterKootu(line, context);
          tokens.add(Token(type: "ADDITION", value: "kootu"));
        } else if (match.group(0)! == "kazhi") {
          calculateSumAfterKazhi(line, context);
          tokens.add(Token(type: "SUBTRACTION", value: "kazhi"));
        } else if (match.group(0)! == "peruku") {
          calculateSumAfterPeruku(line, context);
          tokens.add(Token(type: "MULTIPLICATION", value: "peruku"));
        } else if (match.group(0)! == "vagu") {
          calculateSumAfterVagu(line, context);
          tokens.add(Token(type: "DIVISION", value: "vagu"));
        } 

        //print(match.group(0)!);
      }
    }
    for (final match in numberPattern.allMatches(statement)) {
      tokens.add(Token(type: "Number", value: match.group(0)!));
    }

    

    return tokens;
  }
}

class Token {
  final String type;
  final String value;

  Token({required this.type, required this.value});
}

void calculateSumAfterKootu(String text, BuildContext context) {
  final kootuPattern = RegExp(r"kootu\s+(\d+)(?:,\s*(\d+))?");
  List<String> statement = text.replaceAll("!", "").split("\n");
  List<String> line = text.replaceAll("kootu", "").replaceAll("!", "").split(",");
  
  Provider.of<CompilerController>(context,listen: false).addVars(line[0].replaceAll("\$", ""), line[1].replaceAll("\$", ""));
  
}

void calculateSumAfterKazhi(String text, BuildContext context) {
  final kootuPattern = RegExp(r"kazhi\s+(\d+)(?:,\s*(\d+))?");
  List<String> line = text.replaceAll("kazhi", "").replaceAll("!", "").split(",");
  Provider.of<CompilerController>(context,listen: false).subVars(line[0].replaceAll("\$", ""), line[1].replaceAll("\$", ""));
}

void calculateSumAfterPeruku(String text, BuildContext context) {
  final kootuPattern = RegExp(r"peruku\s+(\d+)(?:,\s*(\d+))?");
  List<String> line = text.replaceAll("peruku", "").replaceAll("!", "").split(",");
  Provider.of<CompilerController>(context,listen: false).multiVars(line[0].replaceAll("\$", ""), line[1].replaceAll("\$", ""));
}

void calculateSumAfterVagu(String text, BuildContext context) {
  final kootuPattern = RegExp(r"vagu\s+(\d+)(?:,\s*(\d+))?");
 List<String> line = text.replaceAll("vagu", "").replaceAll("!", "").split(",");
  Provider.of<CompilerController>(context,listen: false).divVars(line[0].replaceAll("\$", ""), line[1].replaceAll("\$", ""));
}

//SYNTAX ANALYSIS
bool syntaxAnalyzer(String text, BuildContext context) {
  List<String> keywords = [
    "sey",
    "kaattu",
    "niruttu",
    "kootu ",
    "kazhi ",
    "peruku ",
    "vagu ",
  ];
  final keywordPattern =
      RegExp(r"^(sey|kaattu|niruttu|kootu|kazhi|peruku|vagu|\d+|,|\s+)$");

  final lines = text.split('\n');
  bool errors = false;
  for (final line in lines) {
    final cleanLine = line.replaceAll(keywordPattern, "");
    final unknownWords = cleanLine.split(" ");
    if (line.contains("sey") || line.contains("niruttu")) {
    } else {
      if (!line.endsWith("!")) {
        errors = true;
        Provider.of<CompilerController>(context, listen: false)
            .setError("! missing at end of a line");
      }
    }
    for (final word in unknownWords) {
      if (word.isNotEmpty) {
        word.replaceAll(",", "");
        word.replaceAll(" ", "");
        keywords.forEach(
          (element) {
            word.replaceAll(element, "");
          },
        );
      }
    }

    if (text.split("\n").toList().first != keywords[0]) {
      Provider.of<CompilerController>(context, listen: false)
          .setError("PROGRAM NOT STARTED PROPERLY");
      log("PROGRAM NOT STARTED PROPERLY");
      errors = true;
    }
    if (text.split("\n").toList()[text.split("\n").toList().length - 1] !=
        keywords[2]) {
      Provider.of<CompilerController>(context, listen: false)
          .setError("PROGRAM NOT ENDED PROPERLY");
      log("PROGRAM NOT ENDED PROPERLY ");
      errors = true;
    }
  }
  return errors;
}

void execution_unit(String code, BuildContext context) {
  if (code.contains("kaattu")) {
    kaattu(code, context);
  }

  else if (code.contains("android")) {
          Provider.of<CompilerController>(context,listen: false).androidManager(
            code.split('\n').toList().where((element) => element.contains("android")).toList()[0].replaceAll("!", "").replaceAll("android", "").split(" ")
          );
        }
}
