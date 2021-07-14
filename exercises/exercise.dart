void main() {
  String text = 'Hola mundo, hoy es martes, mañana es. nochebuena, pasado Mañana es navidad. hola mundo Nochebuena eS! el mejor día';
  print(wordRepetitions(text, 'ES'));
}

int wordRepetitions(String text, String query) {
  Map<String, int> dict = {};
  List<String> separateWords = text.split(' ');
  String newWord;

  for(String word in separateWords) {
    newWord = normalize(word);
    if(dict.containsKey(newWord)) {
      dict[newWord] = dict[newWord]! + 1;
    } else {
      dict[newWord] = 1;
    }
  }
  final word = query.toLowerCase();
  return (dict.containsKey(word)) ? dict[word]! : 0;
}

String normalize(String word) {
  return word.toLowerCase().replaceAll(RegExp(r'[!,.]'), '');
}
