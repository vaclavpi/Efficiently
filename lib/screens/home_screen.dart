import 'package:efficiently/widgets/todo_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:efficiently/providers/todo_provider.dart';
import 'package:efficiently/models/todo.dart';
import 'package:efficiently/models/category.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<ToDo> _filteredTodos; // Seznam filtrovaných úkolů
  late Category _selectedCategory; // Vybraná kategorie

  @override
  void initState() {
    super.initState();
    _filteredTodos = Provider.of<ToDoProvider>(context, listen: false)
        .todos; // Nastavení výchozího seznamu úkolů
    _selectedCategory = Category(
        id: 'all',
        title: 'All',
        icon: Icons.list); // Nastavení výchozí kategorie na "Vše"
  }

  void _filterTodosByCategory(Category category) {
    setState(() {
      _selectedCategory = category;
      if (category.id == 'all') {
        _filteredTodos = Provider.of<ToDoProvider>(context, listen: false)
            .todos; // Pokud je vybrána kategorie "Vše", zobrazí se všechny úkoly
      } else {
        _filteredTodos = Provider.of<ToDoProvider>(context, listen: false)
            .todos
            .where((todo) => todo.category.id == category.id)
            .toList(); // Filtrování úkolů podle vybrané kategorie
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Seznam kategorií
    final categories = [
      Category(id: 'all', title: 'All', icon: Icons.list), // Kategorie "Vše"
      Category(id: 'work', title: 'Work', icon: Icons.work), // Kategorie "Work"
      Category(
          id: 'personal',
          title: 'Personal',
          icon: Icons.person), // Kategorie "Personal"
      // Další kategorie podle potřeby
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Efficiently'),
      ),
      body: Column(
        children: <Widget>[
          // Tlačítka pro výběr kategorií
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: categories.map((category) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: ElevatedButton(
                    onPressed: () => _filterTodosByCategory(category),
                    child: Row(
                      children: [
                        Icon(category.icon),
                        SizedBox(width: 5),
                        Text(category.title),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          // Seznam filtrovaných úkolů
          Expanded(
            child: ListView.builder(
              itemCount: _filteredTodos.length,
              itemBuilder: (context, index) {
                return ToDoItem(_filteredTodos[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
