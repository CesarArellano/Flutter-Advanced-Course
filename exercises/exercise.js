const text = 'Hola mundo, hoy es martes, mañana es. nochebuena, pasado Mañana es navidad. hola mundo Nochebuena eS! el mejor día';

const normalize = (word) => {
  return word.toLowerCase().replace(/[.!,]/g, '');
}

const wordRepetitions = (text) => {
  let dict = {}
  let normalizeWord;
  const separateWords = text.split(' ');
  
  for( let word of separateWords ) {
    normalizeWord = normalize(word);
    if( normalizeWord in dict ) {
      ++dict[normalizeWord];
    } else {
      dict[normalizeWord] = 1;
    }
  }
  console.log(dict);
}

wordRepetitions(text);