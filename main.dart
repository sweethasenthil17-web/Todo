import 'package:flutter/material.dart';

void main() {
  runApp(const MyTodoApp());
}

class MyTodoApp extends StatelessWidget {
  const MyTodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TODO App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: const TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<String> _tasks = [];

  void _addTask() {
    showDialog(
      context: context,
      builder: (context) {
        String newTask = '';
        return AlertDialog(
          title: const Text('Add Task'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: 'Enter task'),
            onChanged: (value) {
              newTask = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close dialog
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (newTask.trim().isNotEmpty) {
                  setState(() {
                    _tasks.add(newTask.trim());
                  });
                  Navigator.of(context).pop(); // Close dialog
                }
              },
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.pink[50],
      appBar: AppBar(
        title: const Text('TODO Task Manager'),
        backgroundColor: Colors.deepPurple[200],
      ),
      body: Center(
        child: _tasks.isEmpty
            ? const Text(
                'No tasks added.',
                style: TextStyle(fontSize: 18),
              )
            : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    child: ListTile(
                      title: Text(_tasks[index]),
                      trailing: IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          setState(() {
                            _tasks.removeAt(index);
                          });
                        },
                      ),
                    ),
                  );
                },
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTask,
        backgroundColor: Colors.deepPurple[200],
        child: const Icon(Icons.add),
      ),
    );
  }
}