import 'package:flutter/material.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TodoListPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final List<String> _todoItems = [];
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(
                hintText: 'Enter a todo item',
              ),
            ),
          ),
          Expanded(
            child: _todoItems.isEmpty
                ? const Center(
              child: Text('There are no items in the list'),
            )
                : ListView.builder(
              itemCount: _todoItems.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  leading: Text('Row number: $index'),
                  title: Text(_todoItems[index]),
                  onLongPress: () {
                    _showDeleteConfirmationDialog(context, index);
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addTodoItem,
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addTodoItem() {
    setState(() {
      _todoItems.add(_textFieldController.text);
      _textFieldController.clear();
    });
  }

  void _deleteItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _showDeleteConfirmationDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Todo'),
          content: const Text('Are you sure you want to delete this todo item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                _deleteItem(index);
                Navigator.of(context).pop();
              },
              child: const Text('Yes'),
            ),
          ],
        );
      },
    );
  }
}