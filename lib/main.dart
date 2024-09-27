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
        title: 'とどくくん',
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
            Text('商品名'),
            SizedBox(
            width: 300,
            height: 50,
            child: TextField(
              maxLength: 50,
              enabled: true,
              maxLines: 2,
              decoration: InputDecoration(
                // labelText: 'text field',
                // hintText: 'これはテストフィールドです',
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10), // 縦横のパディングを調整
              ),
            ),
            ),
            Text('受け取り日時'),
            DropdownDate(),
            Text('受け取り形式'),
            DropdownReceive(),
            Text('注文番号'),
            SizedBox(
            width: 300,
            height: 50,
            child: TextField(
              maxLength: 50,
              enabled: true,
              maxLines: 2,
              decoration: InputDecoration(
                // labelText: 'text field',
                // hintText: 'これはテストフィールドです',
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10), // 縦横のパディングを調整
              ),
            ),
            ),
            Text('伝票番号'),
            SizedBox(
            width: 300,
            height: 50,
            child: TextField(
              maxLength: 50,
              enabled: true,
              maxLines: 2,
              decoration: InputDecoration(
                // labelText: 'text field',
                // hintText: 'これはテストフィールドです',
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10), // 縦横のパディングを調整
              ),
            ),
            ),
            Text('配達業者'),
            SizedBox(
            width: 300,
            height: 50,
            child: TextField(
              maxLength: 50,
              enabled: true,
              maxLines: 2,
              decoration: InputDecoration(
                // labelText: 'text field',
                // hintText: 'これはテストフィールドです',
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10), // 縦横のパディングを調整
              ),
            ),
            ),
            Text('請求額'),
            SizedBox(
            width: 300,
            height: 50,
            child: TextField(
              maxLength: 50,
              enabled: true,
              maxLines: 2,
              decoration: InputDecoration(
                // labelText: 'text field',
                // hintText: 'これはテストフィールドです',
                border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(10.0)),),
                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10), // 縦横のパディングを調整
              ),
            ),
            ),
            Text('メモ'),
            SizedBox(
            width: 300,
            height: 200,
            child: TextField(
              maxLength: 200,
              enabled: true,
              maxLines: 2,
              decoration: InputDecoration(
                // labelText: 'text field',
                // hintText: 'これはテストフィールドです',
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

class DropdownDate extends StatefulWidget {
  @override
  _DropdownDateState createState() => _DropdownDateState();
}

class DropdownReceive extends StatefulWidget {
  @override
  _DropdownReceiveState createState() => _DropdownReceiveState();
}

class _DropdownDateState extends State<DropdownDate> {
  int? selectedMonth; // 選択された値を保持する変数
  int? selectedDay;

  // 月によって異なる選択肢を定義
  Map<int, List<int>> daysInMonth = {
    1: List.generate(31, (index) => index + 1),  // 1月は31日
    2: List.generate(28, (index) => index + 1),  // 2月は28日
    3: List.generate(31, (index) => index + 1),
    4: List.generate(30, (index) => index + 1),
    5: List.generate(31, (index) => index + 1),
    6: List.generate(30, (index) => index + 1),
    7: List.generate(31, (index) => index + 1),
    8: List.generate(31, (index) => index + 1),
    9: List.generate(30, (index) => index + 1),
    10: List.generate(31, (index) => index + 1),
    11: List.generate(30, (index) => index + 1),
    12: List.generate(31, (index) => index + 1),
  };

  @override
  Widget build(BuildContext context) {
    return Row(
      // mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // 月プルダウン
        Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            DropdownButton<int>(
              value: selectedMonth,
              hint: Text('月を選択'),
              items: List.generate(12, (index) => DropdownMenuItem(
                value: index + 1,
                child: Text('${index + 1}'),
              )),
              onChanged: (int? newValue) {
                setState(() {
                  selectedMonth = newValue;
                  selectedDay = null; // 月が変わると日付はリセット
                });
              },
            ),
            SizedBox(width: 8),
            Text('月', style: TextStyle(fontSize: 18)),
          ],
        ),
        SizedBox(height: 20),
        // 日プルダウン
        Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (selectedMonth != null) // 月が選択されたときのみ表示
              Container(
                width: 100, // プルダウンの横幅を指定
                child: DropdownButton<int>(
                  value: selectedDay,
                  hint: Text('日を選択'),
                  items: daysInMonth[selectedMonth]!
                      .map((day) => DropdownMenuItem(
                            value: day,
                            child: Text('$day'),
                          ))
                      .toList(),
                  onChanged: (int? newValue) {
                    setState(() {
                      selectedDay = newValue;
                    });
                  },
                ),
              ),
                      ],
        ),
      ],
    );
  }
}

class _DropdownReceiveState extends State<DropdownReceive> {
  String? selectedreceive;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      items: const[
        DropdownMenuItem(
          value: '対面',
          child: Text('対面'),
        ),
        DropdownMenuItem(
            value: '置き配',
            child: Text('置き配'),
        ),
        DropdownMenuItem(
            value: 'その他',
            child: Text('その他'),
        ),
      ],
      value: selectedreceive,
      onChanged: (String? value) {
        setState(() {
          selectedreceive = value!;
        });
      },
    );
  }

}
