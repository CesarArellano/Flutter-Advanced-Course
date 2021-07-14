void main() {
  print('Es un palíndromo: ${ palindromo("oso") }');
}

bool palindromo(String text) {
  final invert = text.split('').reversed.join('');
  return ( invert == text );
}