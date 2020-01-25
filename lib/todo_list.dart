import 'package:flutter/material.dart';
import 'todo.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}
class _TodoListState extends State<TodoList> {
  // create array for all list box
  List<Todo> todos = [];
  TextEditingController controller = new TextEditingController();
  // declear variable _toggleTodo 
    _toggleTodo(Todo todo, bool isChecked) {
        setState(() {
        todo.isDone = isChecked;
    });
   }
   //implement _buildItem for call eacht time todo 
    Widget _buildItem(BuildContext context, int index) {
     final todo = todos[index];
    return CheckboxListTile(
      value: todo.isDone,
      title: Text(todo.title),
       onChanged: (bool isChecked) {
       _toggleTodo(todo, isChecked);
      },
     );
   }
     // add todo and showdialog
        _addTodo()  {
    showDialog<Todo>(
       context: context,
       builder: (BuildContext context) {
        return AlertDialog(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0)
          ),
          title: Text('New todo'),
            content: TextField(
            controller: controller,
            autofocus: true,
           ),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
               onPressed: () {
               Navigator.of(context).pop();
              },    
            ),
            FlatButton(
              child: Text("Add", style: TextStyle(color: Colors.blue),),
              onPressed: () {
              setState(() {
              final todo = new Todo(title: controller.value.text);
              // it will clear if we click press 
                if(controller.value.text ==""){
                  print("");
                }else{
                todos.add(todo);
                }
                controller.clear();
                Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
       },
     );
   } 
  @override
  Widget build(BuildContext context) {
      return Scaffold(
       appBar: AppBar(title: Text('Todo List')),
       body: ListView.builder(
           itemBuilder: _buildItem,
           itemCount: todos.length,
       ),
       floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
         onPressed: _addTodo,
       ),
      );
  }
}