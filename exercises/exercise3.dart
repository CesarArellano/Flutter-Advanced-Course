void main() {
  print(invert('cesarmauricio.arellano@gmail.com'));
}

String invert(String text) {
  // String invert = '';
  // text.split('').forEach((letter) => invert = letter + invert);
  return text.split('').reversed.join('');
}