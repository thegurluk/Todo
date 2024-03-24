import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/models/todo_model.dart';
import 'package:to_do_list/providers/todo_list_manager.dart';
import 'package:uuid/uuid.dart';

enum TodoListFilter { all, active, completed }

final todoListFilter =
    StateProvider<TodoListFilter>((ref) => TodoListFilter.all);

final todoListProvider =
    StateNotifierProvider<TodoListManager, List<TodoModel>>((ref) {
  return TodoListManager([
    TodoModel(id: const Uuid().v4(), description: "spora git"),
    TodoModel(id: const Uuid().v4(), description: "alışveriş yap"),
    TodoModel(id: const Uuid().v4(), description: "koiuya çık"),
  ]);
});

final filteredTodoList = Provider<List<TodoModel>>((ref) {
  final filter = ref.watch(todoListFilter);
  final todoList = ref.watch(todoListProvider);

  switch (filter) {
    case TodoListFilter.all:
      return todoList;
    case TodoListFilter.active:
      return todoList.where((todo) => !todo.completed).toList();
    case TodoListFilter.completed:
      return todoList.where((todo) => todo.completed).toList();
  }
});

final unCompletedTodoCount = Provider<int>((ref) {
  final allTodo = ref.watch(todoListProvider);
  final count = allTodo.where((element) => !element.completed).length;
  return count;
});

final currentTodoProvider = Provider<TodoModel>((ref) {
  throw UnimplementedError();
});
