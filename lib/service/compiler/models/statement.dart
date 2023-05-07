import 'package:vlang/service/compiler/models/error.dart';

class Statement {
  //token defnition
  String statement = "";
  List<Map<String, dynamic>> tokens = [];
  List<Map<String, dynamic>> variables = [];
  List<Errors> errors = [];
  List<String> builtInFunctions = [];
  String stdout = "";
  //
}
