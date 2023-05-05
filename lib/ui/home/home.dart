import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:vlang/service/compiler.dart';
import 'package:vlang/service/compiler2.dart';

import 'widgets/console.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double codeFSize = 32.0;

  dynamic data = "Welcome to VLang Project";
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                data = Compiler.compile(_controller.text);
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
          SizedBox(
            width: 200,
          )
        ],
        elevation: 0,
        title: Text("Vlang compiler"),
      ),
      backgroundColor: Colors.white,
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
                  color: Colors.pink.shade100,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: TextField(
                  controller: _controller,
                  onChanged: (datas) {
                    setState(() {});
                  },
                  style: TextStyle(
                    fontSize: codeFSize,
                  ),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                  ),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                ),
              ),
              //console
              ConsoleWidget(
                data: data.toString(),
                size: codeFSize,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
