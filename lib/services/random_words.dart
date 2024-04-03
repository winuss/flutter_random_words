import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';

class MyWordState extends ChangeNotifier {
  var current = WordPair.random();
  var allList = <List<dynamic>>[];
  var favorites = <WordPair>[];

  final GlobalKey<AnimatedListState> key = GlobalKey();

  void getNext() {
    current = WordPair.random();
    key.currentState
        ?.insertItem(0, duration: const Duration(milliseconds: 700));
    notifyListeners();
  }

  void saveWord(WordPair pair, IconData icon) {
    allList.insert(0, [pair, favorites.contains(current) ? icon : null]);
  }

  void toggleFavorite() {
    if (favorites.contains(current)) {
      favorites.remove(current);
    } else {
      favorites.add(current);
    }
    notifyListeners();
  }

  void removeFavorite(WordPair word) {
    favorites.remove(word);

    // allList 내에서 해당 WordPair가 존재하는 모든 항목의 아이콘을 null로 업데이트
    for (var i = 0; i < allList.length; i++) {
      if (allList[i][0] == word) {
        allList[i][1] = null;
      }
    }

    notifyListeners();
  }
}
