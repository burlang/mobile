import 'package:flutter/material.dart';

class Constants {
  static final letters_names = <String>[
    'А',
    'Б',
    'В',
    'Г',
    'Д',
    'Е',
    'Ж',
    'З',
    'И',
    'К',
    'Л',
    'М',
    'Н',
    'О',
    'П',
    'Р',
    'С',
    'Т',
    'У',
    'Х',
    'Ц',
    'Ч',
    'Ш',
    'Э',
    'Ю',
    'Я'
  ];

  static final letters_numbers = <String>[
    '45',
    '108',
    '5',
    '64',
    '82',
    '7',
    '28',
    '11',
    '2',
    '1',
    '26',
    '29',
    '55',
    '27',
    '10',
    '17',
    '61',
    '34',
    '17',
    '21',
    '25',
    '12',
    '14',
    '21',
    '9',
    '6'
  ];

  static const String bur = 'Бурятско';
  static const String bur_rus = 'Русский';

  static const String rus = 'Русско';
  static const String rus_bur = 'Бурятский';

  static const String input_bur = 'Введите бурятское слово';
  static const String input_rus = 'Введите русское слово';

  static const color = Color.fromRGBO(30, 104, 135, 1);
  static const backgroundColor = Color.fromRGBO(238, 238, 238, 1);

  static const textContactStyle = TextStyle(
    color: Constants.color,
    fontSize: 15,
  );

  static const textDrawerStyle =
      TextStyle(color: Colors.white, fontFamily: 'Arial');
}
