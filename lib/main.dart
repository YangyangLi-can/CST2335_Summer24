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
  String id;
  String text;
  bool isFinished;

  TodoItem(this.id, this.text, this.isFinished);
}

class TodoListPage extends StatefulWidget {
  const TodoListPage({Key? key}) : super(key: key);

  @override
  State<TodoListPage> createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  final List<TodoItem> _todoItems = [];
  final TextEditingController _textFieldController = TextEditingController();
  TodoItem? _selectedItem;

  @override
  Widget build(BuildContext context) {
    final isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    final isTablet = MediaQuery.of(context).size.shortestSide >= 600;

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
            child: isLandscape && isTablet
                ? Row(
              children: [
                Expanded(child: _buildTodoList()),
                if (_selectedItem != null)
                  Expanded(child: _buildDetailsPage()),
              ],
            )
                : _selectedItem == null
                ? _buildTodoList()
                : _buildDetailsPage(),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todoItems.length,
      itemBuilder: (context, index) {
        final item = _todoItems[index];
        return ListTile(
          title: Text(item.text),
          onTap: () => setState(() => _selectedItem = item),
        );
      },
    );
  }

  Widget _buildDetailsPage() {
    if (_selectedItem == null) {
      return const Center(child: Text('No item selected'));
    }
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Item: ${_selectedItem!.text}'),
          Text('ID: ${_selectedItem!.id}'),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _todoItems.remove(_selectedItem);
                _selectedItem = null;
              });
            },
            child: const Text('Delete'),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _selectedItem = null);
            },
            child: const Text('Back to List'),
          ),
        ],
      ),
    );
  }

  void _addTodoItem() {
    if (_textFieldController.text.isNotEmpty) {
      final newItem = TodoItem(
        DateTime.now().millisecondsSinceEpoch.toString(),
        _textFieldController.text,
        false,
      );
      setState(() {
        _todoItems.add(newItem);
        _textFieldController.clear();
      });
    }
  }
}