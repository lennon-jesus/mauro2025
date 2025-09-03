import 'package:flutter/material.dart';

void main() {
  runApp(const MudaApp());
}

class MudaApp extends StatefulWidget {
  const MudaApp({super.key});

  @override
  State<MudaApp> createState() => _MudaAppState();
}

class _MudaAppState extends State<MudaApp> {
  var apertado = 0;
  var bt1 = 0;
  var bt2 = 0;
  var result = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            Center(child: Text("$result")),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (apertado == 0) {
                          setState(() {
                            bt1 = 7;
                            result = 7;
                          });
                        } else {
                          setState(() {
                            bt2 = 7;
                            result = 7;
                          });
                        }
                      },
                      child: Text('7'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (apertado == 0) {
                          setState(() {
                            bt1 = 8;
                            result = 8;
                          });
                        } else {
                          setState(() {
                            bt2 = 8;
                            result = 8;
                          });
                        }
                      },
                      child: Text('8'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (apertado == 0) {
                          setState(() {
                            bt1 = 9;
                            result = 9;
                          });
                        } else {
                          setState(() {
                            bt2 = 9;
                            result = 9;
                          });
                        }
                      },
                      child: Text('9'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (apertado == 0) {
                          setState(() {
                            bt1 = 4;
                            result = 4;
                          });
                        } else {
                          setState(() {
                            bt2 = 4;
                            result = 4;
                          });
                        }
                      },
                      child: Text('4'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (apertado == 0) {
                          setState(() {
                            bt1 = 5;
                            result = 5;
                          });
                        } else {
                          setState(() {
                            bt2 = 5;
                            result = 5;
                          });
                        }
                      },
                      child: Text('5'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (apertado == 0) {
                          setState(() {
                            bt1 = 6;
                            result = 6;
                          });
                        } else {
                          setState(() {
                            bt2 = 6;
                            result = 6;
                          });
                        }
                      },
                      child: Text('6'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (apertado == 0) {
                          setState(() {
                            bt1 = 1;
                            result = 1;
                          });
                        } else {
                          setState(() {
                            bt2 = 1;
                            result = 1;
                          });
                        }
                      },
                      child: Text('1'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (apertado == 0) {
                          setState(() {
                            bt1 = 2;
                            result = 2;
                          });
                        } else {
                          setState(() {
                            bt2 = 2;
                            result = 2;
                          });
                        }
                      },
                      child: Text('2'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (apertado == 0) {
                          setState(() {
                            bt1 = 3;
                            result = 3;
                          });
                        } else {
                          setState(() {
                            bt2 = 3;
                            result = 3;
                          });
                        }
                      },
                      child: Text('3'),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (apertado == 0) {
                          setState(() {
                            bt1 = 0;
                            result = 0;
                          });
                        } else {
                          setState(() {
                            bt2 = 0;
                            result = 0;
                          });
                        }
                      },
                      child: Text('0'),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          result = bt1 + bt2;
                          apertado = 0;
                        });
                      },
                      child: Text('='),
                    ),
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          apertado = 1;
                        });
                      },
                      child: Text('+'),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
