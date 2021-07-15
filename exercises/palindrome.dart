/*
* @file palindrome.dart
* @brief Este programa debe tener una función la cual va a tener como entrada un texto, y me va a decir si es palindromo o no,
* En este caso sólo meteremos una sola palabra y que también no se ocupe ningún ciclo.
* @author Arellano Velásquez César
* @date 11/07/2021
*/

void main() {
  String word = 'hola';
  print('This word is palindrome: ${ palindrome(word) }');
}

bool palindrome(String word) {
  String inverted = '';
  // String inverted = word.split('').reversed.join('');
  // for( int i = word.length - 1; i >= 0; i-- ) {
  //   inverted += word[i];  
  // }
  // word.split('').forEach( (letter) => inverted = letter + inverted );
  print(inverted);
  return ( inverted == word );
}