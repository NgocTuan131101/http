import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repositorypatterm/controller/todo_controller.dart';
import 'package:repositorypatterm/repository/todo_repository.dart';

import '../models/todo.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // dependency injection
    var todoController = TodoController(TodoRepository());
    return Scaffold(
      appBar: AppBar(
        title: Text("API"),
      ),
      body: FutureBuilder<List<Todo>>(
        future: todoController.fetchTodoList(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(
              child: Text("error"),
            );
          }
          return buildBodyContent(snapshot, todoController);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          //make post call
          // temp data
          Todo todo = Todo(userId: 3, title: 'sample post', completed: false);
        },
        child: Icon(Icons.add),
      ),
    );
  }

  SafeArea buildBodyContent(
      AsyncSnapshot<List<Todo>> snapshot, TodoController todoController) {
    return SafeArea(
      child: ListView.separated(
          itemBuilder: (context, index) {
            var todo = snapshot.data?[index];
            return Container(
              height: 100.0,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: [
                  Expanded(child: Text('${todo?.id}')),
                  Expanded(child: Text('${todo?.title}')),
                  Expanded(
                      flex: 3,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          InkWell(
                              onTap: () {
                                // make snackbar
                                todoController
                                    .updatePatchCompleted(todo!)
                                    .then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration:
                                          const Duration(microseconds: 500),
                                      content: Text('$value'),
                                    ),
                                  );
                                });
                              },
                              child: buildCallContainer(
                                  'patch', Color(0xFFFFE0B2))),
                          InkWell(
                              onTap: () {
                                // make snackbar
                                todoController.updatePutCompleted(todo!);
                              },
                              child:
                                  buildCallContainer('put', Color(0xFFE1BEE7))),
                          InkWell(
                              onTap: () {
                                // make snackbar
                                todoController.deteTodo(todo!).then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      duration:
                                          const Duration(microseconds: 500),
                                      content: Text('$value'),
                                    ),
                                  );
                                });
                              },
                              child: buildCallContainer(
                                  'delete', Color(0xFFFFCDD2))),
                        ],
                      ))
                ],
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Divider(
              thickness: 0.5,
              height: 0.5,
            );
          },
          itemCount: snapshot.data?.length ?? 0),
    );
  }

  Container buildCallContainer(String title, Color color) {
    return Container(
      width: 40.0,
      height: 40.0,
      decoration: BoxDecoration(
          color: Colors.orange, borderRadius: BorderRadius.circular(10.0)),
      child: Center(child: Text('$title')),
    );
  }
}
