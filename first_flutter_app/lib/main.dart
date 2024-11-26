import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        home: MyHomePage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  var current = WordPair.random();

  void getNext() {
    current = WordPair.random();
    notifyListeners();
  }

  var favoriteList = <WordPair>[];

  void toggleFavorite(){
    if(favoriteList.contains(current)) {
      favoriteList.remove(current);
    } else {
      favoriteList.add(current);
    }
    notifyListeners();
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    IconData icon = appState.favoriteList.contains(pair) ? Icons.favorite : Icons.favorite_border;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('A random AWESOME idea:'),
            BigCard(pair: pair),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton.icon(onPressed: (){
                  appState.toggleFavorite();
                }, icon: Icon(icon), label: Text('LIKE IT!')),
                SizedBox(width: 20),
                ElevatedButton(onPressed: (){
                  appState.getNext();
                }, child: Text('CHANGE')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class BigCard extends StatelessWidget {
  const BigCard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary
    );

    return Card(
      color: theme.colorScheme.primary,
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text("${pair.asLowerCase} ㅁ나우미우미나우",
          style: style,
          semanticsLabel: "${pair.first} ${pair.second}",
        ),
      ),
    );
  }
}