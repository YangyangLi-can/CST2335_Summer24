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
      home: const TodoListPage(),
    );
  }
}

class TodoItem {
  String text;
  bool isFinished;

  TodoItem(this.text, this.isFinished);
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final List<TodoItem> _todoItems = [];
  final TextEditingController _textFieldController = TextEditingController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textFieldController,
                    decoration: const InputDecoration(
                      hintText: 'Enter a todo item',
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: _addTodoItem,
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          Expanded(
            child: _buildTodoList(),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Current',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done_all),
            label: 'Finished',
          ),
        ],
      ),
    );
  }

  Widget _buildTodoList() {
    final filteredItems = _todoItems.where((item) =>
    item.isFinished == (_currentIndex == 1)).toList();

    return ListView.builder(
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return ListTile(
          leading: Checkbox(
            value: item.isFinished,
            onChanged: (bool? value) {
              setState(() {
                item.isFinished = value!;
              });
            },
          ),
          title: Text(item.text),
          onLongPress: _currentIndex == 1
              ? () => _showDeleteDialog(item)
              : null,
        );
      },
    );
  }

  void _addTodoItem() {
    setState(() {
      _todoItems.add(TodoItem(_textFieldController.text, false));
      _textFieldController.clear();
    });
  }

  void _showDeleteDialog(TodoItem item) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Item'),
          content: const Text('Are you sure you want to delete this item?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('No'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _todoItems.remove(item);
                });
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