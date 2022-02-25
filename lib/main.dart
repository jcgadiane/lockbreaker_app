import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'lock_breaker_widgets/lock_dial.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LockBreakerView(),
    );
  }
}

class LockBreakerView extends StatefulWidget {
  LockBreakerView({Key? key}) : super(key: key);

  @override
  _LockBreakerViewState createState() => _LockBreakerViewState();
}

class _LockBreakerViewState extends State<LockBreakerView> {
  List<int> values = [1, 2, 3];
  String combination = "246";
  String feedback = '';
  bool isUnlocked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(209, 209, 209, 1),
        appBar: AppBar(
          title: Text("Lock Breaker"),
          backgroundColor: Color.fromRGBO(76, 76, 76, 1),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                  isUnlocked
                      ? CupertinoIcons.lock_open_fill
                      : CupertinoIcons.lock_fill,
                  size: 128,
                  color: Color.fromRGBO(133, 199, 242, 1)),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 32),
                height: 120,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < values.length; i++)
                      LockDial(
                          startingValue: values[i],
                          onIncrement: () {
                            values[i]++;
                            if (values[i] == 10) {
                              values[i] = 0;
                            }
                            setState(() {});
                          },
                          onDecrement: () {
                            if (values[i] == 0) {
                              values[i] = 10;
                            }
                            values[i]--;
                            setState(() {});
                          }),
                  ],
                ),
              ),
              if (feedback.isNotEmpty) Text(feedback),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 48),
                child: TextButton(
                  onPressed: unlockSafe,
                  child: Container(
                    padding: const EdgeInsets.all(32),
                    color: Color.fromRGBO(219, 219, 219, 1),
                    child: const Text("Open the lock",
                        style: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  unlockSafe() {
    if (checkCombination()) {
      setState(() {
        isUnlocked = true;
        feedback = "You have cracked the lock!";
      });
    } else {
      setState(() {
        isUnlocked = false;
        feedback = "Wrong combination, try again!";
      });
    }
  }

  bool checkCombination() {
    String theCurrentValue = convertValuestoComparableString(values);
    bool isUnlocked = (theCurrentValue == combination);
    return isUnlocked;
  }

  String convertValuestoComparableString(List<int> val) {
    String temp = "";
    for (int v in val) temp += "$v";
    return temp;
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
