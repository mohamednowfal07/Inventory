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

  Future<void> addProduct(Product product) async {
    final docRef = _productRef.doc();
    product.productId = docRef.id;
    await docRef.set(product.toMap());
  }

  Future<void> updateProduct(Product product) async {
    await _productRef
        .doc(product.productId)
        .update(product.toMap as Map<Object, Object?>);
  }

  Future<void> deleteProduct(String productId) async {
    await _productRef.doc(productId).delete();
  }
}
