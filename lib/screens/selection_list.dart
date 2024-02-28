import 'package:flutter/material.dart';
import 'package:matches/components/palladio_std_components/palladio_app_bar.dart';
import 'package:matches/components/palladio_std_components/palladio_body.dart';
import 'package:matches/components/search_bar_row.dart';
import 'package:matches/components/selection_list_components/items_list.dart';
import 'package:matches/models/selection_list_item_model.dart';
import 'package:matches/styles.dart';

class SelectionListPage extends StatefulWidget {
  const SelectionListPage(
      {super.key,
      required this.title,
      required this.listOfItems,
      this.onSelectTile,
      this.onDisposed,
      this.closeAfterChoice = true,
      this.actionWidget,
      this.showLeadingWidget,
      this.leadingWidget,
      this.showTrailingIcon,
      this.showScanButton = true,
      this.autofocus = true,
      this.onAddItem});

  final String title;
  final List<SelectionListItemModel> listOfItems;
  final Function(String?)? onSelectTile;
  final VoidCallback? onDisposed;
  final bool closeAfterChoice;
  final Widget? actionWidget;
  final bool Function(SelectionListItemModel)? showLeadingWidget;
  final Widget? Function(SelectionListItemModel)? leadingWidget;
  final bool Function(SelectionListItemModel)? showTrailingIcon;
  final bool showScanButton;
  final bool autofocus;
  final Function? onAddItem;

  @override
  State<SelectionListPage> createState() => _SelectionListPageState();
}

class _SelectionListPageState extends State<SelectionListPage> {
  TextEditingController editingController = TextEditingController();

  List<SelectionListItemModel> items = [];

  void filterSearchResults(String query) {
    setState(() {
      items = widget.listOfItems
          .where(
              (item) => item.value!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  void initState() {
    super.initState();
    items = widget.listOfItems;
  }

  @override
  void dispose() {
    if (widget.onDisposed != null) {
      widget.onDisposed!();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PalladioAppBar(
        title: widget.title,
        actions: widget.actionWidget != null ? [widget.actionWidget!] : null,
        backgroundColor: canvasColor,
      ),
      body: PalladioBody(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SearchBarRow(
                label: 'Cerca',
                searchBarTextController: editingController,
                onSearch: () {
                  filterSearchResults(editingController.text);
                },
                onChanged: (query) {
                  filterSearchResults(query);
                },
                showScanButton: widget.showScanButton,
                forcedKeyboardText: true,
                onScanned: () async {},
                focusNode: FocusNode(),
                autofocus: widget.autofocus,
              ),
              ItemsList(
                  items: items,
                  showLeadingWidget: widget.showLeadingWidget,
                  showTrailingIcon: widget.showTrailingIcon,
                  leadingWidget: widget.leadingWidget,
                  onSelectTile: widget.onSelectTile,
                  closeAfterChoice: widget.closeAfterChoice)
            ],
          ),
        ),
      ),
      floatingActionButton: Visibility(
        visible: widget.onAddItem != null,
        child: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            if (widget.onAddItem != null) {
              await widget.onAddItem!();
            }
          },
        ),
      ),
    );
  }
}
