import 'package:vlang/service/compiler/models/statement.dart';

class Compiler3 {
  //temp memory
  static List<Statement> statements = [];
  static List<Map<String, dynamic>> variables = [];

  //
  //
  //
  //
  //token defnition
  //Tokens
  static String Display = "\ndisplay";
  static String Variable = "data";
  static String EOF = "!";

  //flags
  static bool ADD = false;
  static bool SUB = false;
  //
  //
  //
  //
  //
  //
  //
  //Lexical analysis
  static lexicalAnalysis(List<String> rawStatements) {
    int i;
    for (i = 0; i > rawStatements.length; i++) {
      //
      //local memory
      List<String> localSemiTokens = [];
      // List<Map<String, dynamic>> localTokens = [];
      // List<Map<String, dynamic>> localVariables = [];
      //
      //
      //
      //

      //
      localSemiTokens = rawStatements[i].split(" ");
      if (localSemiTokens.contains(Variable)) {
        variables = [
          {
            localSemiTokens[localSemiTokens.indexOf(Variable) + 1]:
                localSemiTokens[localSemiTokens.indexOf(Variable) + 2],
          }
        ];
      }
    }
  }
}
