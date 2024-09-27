import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseManager {
  // Firestoreインスタンスの取得
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // データを保存する関数
  Future<void> saveDeliveryData(
    String collection,{
    required String product_name,
    //required DateTime receiveDate,
    //required String receipt_method,
    required String order_number,
    required String tracking_number,
    required String delivery_service,
    required String billing_amount,
    required String memo,
  }) async {
    try {
      await _firestore.collection(collection).add({
        'product_name': product_name,
        //'receiveDate': Timestamp.fromDate(receiveDate),
        //'receipt_method': receipt_method,
        'order_number': order_number,
        'tracking_number': tracking_number,
        'delivery_service': delivery_service,
        'billing_amount': billing_amount,
        'memo': memo,
        //'timestamp': FieldValue.serverTimestamp(),
      });
      print('データが正常に保存されました');
    } catch (e) {
      print('データの保存中にエラーが発生しました: $e');
    }
  }
}
