import 'package:flutter/material.dart';
import 'package:flutter_random_words/services/random_words.dart';
import 'package:provider/provider.dart';

class FavoritesPage extends StatelessWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyWordState>();
    var favorites = appState.favorites;

    if (favorites.isEmpty) {
      return const Center(child: Text('No favorites ywt.'));
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 80),
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: 16).copyWith(bottom: 8),
          child: const Text(
            'You have favorites',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
        ),
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              for (var pair in favorites)
                ListTile(
                  leading: InkWell(
                    child: const Icon(Icons.delete_rounded),
                    onTap: () {
                      appState.removeFavorite(pair);
                    },
                  ),
                  title: Text(pair.asLowerCase),
                )
            ],
          ),
        )
      ],
    );
  }
}
