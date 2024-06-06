import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple To-Do List',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TodoListPage(),
    );
  }
}

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<String> _todoItems = [];

  void _addTodoItem(String task) {
    if (task.isNotEmpty) {
      setState(() {
        _todoItems.add(task);
      });
    }
  }

  void _editTodoItem(int index, String newTask) {
    if (newTask.isNotEmpty) {
      setState(() {
        _todoItems[index] = newTask;
      });
    }
  }

  void _deleteTodoItem(int index) {
    setState(() {
      _todoItems.removeAt(index);
    });
  }

  void _promptAddTodoItem() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String newTask = '';
        return AlertDialog(
          title: Text('Add a new task'),
          content: TextField(
            onChanged: (value) {
              newTask = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                _addTodoItem(newTask);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _promptEditTodoItem(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String editedTask = _todoItems[index];
        return AlertDialog(
          title: Text('Edit task'),
          content: TextField(
            controller: TextEditingController(text: editedTask),
            onChanged: (value) {
              editedTask = value;
            },
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Save'),
              onPressed: () {
                _editTodoItem(index, editedTask);
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildTodoItem(String todoText, int index) {
    return ListTile(
      title: Text(todoText),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () => _promptEditTodoItem(index),
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: () => _deleteTodoItem(index),
          ),
        ],
      ),
    );
  }

  Widget _buildTodoList() {
    return ListView.builder(
      itemCount: _todoItems.length,
      itemBuilder: (context, index) {
        return _buildTodoItem(_todoItems[index], index);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Simple To-Do List'),
      ),
      body: _buildTodoList(),
      floatingActionButton: FloatingActionButton(
        onPressed: _promptAddTodoItem,
        tooltip: 'Add task',
        child: Icon(Icons.add),
      ),
    );
  }
}
