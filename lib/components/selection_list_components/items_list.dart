import 'package:flutter/material.dart';
import 'package:matches/components/empty_space.dart';
import 'package:matches/models/selection_list_item_model.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({
    super.key,
    required this.items,
    this.showLeadingWidget,
    this.leadingWidget,
    this.showTrailingIcon,
    this.onSelectTile,
    required this.closeAfterChoice,
  });

  final List<SelectionListItemModel> items;
  final bool Function(SelectionListItemModel)? showLeadingWidget;
  final Widget? Function(SelectionListItemModel)? leadingWidget;
  final bool Function(SelectionListItemModel)? showTrailingIcon;
  final Function(String?)? onSelectTile;
  final bool closeAfterChoice;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (builder, index) {
          return const Divider();
        },
        shrinkWrap: true,
        itemBuilder: (builder, index) {
          SelectionListItemModel data = items[index];

          bool showLeading = false;
          if (showLeadingWidget != null) {
            showLeading = showLeadingWidget!(data);
          }

          bool showLock = false;
          if (showTrailingIcon != null) {
            showLock = showTrailingIcon!(data);
          }

          return ListTile(
            leading: Visibility(
              visible: showLeading,
              child: leadingWidget != null
                  ? leadingWidget!(data)!
                  : const EmptySpace(),
            ),
            trailing: Visibility(
              visible: showLock,
              child: const Icon(Icons.lock_outline),
            ),
            onTap: () async {
              if (showLock == true) {
                return;
              }
              //ritorno il valore selezionato
              if (onSelectTile != null) {
                await onSelectTile!(data.key);
              }
              if (context.mounted && closeAfterChoice) {
                Navigator.of(context).pop(data.key);
              }
            },
            title: Text("${data.value}"),
            subtitle:
                data.description != null ? Text("${data.description}") : null,
          );
        },
        itemCount: items.length,
      ),
    );
  }
}
