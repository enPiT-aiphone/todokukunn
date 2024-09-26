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
        // routes を使ってページを定義
        routes: {
          '/': (context) => MyHomePage(),        // ホームページ
          '/input': (context) => InputPage(),    // 入力ページ
        },
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
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;

    return Scaffold(
      body: Column(
        children: [
          Text('Hello World!'),
          Text('todokukunn'),
          
          Bigcard(pair: pair),

          ElevatedButton(
            onPressed: () {
              // 入力ページに遷移
              Navigator.pushNamed(context, '/input');
            },
            child: Text('登録'),
          )
        ],
      ),
    );
  }
}

class Bigcard extends StatelessWidget {
  const Bigcard({
    super.key,
    required this.pair,
  });

  final WordPair pair;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(pair.asLowerCase),
    );
  }
}

// 新しい入力ページのクラス
class InputPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('入力ページ'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('情報を入力してください:'),
            SizedBox(
            width: 300,
            height: 50,
            child: TextField(
              maxLength: 50,
              enabled: true,
              maxLines: 2,
              decoration: InputDecoration(
                labelText: 'text field',
                hintText: 'これはテストフィールドです',
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10), // 縦横のパディングを調整
              ),
            ),
          ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // ホームページに戻る
              },
              child: Text('登録'),
            ),
          ],
        ),
      ),
    );
  }
}
