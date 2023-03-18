import 'package:flutter_test/flutter_test.dart';
import 'package:test_app/models/counter_model.dart';

void main() {
  group('Testing the counter', () {
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
  });
}