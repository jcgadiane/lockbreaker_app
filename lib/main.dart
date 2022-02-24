import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lock Breaker"),
        ),
        body: Column(
          children: [
            const NumberHolder(
              content: "1",
            ),
            IncrementalNumberHolder(),
            IncrementalNumberHolder(),
            IncrementalNumberHolder(),
            IncrementalNumberHolder(),
            IncrementalNumberHolder(),
          ],
        ));
  }
}

class NumberHolder extends StatelessWidget {
  final dynamic content;
  const NumberHolder({Key? key, this.content}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(4),
      constraints: const BoxConstraints(minHeight: 60),
      width: double.infinity,
      color: Colors.orangeAccent,
      child: Center(
        child: Text(
          "$content",
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class IncrementalNumberHolder extends StatefulWidget {
  final int startingValue;
  const IncrementalNumberHolder({Key? key, this.startingValue = 0})
      : super(key: key);

  @override
  _IncrementalNumberHolderState createState() =>
      _IncrementalNumberHolderState();
}

class _IncrementalNumberHolderState extends State<IncrementalNumberHolder> {
  @override
  void initState() {
    currentValue = widget.startingValue;
    super.initState();
  }

  late int currentValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(4),
      width: double.infinity,
      color: Colors.orangeAccent,
      constraints: const BoxConstraints(minHeight: 60),
      child: Row(
        children: [
          IconButton(
              onPressed: () {
                setState(() {
                  currentValue--;
                });
              },
              icon: const Icon(
                Icons.chevron_left,
              )),
          Expanded(
            child: Text(
              "$currentValue",
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
              onPressed: () {
                setState(() {
                  currentValue++;
                });
              },
              icon: const Icon(
                Icons.chevron_right,
              )),
        ],
      ),
    );
  }
}
