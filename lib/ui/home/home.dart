
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlang/service/compiler4.dart';
import 'package:vlang/service/controller.dart';
import 'package:vlang/ui/home/service.dart';

import 'widgets/console.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  double codeFSize = 32.0;

  void setErrorToProvider(String erorr) {
    Provider.of<CompilerController>(context, listen: false).setError(erorr);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade900,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<HomeScreenController>(context,listen: false).setCurrentTab(2);
              Provider.of<CompilerController>(context, listen: false)
                  .clearStdErr();
              Provider.of<CompilerController>(context, listen: false)
                  .clearStdOut();
              Provider.of<CompilerController>(context, listen: false).clearVars();
              setState(() {
                
                Compiler.compile(Provider.of<CompilerController>(context,listen: false).code.text, context);
              });
            },
            icon: Icon(
              Icons.run_circle,
              size: 50,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                codeFSize = codeFSize + 5;
              });
            },
            icon: Icon(
              Icons.zoom_in,
              size: 50,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          IconButton(
            onPressed: () {
              setState(() {
                codeFSize = codeFSize - 5;
              });
            },
            icon: Icon(
              Icons.zoom_out,
              size: 50,
            ),
          ),

          IconButton(
            onPressed: () {
              Provider.of<CompilerController>(context,listen: false).saveFile();
            },
            icon: Icon(
              Icons.save_as_rounded,
              size: 50,
            ),
          ),
          SizedBox(
            width: 150,
          )
        ],
        elevation: 0,
        title: Text("Vlang compiler"),
      ),
      backgroundColor: Colors.grey.shade900,
      body: Container(
        padding: const EdgeInsets.all(20),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              //text editing area
              Container(
                margin: const EdgeInsets.only(bottom: 20),
                padding: const EdgeInsets.all(20),
                height: MediaQuery.of(context).size.height * 0.7,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: Provider.of<CompilerController>(context,listen: true).code,
                  onChanged: (datas) {
                    setState(() {});
                  },
                  style: TextStyle(
                    fontSize: codeFSize,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintStyle: TextStyle(
                        fontStyle: FontStyle.italic,
                      ),
                      hintText: "Write your first line of VLang..."),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
              //console
              ConsoleWidget(
                data: Provider.of<CompilerController>(context, listen: true)
                    .stdOut,
                size: codeFSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
