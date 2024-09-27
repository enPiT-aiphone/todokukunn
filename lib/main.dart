import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/pages/register.dart';
import '/components/register_button.dart';
import 'package:firebase_core/firebase_core.dart';
import '/firebase/firebase_options.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';



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
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
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
        title: Image.asset('img/todokukun.webp', 
        fit: BoxFit.contain,
        height: 50,
        ),
        elevation: 10.0,
        shadowColor: const Color.fromARGB(255, 250, 253, 255),
        backgroundColor: Colors.blue,
        foregroundColor: const Color.fromARGB(255, 254, 254, 255),
        shape: const StadiumBorder(),
      ),
      body: Column(
        children: [
          // StreamBuilderでFirestoreのデータを取得してリストに表示
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Orders').snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(child: Text('データがありません'));
                }

                // Firestoreのデータを表示するためのリスト
                return ListView(
                  children: snapshot.data!.docs.map((doc) {
                    var data = doc.data() as Map<String, dynamic>;

                    return Dismissible(
                      key: Key(doc.id),  // ドキュメントのIDをキーとして使用
                      background: Container(color: Colors.red),  // スワイプ中の背景色
                      direction: DismissDirection.endToStart,  // スワイプ方向（右から左）
                      onDismissed: (direction) {
                        // ドキュメントを削除
                        FirebaseFirestore.instance
                            .collection('Orders')
                            .doc(doc.id)
                            .delete();
                        
                        // スナックバーで削除されたことを通知
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('${data['product_name']} を削除しました')),
                        );
                      },

                    child: ListTile(
                      title: GestureDetector(
                          onTap: () {
                            // 商品名をタップしたときにメモを表示
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('${data['product_name']} のメモ'),
                                  content: Text('${data['memo'] ?? 'メモはありません'}'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop(); // ダイアログを閉じる
                                      },
                                      child: Text('閉じる'),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: Text('${data['product_name']}'),
                        ),
                      // title: Text('${data['product_name']}'),
                      subtitle: Text(
                        '${data['receiveDate']?.toDate() ?? '日時不明'}  :  ${data['receipt_method'] ?? '不明'}  :  ${data['order_number']}  :  ${data['tracking_number']}  :  ${data['delivery_service']}  :  ¥${data['billing_amount']}',
                      ),
                    ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingButton(
            onPressed: () {Navigator.pushNamed(context, '/input');}
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
