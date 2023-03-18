import 'package:flutter/material.dart';
import 'package:test_app/models/counter_model.dart';

class CounterScreen extends StatefulWidget {
  
  const CounterScreen({Key? key}) : super(key: key);

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  
  CounterModel counter = CounterModel(value: 0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Center(
        child: Text(
          '${ counter.value }',
          style: const TextStyle(
            fontSize: 60,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(top: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FloatingActionButton(
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.remove,
                color: Colors.green,
              ),
              onPressed: () => setState(() => counter.decrementCounter())
            ),
            FloatingActionButton(
              backgroundColor: Colors.white,
              child: const Icon(
                Icons.add,
                color: Colors.green,
              ),
              onPressed: () => setState(() => counter.incrementCounter())
            ),
          ],
        ),
      ),
    );
  }
}