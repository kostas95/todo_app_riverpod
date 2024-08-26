import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_project/notifiers/todo_items_notifier.dart';

final ChangeNotifierProvider<TodoItemsNotifier> todoProvider = ChangeNotifierProvider<TodoItemsNotifier>(
  (ref) {
    return TodoItemsNotifier();
  },
);
