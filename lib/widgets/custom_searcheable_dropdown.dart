import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchableDropdownController<T> extends GetxController {
  SearchableDropdownController({
    List<T>? initialItems,
    this.remoteSearch,
    required this.itemLabel,
    this.itemMatchesQuery,
  }) {
    if (initialItems != null) items.assignAll(initialItems);
    filtered.assignAll(items);
    ever<List<T>>(items, (_) => _applyFilterNow());
    ever<String>(query, (_) => _debounceFilter());
  }

  final items = <T>[].obs;          // fonte de dados
  final filtered = <T>[].obs;       // lista filtrada
  final selected = Rxn<T>();        // item selecionado
  final query = ''.obs;             // texto de busca
  final loading = false.obs;        // flag de carregamento remoto

  final Future<List<T>> Function(String q)? remoteSearch;
  final String Function(T item) itemLabel;
  final bool Function(T item, String q)? itemMatchesQuery;

  Timer? _debounce;

  void setItems(List<T> newItems) => items.assignAll(newItems);
  void clearSelection() => selected.value = null;
  void select(T value) => selected.value = value;

  void _debounceFilter() {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 250), _applyFilterNow);
  }

  Future<void> _applyFilterNow() async {
    final q = query.value.trim();
    if (remoteSearch != null) {
      loading.value = true;
      try {
        final res = await remoteSearch!.call(q);
        filtered.assignAll(res);
      } finally {
        loading.value = false;
      }
      return;
    }
    if (q.isEmpty) {
      filtered.assignAll(items);
      return;
    }
    final lower = q.toLowerCase();
    final matcher = itemMatchesQuery ??
        (T item, String _) => itemLabel(item).toLowerCase().contains(lower);
    filtered.assignAll(items.where((e) => matcher(e, q)));
  }
}

class SearchableDropdown<T> extends StatelessWidget {
  const SearchableDropdown({
    super.key,
    required this.controller,
    required this.labelText,
    this.hintText = 'Selecionar...',
    this.emptyText = 'Nenhum item encontrado',
    this.enabled = true,
    this.clearable = true,
    this.onChanged,
    this.leadingIcon,
  });

  final SearchableDropdownController<T> controller;
  final String labelText;
  final String hintText;
  final String emptyText;
  final bool enabled;
  final bool clearable;
  final void Function(T? value)? onChanged;
  final Widget? leadingIcon;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final label = controller.selected.value == null
          ? hintText
          : controller.itemLabel(controller.selected.value as T);

      return InkWell(
        onTap: enabled ? () => _openSheet(context) : null,
        borderRadius: BorderRadius.circular(8),
        child: InputDecorator(
          decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            prefixIcon: leadingIcon,
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (clearable && controller.selected.value != null)
                  IconButton(
                    icon: const Icon(Icons.clear),
                    tooltip: 'Limpar',
                    onPressed: enabled
                        ? () {
                            controller.clearSelection();
                            onChanged?.call(null);
                          }
                        : null,
                  ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: controller.selected.value == null
                  ? Theme.of(context).hintColor
                  : null,
            ),
          ),
        ),
      );
    });
  }

  Future<void> _openSheet(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (ctx) {
        final textCtrl = TextEditingController(text: controller.query.value);
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.75,
          minChildSize: 0.5,
          maxChildSize: 0.95,
          builder: (_, scrollCtrl) {
            return Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Text(labelText, style: Theme.of(ctx).textTheme.titleLarge),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => Navigator.of(ctx).pop(),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    controller: textCtrl,
                    onChanged: (v) => controller.query.value = v,
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search),
                      hintText: 'Buscar...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: Obx(() {
                      if (controller.loading.value) {
                        return const Center(child: CircularProgressIndicator());
                      }
                      if (controller.filtered.isEmpty) {
                        return Center(child: Text(emptyText));
                      }
                      return ListView.separated(
                        controller: scrollCtrl,
                        itemCount: controller.filtered.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (_, i) {
                          final item = controller.filtered[i];
                          final isSelected = controller.selected.value == item;
                          return ListTile(
                            title: Text(controller.itemLabel(item)),
                            trailing: isSelected ? const Icon(Icons.check) : null,
                            onTap: () {
                              controller.select(item);
                              onChanged?.call(item);
                              Navigator.of(ctx).pop();
                            },
                          );
                        },
                      );
                    }),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}