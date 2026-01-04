import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // 1. Pobieranie zadań (Stream)
  Stream<QuerySnapshot> tasksStream() {
    final user = _auth.currentUser;
    if (user == null) return const Stream.empty();

    return _db
        .collection('tasks')
        .where('userId', isEqualTo: user.uid)
        .orderBy('createdAt', descending: true) // Sortowanie po dacie
        .snapshots();
  }

  // 2. Dodawanie zadania (Pasuje do Twojego kodu: przyjmuje task i author)
  Future<void> addTask(String taskContent, String authorName) async {
    final user = _auth.currentUser;
    if (user == null) return;

    await _db.collection('tasks').add({
      'task': taskContent,       // W Twoim UI czytasz to jako data['task']
      'author': authorName.isEmpty ? 'Unknown' : authorName, // Czytasz data['author']
      'completed': false,        // Czytasz data['completed']
      'userId': user.uid,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // 3. Aktualizacja statusu (Pasuje do Twojego kodu: updateTask)
  Future<void> updateTask(String id, Map<String, dynamic> data) async {
    await _db.collection('tasks').doc(id).update(data);
  }

  // 4. Usuwanie zadania
  Future<void> deleteTask(String id) async {
    await _db.collection('tasks').doc(id).delete();
  }
}