//Fake Sever
import '../models/todo.dart';

abstract class Repository{
  //get
  Future<List<Todo>> getTodoList();
  // patch
  Future<String>patchCompleted(Todo todo);
  // put
  Future<String>putCompleted(Todo todo);
  //detele
  Future<String>deleteTodo(Todo todo);
  //post
  Future<String>postTodo(Todo todo);

}
