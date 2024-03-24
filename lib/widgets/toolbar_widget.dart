import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do_list/providers/all_providers.dart';

class ToolBarWidget extends ConsumerWidget {
  ToolBarWidget({super.key});
  var _currentFilter = TodoListFilter.all;

  Color changeTextColor(TodoListFilter filt) {
    return _currentFilter == filt ? Colors.orange : Colors.black;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final onCompletedTodoCount = ref.watch(unCompletedTodoCount);
    _currentFilter = ref.watch(todoListFilter);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "$onCompletedTodoCount görev tamamlanmadı",
            overflow: TextOverflow.ellipsis,
          ),
        ),
        Tooltip(
          message: 'All Todos',
          child: TextButton(
            onPressed: () {
              ref.read(todoListFilter.notifier).state = TodoListFilter.all;
            },
            style: TextButton.styleFrom(
                foregroundColor: changeTextColor(TodoListFilter.all)),
            child: const Text('All'),
          ),
        ),
        Tooltip(
          message: 'Only Uncompleted Todos',
          child: TextButton(
            onPressed: () {
              ref.read(todoListFilter.notifier).state = TodoListFilter.active;
            },
            style: TextButton.styleFrom(
                foregroundColor: changeTextColor(TodoListFilter.active)),
            child: const Text('Active'),
          ),
        ),
        Tooltip(
          message: 'Only Completed Todos',
          child: TextButton(
            onPressed: () {
              ref.read(todoListFilter.notifier).state =
                  TodoListFilter.completed;
            },
            style: TextButton.styleFrom(
                foregroundColor: changeTextColor(TodoListFilter.completed)),
            child: const Text('Completed'),
          ),
        ),
      ],
    );
  }
}
