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
    final size = MediaQuery.of(context).size;
    final isLandscape = size.width > size.height;
    final isTablet = size.shortestSide >= 600 && size.width > 720;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          if (_selectedItem != null)
            IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => setState(() => _selectedItem = null),
            ),
        ],
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
                Expanded(
                  flex: 1,
                  child: _buildTodoList(),
                ),
                Expanded(
                  flex: 2,
                  child: _selectedItem != null
                      ? _buildDetailsPage()
                      : const Center(child: Text('Select an item')),
                ),
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
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _todoItems.remove(_selectedItem);
                _selectedItem = null;
              });
            },
            child: const Text('Delete'),
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