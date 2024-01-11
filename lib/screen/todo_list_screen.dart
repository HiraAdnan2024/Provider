
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_using_provider/provider/todo_provider.dart';

class TodoListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo List'),
        actions: [
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: () {
              showSortDialog(context);
            },
          ),
        ],
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          return ListView.builder(
            itemCount: todoProvider.todos.length,
            itemBuilder: (context, index) {
              var todo = todoProvider.todos[index];
              return ListTile(
                title: Text(todo.title),
                leading: Checkbox(
                  value: todo.isCompleted,
                  onChanged: (value) {
                    todoProvider.toggleComplete(index);
                  },
                ),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    todoProvider.removeTodo(index);
                  },
                ),
                onTap: () {
                  showEditDialog(context, index, todo.title);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showAddDialog(context);
        },
        child: Icon(Icons.add),
      ),
    );
  }
  void showAddDialog(BuildContext context) {
    TextEditingController titleController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Todo'),
          content: TextFormField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Todo Title'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Provider.of<TodoProvider>(context, listen: false).addTodo(titleController.text);
                Navigator.pop(context);
              },
              child: Text('Add'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void showEditDialog(BuildContext context, int index, String currentTitle) {
    TextEditingController titleController = TextEditingController(text: currentTitle);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Todo'),
          content: TextFormField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Todo Title'),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Provider.of<TodoProvider>(context, listen: false).editTodo(index, titleController.text);
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  void showSortDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Sort Todos'),
          content: Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  Provider.of<TodoProvider>(context, listen: false).sortTodos(true);
                  Navigator.pop(context);
                },
                child: Text('Completed First'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}