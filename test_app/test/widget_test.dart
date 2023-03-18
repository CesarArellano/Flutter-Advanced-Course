// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:test_app/models/counter_model.dart';

void main() {
  test('Testing the increment counter', () {
    // Arrange (Setup)
    CounterModel counter = CounterModel(value: 5);
    // Act (Do)
    counter.incrementCounter();
    // Assert (Test)
    expect(counter.value, 6);
  });

  test('Testing the decrement counter', () {
    // Arrange (Setup)
    CounterModel counter = CounterModel(value: 5);
    // Act (Do)
    counter.decrementCounter();
    // Assert (Test)
    expect(counter.value, 4);
  });
}
