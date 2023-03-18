class CounterModel {
  
  int value = 0;
  CounterModel({ this.value = 0 });

  void incrementCounter() {
    value++;
  }

  void decrementCounter() {
    value--;
  }
}