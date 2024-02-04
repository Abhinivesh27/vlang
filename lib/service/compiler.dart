
class VlangCompiler {
  static List<Map<String, dynamic>> _variables = [];

  static dynamic compile(String code) {
    var tokens = _lex(code);
    var ast = _parse(tokens);
    _analyze(ast);
    var result = _execute(ast);
    return result;
  }

  static List<String> _lex(String code) {
    var lines = code.split('!');
    List<String> tokens = [];

    for (var line in lines) {
      var regex = RegExp(r'^Data\s+(\w+)\s*=\s*(.+)$');
      var match = regex.firstMatch(line);

      if (match != null) {
        tokens.add('Data');
        tokens.add(match.group(1) ?? "");
        tokens.add(match.group(2) ?? "");
      }

      regex = RegExp(r'^Display\s+(\w+)\s*!$');
      match = regex.firstMatch(line);

      if (match != null) {
        tokens.add('Display');
        tokens.add(match.group(1) ?? "");
      }
    }

    return tokens;
  }

  static List<Map<String, dynamic>> _parse(List<String> tokens) {
    List<Map<String, dynamic>> ast = [];

    for (var i = 0; i < tokens.length; i++) {
      if (tokens[i] == 'Data') {
        var variableName = tokens[++i];
        var variableValue = tokens[++i];
        ast.add({'type': 'Data', 'name': variableName, 'value': variableValue});
      } else if (tokens[i] == 'Display') {
        var variableName = tokens[++i];
        ast.add({'type': 'Display', 'name': variableName});
      }
    }

    return ast;
  }

  static void _analyze(List<Map<String, dynamic>> ast) {
    // Check for undefined variables
    var definedVariables = <String>{};
    for (var node in ast) {
      if (node['type'] == 'Data') {
        definedVariables.add(node['name']);
      } else if (node['type'] == 'Display') {
        if (!definedVariables.contains(node['name'])) {
          throw Exception('Undefined variable ${node['name']}');
        }
      }
    }
  }

  static dynamic _execute(List<Map<String, dynamic>> ast) {
    var result;
    for (var node in ast) {
      if (node['type'] == 'Data') {
        var variableName = node['name'];
        var variableValue = node['value'];

        // Parse variable value based on data type
        if (variableValue.contains('"')) {
          // String variable
          _variables.add({variableName: variableValue.replaceAll('"', '')});
        } else if (variableValue.contains('.')) {
          // Float variable
          _variables.add({variableName: double.parse(variableValue)});
        } else {
          // Integer variable
          _variables.add({variableName: int.parse(variableValue)});
        }
      } else if (node['type'] == 'Display') {
        var variableName = node['name'];
        var variable = _variables.firstWhere(
          (v) => v.containsKey(variableName),
          //
        );

        if (variable != null) {
          result = variable[variableName];
          print(result);
        } else {
          throw Exception('Undefined variable $variableName');
        }
      }
    }

    // Print all variables and their values
    // print('Variables:');
    // _variables
    //     .forEach((map) => map.forEach((key, value) => print('$key = $
  }
}
