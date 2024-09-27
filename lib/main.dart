import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/pages/register.dart';
import 'package:firebase_core/firebase_core.dart';
import '/firebase/firebase_options.dart'; 


//データベース用のimport
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'とどくくん',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        // routes を使ってページを定義
        routes: {
          '/': (context) => MyHomePage(), // ホームページ
          '/input': (context) => InputPage(), // 入力ページ
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
      appBar: AppBar(
        title: const Text('とどくくん'),
        elevation: 10.0,
        shadowColor: const Color.fromARGB(255, 250, 253, 255),
        backgroundColor: const Color.fromARGB(255, 191, 150, 127),
        foregroundColor: const Color.fromARGB(255, 254, 254, 255),
        shape: const StadiumBorder(),
      ),
      body: Column(
        children: [
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // 左揃えにする
        children: [
          Text(
            "商品情報",
            style: TextStyle(
              fontWeight: FontWeight.bold, // 太字にしてカテゴリを目立たせる
              fontSize: 16,
            ),
          ),
          SizedBox(height: 10), // カテゴリ名と情報の間にスペースを追加
          Text(
            "iphone16  :  10/10  :  対面  :  123456789  :  123456789  :  ヤマト :  ¥100,000",
          ),
        ],
      ),
    );
  }
}

