import 'package:flutter/material.dart';

class ConsoleWidget extends StatefulWidget {
  final double size;
  final String data;

  const ConsoleWidget({
    super.key,
    required this.data,
    required this.size,
  });

  @override
  State<ConsoleWidget> createState() => _ConsoleWidgetState();
}

class _ConsoleWidgetState extends State<ConsoleWidget> {
  bool halfView = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: halfView
          ? MediaQuery.of(context).size.height * 0.6
          : MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.blue.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          //toolbar
          Stack(
            children: [
              Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Terminal",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Debug",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Text(
                      "Problems",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          "Output",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          halfView = false;
                        });
                      },
                      icon: Icon(Icons.minimize),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          halfView = true;
                        });
                      },
                      icon: Icon(Icons.expand),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.cancel),
                    ),
                  ],
                ),
              ),
            ],
          ),

          Text(
            widget.data == "" ? "UNHANDLED EXCEPTION OCCURED" : widget.data,
            style: TextStyle(fontSize: widget.size),
          ),
        ],
      ),
    );
  }
}