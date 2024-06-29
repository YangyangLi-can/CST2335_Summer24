import 'package:cst2335_summer24/model.dart';
import 'package:flutter/material.dart';
import 'package:floor/floor.dart';
import 'dart:async';

// Import the generated database file
import 'database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  runApp(TodoApp(database: database));
}

class TodoApp extends StatelessWidget {
  final AppDatabase database;

  const TodoApp({Key? key, required this.database}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListPage(title: 'Flutter Demo Home Page', database: database),
    );
  }
}

class TodoListPage extends StatefulWidget {
  final String title;
  final AppDatabase database;

  const TodoListPage({Key? key, required this.title, required this.database}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<Todo> _todoItems = [];
  final TextEditingController _textFieldController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  Future<void> _loadTodos() async {
    final todos = await widget.database.todoDao.findAllTodos();
    setState(() {
      _todoItems = todos;
    });
  }

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
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: _addTodoItem,
                  child: const Text('Add'),
                ),
                const SizedBox(width: 8.0),
                Expanded(
                  child: TextField(
                    controller: _textFieldController,
                    decoration: const InputDecoration(
                      hintText: 'Enter a todo item',
                    ),
                  ),
                ),
              ],
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
                  title: Text(_todoItems[index].content),
                  onLongPress: () {
                    _showDeleteConfirmationDialog(context, index);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _addTodoItem() async {
    final newTodo = Todo(null, _textFieldController.text);
    await widget.database.todoDao.insertTodo(newTodo);
    _textFieldController.clear();
    _loadTodos();
  }

  Future<void> _deleteItem(int index) async {
    final todoToDelete = _todoItems[index];
    await widget.database.todoDao.deleteTodo(todoToDelete.id!);
    _loadTodos();
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