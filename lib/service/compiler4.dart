import 'dart:developer';

class Compiler {
  List<Map<String, dynamic>> variables = [];
  List<String> statements = [];

  static void compile(String code) {
    tokenize(code).forEach((element) {
      log("${element.value} --> ${element.type}");
    });
  }

  //tokenizer
  static List<Token> tokenize(String statement) {
    List<Token> tokens = [];
    final keywordPattern =
        RegExp(r"^(sey|kaattu|niruttu|kootu|kazhi|peruku|vagu)");
    final numberPattern = RegExp(r"[-+]?\d+(\.\d*)?");

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
          calculateSumAfterKootu(statement);
          tokens.add(Token(type: "ADDITION", value: "kootu"));
        } else if (match.group(0)! == "kazhi") {
          calculateSumAfterKazhi(statement);
          tokens.add(Token(type: "SUBTRACTION", value: "kazhi"));
        } else if (match.group(0)! == "peruku") {
          calculateSumAfterPeruku(statement);
          tokens.add(Token(type: "MULTIPLICATION", value: "peruku"));
        } else if (match.group(0)! == "vagu") {
          calculateSumAfterVagu(statement);
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

int calculateSumAfterKootu(String text) {
  final kootuPattern = RegExp(r"kootu\s+(\d+)(?:,\s*(\d+))?");
  final numberPattern = RegExp(r"\d+");

  int sum = 0;

  for (final match in kootuPattern.allMatches(text)) {
    int num1 = int.parse(match.group(1)!);
    int num2 = 0; // Optional second number
    if (match.group(2) != null) {
      num2 = int.parse(match.group(2)!);
    }
    sum += num1 + num2;
  }
  print(sum);
  return sum;
}

int calculateSumAfterKazhi(String text) {
  final kootuPattern = RegExp(r"kazhi\s+(\d+)(?:,\s*(\d+))?");
  final numberPattern = RegExp(r"\d+");

  int sum = 0;

  for (final match in kootuPattern.allMatches(text)) {
    int num1 = int.parse(match.group(1)!);
    int num2 = 0; // Optional second number
    if (match.group(2) != null) {
      num2 = int.parse(match.group(2)!);
    }
    sum += num1 - num2;
  }
  print(sum);
  return sum;
}

int calculateSumAfterPeruku(String text) {
  final kootuPattern = RegExp(r"peruku\s+(\d+)(?:,\s*(\d+))?");
  final numberPattern = RegExp(r"\d+");

  int sum = 0;

  for (final match in kootuPattern.allMatches(text)) {
    int num1 = int.parse(match.group(1)!);
    int num2 = 0; // Optional second number
    if (match.group(2) != null) {
      num2 = int.parse(match.group(2)!);
    }
    sum += num1 * num2;
  }
  print(sum);
  return sum;
}

int calculateSumAfterVagu(String text) {
  final kootuPattern = RegExp(r"vagu\s+(\d+)(?:,\s*(\d+))?");
  final numberPattern = RegExp(r"\d+");

  double sum = 0;

  for (final match in kootuPattern.allMatches(text)) {
    int num1 = int.parse(match.group(1)!);
    int num2 = 0; // Optional second number
    if (match.group(2) != null) {
      num2 = int.parse(match.group(2)!);
    }
    sum += num1 / num2;
  }
  print(sum);
  return sum.toInt();
}