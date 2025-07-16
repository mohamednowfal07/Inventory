import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:inventory_project/model/product_model.dart';

class FirestoreServices {
  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection("Products");

  Future<List<Product>> fetchProduct() async {
    final snapshot = await _productRef.get();
    return snapshot.docs.map((doc) {
      return Product.fromMap(doc.data() as Map<String, dynamic>, doc.id);
    }).toList();
  }
}
