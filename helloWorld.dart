import 'dart:io';
import 'dart:math';
void main(){
  print("Enter your name : ");
  String? option = stdin.readLineSync();
  print(2 * pow(2, 3));
  print(option);

  Future.delayed(Duration(seconds: 1)).then((resp) =>{
    "id": 1,
    "name": {
      "english": "Bulbasaur",
      "japanese": "フシギダネ",
      "chinese": "妙蛙种子",
      "french": "Bulbizarre"
    },
    "type": [
      "Grass",
      "Poison"
    ],
    "base": {
      "HP": 45,
      "Attack": 49,
      "Defense": 49,
      "Sp. Attack": 65,
      "Sp. Defense": 65,
      "Speed": 45
    }
  }).then( (data) => print(data))
  .catchError((e) => throw Error());

  print('Fin del programa');
}