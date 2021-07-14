void main() {
  print(square(6));
}

String side(number) {
  String side = '';

  for(int i = 0; i < number; i++) {
    side += '*';
  } 

  return side;
}

String square(number) {
  String draw = side(number) + "\n";
  String content  = '';

  for( int i = 0; i < number - 2; i++) {
    content = '*';
    for( int j = 0; j < number - 2; j++) {
      content += ' ';
    }
    content += '*';
    draw += content + "\n";
  }

  draw += side(number);
  return draw;
}