import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_project/model/todo_item.dart';
import 'package:riverpod_project/providers/providers.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(32),
          child: ListTile(
            title: const Text("TODO LIST"),
            trailing: IconButton(
              onPressed: () async {
                TodoItem item = TodoItem(title: "");
                await _getBottomSheet(
                  context: context,
                  item: item,
                  ref: ref,
                );
              },
              icon: const Icon(
                Icons.add,
              ),
            ),
          ),
        ),
      ),
      body: ref.watch(todoProvider).items.isEmpty
          ? const ListTile(
              title: Text("No todo for now"),
            )
          : ListView.builder(
              itemCount: ref.watch(todoProvider).items.length,
              itemBuilder: (context, index) {
                TodoItem item = ref.watch(todoProvider).items[index];
                return GestureDetector(
                  onLongPress: () async {
                    await _getBottomSheet(
                      context: context,
                      item: item,
                      ref: ref,
                      add: false,
                    );
                  },
                  child: CheckboxListTile(
                    title: Text(
                      item.title ?? "",
                    ),
                    value: item.completed,
                    onChanged: (v) {
                      ref.read(todoProvider).toggle(item);
                    },
                  ),
                );
              },
            ),
    );
  }

  Future _getBottomSheet({
    required BuildContext context,
    required WidgetRef ref,
    required TodoItem item,
    bool add = true,
  }) async {
    await showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (context) {
        if (add) {
          return Column(
            children: [
              Container(
                margin: const EdgeInsets.all(8),
                child: TextField(
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Add new item",
                  ),
                  controller: TextEditingController(),
                  onChanged: (v) {
                    item.title = v;
                  },
                ),
              ),
              OutlinedButton(
                onPressed: () {
                  ref.read(todoProvider).add(item);
                  Navigator.pop(context);
                },
                child: const Text("Add"),
              )
            ],
          );
        }

        return Column(
          children: [
            const ListTile(
              title: Text("Remove this task?"),
            ),
            OutlinedButton(
              onPressed: () {
                ref.read(todoProvider).remove(item);
                Navigator.pop(context);
              },
              child: const Text("Remove"),
            )
          ],
        );
      },
    );
  }
}
