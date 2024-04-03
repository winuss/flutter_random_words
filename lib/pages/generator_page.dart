import 'package:flutter/material.dart';
import 'package:flutter_random_words/services/random_words.dart';
import 'package:flutter_random_words/widgets/bigcard.dart';
import 'package:provider/provider.dart';

class GeneratorPage extends StatelessWidget {
  const GeneratorPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyWordState>();
    var pair = appState.current;

    final GlobalKey<AnimatedListState> anikey = appState.key;

    IconData icon;
    if (appState.favorites.contains(pair)) {
      icon = Icons.favorite;
    } else {
      icon = Icons.favorite_border;
    }

    final theme = Theme.of(context);

    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 80),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: SizedBox(
                height: 150,
                child: ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, theme.colorScheme.surface],
                      stops: const [
                        0.0,
                        0.1
                      ], // 이 값들을 조절하여 그라데이션 효과 범위를 조정할 수 있음
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn, // 셰이더가 적용되는 방식
                  child: AnimatedList(
                    scrollDirection: Axis.vertical,
                    //shrinkWrap: true,
                    reverse: true,
                    key: anikey,
                    initialItemCount: appState.allList.length,
                    padding: const EdgeInsets.only(top: 10),
                    itemBuilder: (_, index, animation) {
                      return SizeTransition(
                        //key: UniqueKey(),
                        sizeFactor: animation,
                        child: Container(
                          height: 40,
                          //padding: const EdgeInsets.all(10),
                          alignment: Alignment.center,
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  appState.allList[index][1],
                                  size: 18,
                                  color: theme.colorScheme.primary,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  appState.allList[index][0].asCamelCase,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: theme.colorScheme.primary,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
            BigCard(pair: pair),
            const SizedBox(height: 10),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    appState.toggleFavorite();
                  },
                  icon: Icon(icon),
                  label: const Text('Like'),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    // appState.icons.insert(0, icon);
                    // appState.alllist.insert(0, pair);
                    appState.saveWord(pair, icon);
                    appState.getNext();
                  },
                  child: const Text('Next'),
                ),
              ],
            ),
            const Expanded(child: Text('')),
          ],
        ),
      ),
    );
  }
}
