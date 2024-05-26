import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:efficiently/providers/todo_provider.dart';
import 'package:efficiently/models/todo.dart';
import 'package:efficiently/models/category.dart'; // Importujte model kategorií

class AddToDoScreen extends StatefulWidget {
  @override
  _AddToDoScreenState createState() => _AddToDoScreenState();
}

class _AddToDoScreenState extends State<AddToDoScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _description = '';
  DateTime _dueDate = DateTime.now();
  late Category _selectedCategory; // Vybraná kategorie

  @override
  void initState() {
    super.initState();
    _selectedCategory = Category(
        id: 'default',
        title: 'Default',
        icon: Icons.list); // Nastavení výchozí kategorie
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Provider.of<ToDoProvider>(context, listen: false).addToDo(
        ToDo.create(_title, _description, _dueDate,
            _selectedCategory), // Předání vybrané kategorie do konstruktoru ToDo
      );
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Seznam kategorií
    final List<Category> categories = [
      Category(id: 'work', title: 'Work', icon: Icons.work),
      Category(id: 'personal', title: 'Personal', icon: Icons.person),
      // Další kategorie podle potřeby
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Add ToDo'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _title = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description.';
                  }
                  return null;
                },
                onSaved: (value) {
                  _description = value!;
                },
              ),
              SizedBox(height: 20),
              // Dropdown pro výběr kategorie
              DropdownButtonFormField<Category>(
                value: _selectedCategory,
                items: categories.map((category) {
                  return DropdownMenuItem<Category>(
                    value: category,
                    child: Row(
                      children: [
                        Icon(category.icon),
                        SizedBox(width: 5),
                        Text(category.title),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Save'),
                onPressed: _saveForm,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
