/*
* @file draw_square.dart
* @brief Hacer un rectángulo de * en base a lado que te dé el usuario.
* @author Arellano Velásquez César
* @date 11/07/2021
*/

/*
rect(4) side(4)
****
*  *
*  *
****
*/

void main() {
  rect(4);
}

void rect(int number) {
  String canvas = side(number) + '\n';
  String content;

  for(int i = 0; i < number - 2; i++) {
    content = '*';
    for( int j = 0; j < number - 2; j++ ) {
      content += ' ';
    }
    content += '*';
    canvas += content + '\n';
  }

  canvas += side(number);
  print(canvas);
}

String side(int number) {
  String side = '';
  for( int i = 0; i < number; i++ ) {
    side += '*';
  }
  return side;
}
