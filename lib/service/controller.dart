import 'dart:collection';
import 'dart:convert';
import 'dart:developer';
import 'dart:io' as io;
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:vlang/service/compiler/libs/whitespace.dart';
import 'package:vlang/service/compiler/models/variables.dart';
import 'package:vlang/service/compiler4.dart';

class CompilerController extends ChangeNotifier {
  TextEditingController _code = TextEditingController();
  TextEditingController get code => _code;

  List<Variable> _variables = [];
  UnmodifiableListView<Variable> get variables =>
      UnmodifiableListView(_variables);

  List<String> _stdOut = [];
  UnmodifiableListView<String> get stdOut => UnmodifiableListView(_stdOut);

  List<String> _stdErr = [];
  UnmodifiableListView<String> get stdErr => UnmodifiableListView(_stdErr);

  void setVariable(String name, String value) {
    _variables.add(
      Variable()
        ..name = name
        ..value = value,
    );

    notifyListeners();

    print(_variables[0].name + _variables[0].value);
  }

  void setError(String error) {
    _stdErr.add(error);
    notifyListeners();
  }

  void clearStdErr() {
    _stdErr.clear();
    notifyListeners();
  }

  void setOutput(String out) {
    _stdOut.add(out);
    notifyListeners();
  }

  void clearStdOut() {
    _stdOut.clear();
    notifyListeners();
  }

  void setCode(String code) {
    log(code);
    log("CALLED");
    _code.text = code;
    notifyListeners();
  }

  void clearVars() {
    _variables.clear();
    notifyListeners();
  }

  void saveFile() async {
    String? outputFile = await FilePicker.platform.saveFile(
        dialogTitle: 'Save Your File to desired location',
        fileName: "new_code.vlang",
        lockParentWindow: true,
        );

    try {
      io.File returnedFile = io.File('$outputFile');
      await returnedFile.writeAsString(_code.text);
    } catch (e) {}
  }

  String getVariable(String name) {
    String value = "";
    try {
      value = _variables
          .where((element) => element.name.contains(removeWhitespace(name)))
          .toList()[0]
          .value
          .toString();
    } catch (e) {
      log("Name is ---> $name");
    }
    return value;
  }

  void addVars(String a, String b) {
    int num1 = 0;
    if (double.tryParse(a) != null) {
      num1 = int.parse(a);
    } else {
      num1 = int.parse(
        _variables
            .where((element) => element.name.contains(a))
            .toList()[0]
            .value
            .toString(),
      );
    }

    int num2 = 0;
    if (double.tryParse(b) != null) {
      num2 = int.parse(b);
    } else {
      log(_variables.toString());
      num2 = int.parse(
        _variables
            .where(
              (element) => element.name.contains(b),
            )
            .toList()[0]
            .value
            .toString(),
      );
    }

    int sum = num1 + num2;

    _stdOut.add(sum.toString());
    notifyListeners();
  }

  void subVars(String a, String b) {
    int num1 = 0;
    if (double.tryParse(a) != null) {
      num1 = int.parse(a);
    } else {
      num1 = int.parse(
        _variables
            .where((element) => element.name.contains(a))
            .toList()[0]
            .value
            .toString(),
      );
    }

    int num2 = 0;
    if (double.tryParse(b) != null) {
      num2 = int.parse(b);
    } else {
      log(_variables.toString());
      num2 = int.parse(
        _variables
            .where(
              (element) => element.name.contains(b),
            )
            .toList()[0]
            .value
            .toString(),
      );
    }

    int sum = num1 - num2;

    _stdOut.add(sum.toString());
    notifyListeners();
  }

  void divVars(String a, String b) {
    int num1 = 0;
    if (double.tryParse(a) != null) {
      num1 = int.parse(a);
    } else {
      num1 = int.parse(
        _variables
            .where((element) => element.name.contains(a))
            .toList()[0]
            .value
            .toString(),
      );
    }

    int num2 = 0;
    if (double.tryParse(b) != null) {
      num2 = int.parse(b);
    } else {
      log(_variables.toString());
      num2 = int.parse(
        _variables
            .where(
              (element) => element.name.contains(b),
            )
            .toList()[0]
            .value
            .toString(),
      );
    }

    double sum = num1 / num2;

    _stdOut.add(sum.toString());
    notifyListeners();
  }

  void multiVars(String a, String b) {
    int num1 = 0;
    if (double.tryParse(a) != null) {
      num1 = int.parse(a);
    } else {
      num1 = int.parse(
        _variables
            .where((element) => element.name.contains(a))
            .toList()[0]
            .value
            .toString(),
      );
    }

    int num2 = 0;
    if (double.tryParse(b) != null) {
      num2 = int.parse(b);
    } else {
      log(_variables.toString());
      num2 = int.parse(
        _variables
            .where(
              (element) => element.name.contains(b),
            )
            .toList()[0]
            .value
            .toString(),
      );
    }

    int sum = num1 * num2;

    _stdOut.add(sum.toString());
    notifyListeners();
  }

  void androidManager(List<String> commands) async {
    print(commands);
      //commands.forEach((element) { print(element); });
      final process = await Process.start('/Users/abhinivesh/Library/Android/sdk/platform-tools/adb', commands.where((element) => element.isNotEmpty).toList(), runInShell: true);

  
  await process.stdout
      .transform(utf8.decoder)
      .forEach((e) => _stdOut.add(e));
      notifyListeners();
print(_stdOut);

  }

  void showPackages() async {
    
  }

}
