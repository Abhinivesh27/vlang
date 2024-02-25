import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vlang/service/controller.dart';
import 'package:vlang/ui/home/service.dart';

class ConsoleWidget extends StatefulWidget {
  final double size;
  final List<String> data;

  const ConsoleWidget({
    super.key,
    required this.data,
    required this.size,
  });

  @override
  State<ConsoleWidget> createState() => _ConsoleWidgetState();
}

class _ConsoleWidgetState extends State<ConsoleWidget> {
  List<String> visibleText = ["Welcome to VLang"];
  bool halfView = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: halfView
          ? MediaQuery.of(context).size.height * 2
          : MediaQuery.of(context).size.height * 0.3,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
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
                    TextButton(
                      onPressed: () {
                        Provider.of<HomeScreenController>(context,
                                listen: false)
                            .setCurrentTab(0);
                      },
                      child: Provider.of<HomeScreenController>(context,
                                      listen: true)
                                  .currentTab ==
                              0
                          ? Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Terminal",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            )
                          : Text(
                              "Terminal",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade400,
                                fontSize: 20,
                              ),
                            ),
                    ),
                    //bugs
                    TextButton(
                      onPressed: () {
                        Provider.of<HomeScreenController>(context,
                                listen: false)
                            .setCurrentTab(1);

                        setState(() {
                          visibleText = [];
                          visibleText = Provider.of<CompilerController>(context,
                                  listen: false)
                              .stdErr;
                        });
                      },
                      child: Provider.of<HomeScreenController>(context,
                                      listen: true)
                                  .currentTab ==
                              1
                          ? Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                "Bugs",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                            )
                          : Text(
                              "Bugs",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade400,
                                fontSize: 20,
                              ),
                            ),
                    ),
                    //output
                    TextButton(
                      onPressed: () {
                        Provider.of<HomeScreenController>(context,
                                listen: false)
                            .setCurrentTab(2);
                              setState(() {
                          visibleText = [];
                          visibleText = Provider.of<CompilerController>(context,
                                  listen: false)
                              .stdOut;
                        });
                      },
                      child: Provider.of<HomeScreenController>(context,
                                      listen: true)
                                  .currentTab ==
                              2
                          ? Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.white,
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
                            )
                          : Text(
                              "Output",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey.shade400,
                                fontSize: 20,
                              ),
                            ),
                    ),
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

          Container(
            height: MediaQuery.of(context).size.width,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.only(left: 50, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...visibleText.map(
                  (e) => Text(
                    e,
                    textAlign: TextAlign.start,
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
