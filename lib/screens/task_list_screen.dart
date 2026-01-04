import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import 'package:provider/provider.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  final FirestoreService _fs = FirestoreService();
  final TextEditingController _controller = TextEditingController();

  void _addTask() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    _fs.addTask(text, 'User');
    _controller.clear();
    // Ukrywa klawiaturę
    FocusScope.of(context).unfocus();
  }

  void _toggleComplete(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final current = data['completed'] ?? false;
    _fs.updateTask(doc.id, {'completed': !current});
  }

  void _deleteTask(String id) => _fs.deleteTask(id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // POPRAWKA: Używamy 'surface' zamiast 'background'
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: false,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('My Tasks', style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w900)),
            Text('Focus on your day', style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 14, color: Colors.grey)),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10)],
            ),
            child: IconButton(
              // POPRAWKA: Standardowa ikona
              icon: const Icon(Icons.logout, color: Colors.black87),
              onPressed: () async => await context.read<AuthService>().signOut(),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF6C63FF).withOpacity(0.08),
                          blurRadius: 20,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: const InputDecoration(
                        hintText: 'What needs to be done?',
                        border: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        // POPRAWKA: Standardowa ikona
                        prefixIcon: Icon(Icons.add_task, color: Color(0xFF6C63FF)),
                      ),
                      onSubmitted: (_) => _addTask(),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                FloatingActionButton(
                  onPressed: _addTask,
                  backgroundColor: const Color(0xFF6C63FF),
                  elevation: 2,
                  child: const Icon(Icons.arrow_upward, color: Colors.white),
                ),
              ],
            ),
          ),

          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: _fs.tasksStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                   print("BŁĄD FIREBASE: ${snapshot.error}");
                   return Center(child: SelectableText('Błąd: ${snapshot.error}'));
                }
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                
                final docs = snapshot.data!.docs;
                if (docs.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.check_circle_outline, size: 80, color: Colors.grey.shade300),
                        const SizedBox(height: 16),
                        Text('All caught up!', style: TextStyle(color: Colors.grey.shade500, fontSize: 18)),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    final doc = docs[index];
                    final data = doc.data() as Map<String, dynamic>;
                    final task = data['task'] ?? '';
                    final completed = data['completed'] ?? false;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Card(
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          leading: GestureDetector(
                            onTap: () => _toggleComplete(doc),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: 28,
                              height: 28,
                              decoration: BoxDecoration(
                                color: completed ? const Color(0xFF6C63FF) : Colors.transparent,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: completed ? const Color(0xFF6C63FF) : Colors.grey.shade400,
                                  width: 2,
                                ),
                              ),
                              child: completed 
                                ? const Icon(Icons.check, size: 18, color: Colors.white)
                                : null,
                            ),
                          ),
                          title: Text(
                            task,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: completed ? Colors.grey : Colors.black87,
                              decoration: completed ? TextDecoration.lineThrough : null,
                              decorationColor: const Color(0xFF6C63FF),
                              decorationThickness: 2,
                            ),
                          ),
                          trailing: IconButton(
                            // POPRAWKA: Standardowa ikona
                            icon: Icon(Icons.delete_outline, color: Colors.red.shade300),
                            onPressed: () => _deleteTask(doc.id),
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}