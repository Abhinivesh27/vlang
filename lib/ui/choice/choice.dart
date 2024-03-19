import 'dart:developer';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlang/service/controller.dart';
import 'package:vlang/ui/home/home.dart';

class ChoiceWidget extends StatefulWidget {
  const ChoiceWidget({super.key});

  @override
  State<ChoiceWidget> createState() => _ChoiceWidgetState();
}

class _ChoiceWidgetState extends State<ChoiceWidget> {
  PlatformFile file = PlatformFile(name: '', size: 0);

  void pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      file = result.files.first;
      if (file.bytes != null) {
        Provider.of<CompilerController>(context, listen: false)
            .setCode(String.fromCharCodes(file.bytes!.toList()));
      } 
      else {
      log("Error 1");
    }
    } else {
      log("Error");
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("VLang"),
        centerTitle: true,
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(width: 1),
            ElevatedButton.icon(
              onPressed: () {
                pickFile();
              },
              icon: Icon(
                Icons.upload_file,
                size: 100,
              ),
              label: Text(
                "Load",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 10),
            ElevatedButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomePage(),
                  ),
                );
              },
              icon: Icon(
                Icons.edit_document,
                size: 100,
              ),
              label: Text(
                "Write",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(width: 1),
          ],
        ),
      ),
    );
  }
}
