import 'package:floor/floor.dart';

@entity
class Todo {
  @primaryKey
  final int? id;

  final String content;

  Todo(this.id, this.content);
}

@dao
abstract class TodoDao {
  @Query('SELECT * FROM Todo')
  Future<List<Todo>> findAllTodos();

  @insert
  Future<void> insertTodo(Todo todo);

  @Query('DELETE FROM Todo WHERE id = :id')
  Future<void> deleteTodo(int id);
}