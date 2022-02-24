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
  List<int> values = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Lock Breaker"),
        ),
        body: Column(
          children: [
            for (int i = 0; i < values.length; i++)
              IncrementalNumberHolderStl(
                  startingValue: values[i],
                  onIncrement: () {
                    setState(() {
                      values[i]++;
                    });
                  },
                  onDecrement: () {
                    setState(() {
                      values[i]--;
                    });
                  }),
            const Text("This is the total of all the values"),
            GestureDetector(
              onTap: () {
                setState(() {
                  values = [0, 0, 0, 0, 0];
                });
              },
              child: NumberHolder(
                content: sumofAllValues(values),
              ),
            ),
          ],
        ));
  }

  int sumofAllValues(List<int> list) {
    int temp = 0;
    list.forEach((val) {
      temp += val;
    });
    return temp;
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

class IncrementalNumberHolderStl extends StatelessWidget {
  final int startingValue;
  final Function()? onIncrement;
  final Function()? onDecrement;
  const IncrementalNumberHolderStl(
      {Key? key,
      required this.startingValue,
      this.onIncrement,
      this.onDecrement})
      : super(key: key);

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
              onPressed: onDecrement,
              icon: const Icon(
                Icons.chevron_left,
              )),
          Expanded(
            child: Text(
              "$startingValue",
              textAlign: TextAlign.center,
            ),
          ),
          IconButton(
              onPressed: onIncrement,
              icon: const Icon(
                Icons.chevron_right,
              )),
        ],
      ),
    );
  }
}

class IncrementalNumberHolder extends StatefulWidget {
  final Function(int) onUpdate;
  final int startingValue;
  const IncrementalNumberHolder(
      {Key? key, this.startingValue = 0, required this.onUpdate})
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
                widget.onUpdate(currentValue);
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
                widget.onUpdate(currentValue);
              },
              icon: const Icon(
                Icons.chevron_right,
              )),
        ],
      ),
    );
  }
}
