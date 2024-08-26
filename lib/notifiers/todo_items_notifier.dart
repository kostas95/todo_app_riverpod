import 'dart:convert';
import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:riverpod_project/model/todo_item.dart';
import 'package:uuid/uuid.dart';

class TodoItemsNotifier extends ChangeNotifier {
  final List<TodoItem> _items = <TodoItem>[];
  static const _itemsKey = 'todo_items';

  TodoItemsNotifier() {
    _loadItems();
  }

  UnmodifiableListView<TodoItem> get items => UnmodifiableListView(_items);

  Future<void> add(TodoItem item) async {
    item.id = const Uuid().v4();
    _items.add(item);
    await _saveItems();
    notifyListeners();
  }

  Future<void> remove(TodoItem item) async {
    _items.remove(item);
    await _saveItems();
    notifyListeners();
  }

  Future<void> toggle(TodoItem item) async {
    item.completed = !item.completed;
    await _saveItems();
    notifyListeners();
  }

  Future<void> clear() async {
    _items.clear();
    await _saveItems();
    notifyListeners();
  }

  Future<void> update(TodoItem item) async {
    // Implementation for updating items can be added here if needed
    await _saveItems();
    notifyListeners();
  }

  Future<void> _saveItems() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = _items.map((item) => item.toJson()).toList();
    await prefs.setString(_itemsKey, jsonEncode(jsonList));
  }

  Future<void> _loadItems() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_itemsKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = jsonDecode(jsonString);
      _items.clear();
      _items.addAll(
        jsonList.map(
          (json) => TodoItem.fromJson(json),
        ),
      );
      notifyListeners();
    }
  }
}
